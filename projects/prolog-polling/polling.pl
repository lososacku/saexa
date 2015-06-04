% Copyright 2015 Ryan B. Hicks

:- dynamic(analysis_uuid/1).

:- module(polling, [ack/1, analysis_uuid/1]).
:- consult(base64).
:- consult('../prolog-curl/host').
:- consult('../prolog-curl/pcurl').
:- consult('../prolog-nlp/nlp').
:- consult(string).
:- consult(basics).

:- import get_post_lines/1, put_nlp_results/2, extract_prolog_actions/2 from pcurl.
:- import str_match/5, substring/4, atom_to_term/2, read_atom_to_term/2 from string.
:- import length/2, append/3 from basics.
:- import process_post/2, nlp_result/1, ignore/1, add_facebook_first_name/1 from nlp.
:- import base64/2 from base64.

:- export process_line/1.

poll :- write('...polling...'),
        nl,
        get_post_lines(PostLinesResponse),
        write('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'),
        nl,
%        write(PostLinesResponse),
        nl,
        ignore(process_prolog_actions(PostLinesResponse)),
        sleep(3),
        poll.

get_post_processing_lines(PostLinesResponse, PostProcessingLines)
:-
str_match('post-processing-lines : "', PostLinesResponse, forw, _, FirstIndex),
str_match('\n"}', PostLinesResponse, rev, LastIndex, _),
substring(PostLinesResponse, FirstIndex, LastIndex, PostProcessingLines).

get_post_processing_lines_name(PostLinesResponse, PostProcessingLinesName)
:-
% this sucks, for some reason 'str_match' is poorly documented; it's
% either broken or severely limited. the only good news is that
% these offets are actually fixed
%% rbh
% check to see if this is related to the unicode escaping
% chincanery
substring(PostLinesResponse, 50, 86, PostProcessingLinesName).
:- export get_post_processing_lines_name/2.

process_prolog_actions('{status: "wait"}').
process_prolog_actions(PostLinesResponse) :-
    get_post_processing_lines(PostLinesResponse, PostProcessingLines),
    get_post_processing_lines_name(PostLinesResponse, PostProcessingLinesName),
    extract_prolog_actions(PostProcessingLines, PrologActions),
    write('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'),
    nl,
    ignore(process_prolog_lines(PrologActions)),
    write('<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<'),
    nl,
    nlp_result(NlpResultLines),
    fmt_write_string(NlpResults, "%s\n%s", args(PostProcessingLines, NlpResultLines)),
    base64(NlpResults, NlpResultsBase64),
    put_nlp_results(PostProcessingLinesName, NlpResultsBase64).

process_prolog_lines([]).
process_prolog_lines(Lines) :- str_match('\n', Lines, forw, NewlineStart, NewlineEnd),
                               substring(Lines, 0, NewlineStart, CurrentLine),
                               %atom_to_term(CurrentLine, PrologTerm),
                               read_atom_to_term(CurrentLine, PrologTerm),
                               PrologTerm,
                               substring(Lines, NewlineEnd, -1, RemainingLines),
                               process_prolog_lines(RemainingLines).


:- poll.

