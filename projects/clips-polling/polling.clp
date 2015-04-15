; Copyright 2015 Ryan B. Hicks

(defglobal                       ?*host*          = "http://localhost:53535"
                                 ?*left-marker*   = "nlp-results-data-lines : \"")
(defglobal PRIMARY               ?*host*          = "http://localhost:53535")
(defglobal SECONDARY             ?*host*          = "http://localhost:53535")
(defglobal TERTIARY              ?*host*          = "http://localhost:53535")
(defglobal RAISE-AND-REPORT      ?*host*          = "http://localhost:53535")
(defglobal PRIVACY-DILUTION      ?*host*          = "http://localhost:53535")
(defglobal SCOPE-ASSOCIATION     ?*host*          = "http://localhost:53535")
(defglobal SCOPE-DISCOVERABILITY ?*host*          = "http://localhost:53535")
(defglobal IDENTITY-RESOLUTION   ?*host*          = "http://localhost:53535")
(defglobal LEVENSHTEIN-DISTANCE  ?*host*          = "http://localhost:53535")

(defrule MAIN::init
  =>
  (load "../clips-exposure/primary.clp")
  (load "../clips-exposure/secondary.clp")
  (load "../clips-exposure/tertiary.clp")
  (load "../clips-exposure/raise-and-report.clp")
  (load "../clips-exposure/privacy-dilution.clp")
  (load "../clips-exposure/scope-association.clp")
  (load "../clips-exposure/scope-discoverability.clp")
  (load "../clips-exposure/identity-resolution.clp")
  (load "../clips-exposure/levenshtein-distance.clp")

  (focus POLLING))

(defrule POLLING::start-polling
  =>
  (assert(poll)))

(defrule POLLING::poll
  ?poll <- (poll)
  =>
  (printout t "ok" crlf)
  (bind ?nlp-results (get-nlp-results))
  (bind ?decoded-nlp-results (base64-decode ?nlp-results))
  (if (str-index "{status: \"process\"" ?decoded-nlp-results) then
    ; these are fixed offsets
    (bind ?exposure-uuid (sub-string 46 81 ?decoded-nlp-results))
    (make-instance of EXPOSURE-UUID (uuid ?exposure-uuid))
    (bind ?clips-actions (extract-clips-actions
                          (sub-string (+ (str-index ?*left-marker* ?decoded-nlp-results)
                                         (length ?*left-marker*))
                                      ( - (length ?decoded-nlp-results) 3)
                                      ?decoded-nlp-results)))
;    (printout t ?clips-actions crlf)
    ; this is ugly, but 'str-index' doesn't handle escaped 
    ; characters...so, we have to put in a hard newline
    (bind ?currentRightOffset (str-index ")
" ?clips-actions))
    ; (printout t ?clips-actions crlf)
    ; (printout t ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf)
    (while ?currentRightOffset
;      (printout t "---------------------------------------" crlf (sub-string 1 ?currentRightOffset ?clips-actions) crlf)
      ; (printout t "===========================================" crlf)
      (eval (sub-string 1 ?currentRightOffset ?clips-actions))
      ; (printout t
      ;           "-------------------------------------------"
      ;           crlf
      ;           "currentRightOffset: " (+ ?currentRightOffset 2)
      ;           crlf
      ;           "length: " (length ?clips-actions)
      ;           crlf
      ;           "new substring: "
      ;           crlf
      ;           (sub-string (+ ?currentRightOffset 2) (length ?clips-actions) ?clips-actions))
      (bind ?clips-actions (sub-string (+ ?currentRightOffset 2) (length ?clips-actions) ?clips-actions))
      ; (printout t "///////////////////////////////////////////" crlf)
      ; this is ugly, but 'str-index' doesn't handle escaped 
      ; characters...so, we have to put in a hard newline
      (bind ?currentRightOffset (str-index ")
" ?clips-actions))

      ; (printout t "*****************************************" crlf)
)

    ; (printout t "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf)
)
  (focus PRIMARY)
  (sleep 3)
  (retract ?poll)
  (assert (poll))
)

