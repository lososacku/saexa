; Copyright 2015 Ryan B. Hicks

;object for each cell..."bubble"
;
;;
;; i is vertical
;; i is vertical

(defclass LEVENSHTEIN-DISTANCE::STRINGS (is-a USER)
  (slot      horizontal-string      (type LEXEME))
  (slot      vertical-string        (type LEXEME))
  (multislot horizontal-string-chars)
  (multislot vertical-string-chars))

(defclass LEVENSHTEIN-DISTANCE::CELL (is-a USER)
  (slot horizontal-index     (type NUMBER))
  (slot vertical-index       (type NUMBER))
  (slot levenshtein-distance (type NUMBER)))

(deffunction LEVENSHTEIN-DISTANCE::string->char-multifield (?string)
  (bind $?char-multifield (create$))
  (bind ?remaining-string ?string)
  (while (> (str-length ?remaining-string) 0)
    (bind $?char-multifield
          (create$ $?char-multifield
                   (sub-string 1 1 ?remaining-string)))
    (bind ?remaining-string
          (sub-string 2 (str-length ?remaining-string) ?remaining-string)))
  $?char-multifield)

(defrule LEVENSHTEIN-DISTANCE::create-strings
  (object
   (is-a LEVENSHTEIN-DISTANCE)
   (string-0             ?string-0)
   (string-1             ?string-1)
   (levenshtein-distance -1))
  =>
  (make-instance of STRINGS
                    (horizontal-string       ?string-0)
                    (vertical-string         ?string-1)
                    (horizontal-string-chars (string->char-multifield ?string-0))
                    (vertical-string-chars   (string->char-multifield ?string-1))))

(defrule LEVENSHTEIN-DISTANCE::create-cells
  (not
   (object
    (is-a CELL)))
  (object
   (is-a STRINGS)
   (horizontal-string-chars $?horizontal-string-chars)
   (vertical-string-chars   $?vertical-string-chars))
  =>
  ; base 0th value
  (make-instance of CELL
                    (horizontal-index     0)
                    (vertical-index       0)
                    (levenshtein-distance 0))

  ; base horizontal values
  (progn$ (?horizontal-string-char $?horizontal-string-chars)
          (make-instance of CELL
                            (horizontal-index     ?horizontal-string-char-index)
                            (vertical-index       0)
                            (levenshtein-distance ?horizontal-string-char-index)))
  ; base horizontal values 
  (progn$ (?vertical-string-char $?vertical-string-chars)
          (make-instance of CELL
                            (horizontal-index     0)
                            (vertical-index       ?vertical-string-char-index)
                            (levenshtein-distance ?vertical-string-char-index)))


  (progn$ (?horizontal-string-char $?horizontal-string-chars)
     (progn$ (?vertical-string-char   $?vertical-string-chars)
             (make-instance of CELL
                               (horizontal-index     ?horizontal-string-char-index)
                               (vertical-index       ?vertical-string-char-index)
                               (levenshtein-distance -1)))))


; (defrule LEVENSHTEIN-DISTANCE::print-cell
;   (object
;    (is-a CELL)
;    (horizontal-index        ?horizontal-index)
;    (vertical-index          ?vertical-index)
;    (levenshtein-distance    ?levenshtein-distance))
;   =>
;   (printout t
;             crlf
;             "horizontal-index:   " ?horizontal-index     crlf
;             "vertical-index:     " ?vertical-index       crlf
;             "levenshtein-index:  " ?levenshtein-distance crlf))

(defrule LEVENSHTEIN-DISTANCE::found-matching-char
  ?cell <- (object
            (is-a CELL)
            (horizontal-index        ?horizontal-index&:(> ?horizontal-index 0))
            (vertical-index          ?vertical-index&:(> ?vertical-index 0))
            (levenshtein-distance    -1))
           (object
            (is-a CELL)
            (horizontal-index        =(- ?horizontal-index 1))
            (vertical-index          =(- ?vertical-index   1))
            (levenshtein-distance    ?ld-left-up&~-1))
           (object
            (is-a STRINGS)
            (horizontal-string-chars $?horizontal-string-chars)
            (vertical-string-chars   $?vertical-string-chars))
           (test (eq (nth$ ?horizontal-index $?horizontal-string-chars)
                     (nth$ ?vertical-index   $?vertical-string-chars)))
  =>
  (printout t
            crlf
            "match"                                   crlf
            "horizontal-index:   " ?horizontal-index  crlf
            "vertical-index:     " ?vertical-index    crlf
            "levenshtein-index:  " ?ld-left-up        crlf)
  (modify-instance ?cell (levenshtein-distance ?ld-left-up)))

(defrule LEVENSHTEIN-DISTANCE::found-non-matching-char
 ?cell <- (object
            (is-a CELL)
            (horizontal-index        ?horizontal-index&:(> ?horizontal-index 0))
            (vertical-index          ?vertical-index&:(> ?vertical-index 0))
            (levenshtein-distance    -1))
           (object
            (is-a CELL)
            (horizontal-index        =(- ?horizontal-index 1))
            (vertical-index          ?vertical-index)
            (levenshtein-distance    ?ld-left&~-1))
           (object
            (is-a CELL)
            (horizontal-index        ?horizontal-index)
            (vertical-index          =(- ?vertical-index 1))
            (levenshtein-distance    ?ld-up&~-1))
           (object
            (is-a CELL)
            (horizontal-index        =(- ?horizontal-index 1))
            (vertical-index          =(- ?vertical-index   1))
            (levenshtein-distance    ?ld-left-up&~-1))
           (object
            (is-a STRINGS)
            (horizontal-string-chars $?horizontal-string-chars)
            (vertical-string-chars   $?vertical-string-chars))
           (test (not
                  (eq (nth$ ?horizontal-index $?horizontal-string-chars)
                      (nth$ ?vertical-index   $?vertical-string-chars))))
  =>
  (printout t
            crlf
            "deletion -> ld-left: " ?ld-left " ld-up: " ?ld-up " ld-left-up: " ?ld-left-up crlf
            "horizontal-index:   " ?horizontal-index  crlf
            "vertical-index:     " ?vertical-index    crlf
            "levenshtein-index:  " (+ (min ?ld-left ?ld-up ?ld-left-up) 1) crlf)
  (modify-instance ?cell (levenshtein-distance (+ (min ?ld-left ?ld-up ?ld-left-up) 1))))










; ;======================================================
; ;======================================================
; ;======================================================

; ; 0  1  2  3  4  5  6  7  8
; ; 1 -1 -1 -1 -1 -1 -1 -1 -1 
; ; 2 -1 -1 -1 -1 -1 -1 -1 -1                  0  1  2  3  4  5  6
; ; 3 -1 -1 -1 -1 -1 -1 -1 -1                  1  1  2  3  4  5  6
; ; 4 -1 -1 -1 -1 -1 -1 -1 -1                  2  2  1  2  3  4  5
; ; 5 -1 -1 -1 -1 -1 -1 -1 -1                  3  3  2  1  2  3  4
; ; 6 -1 -1 -1 -1 -1 -1 -1 -1                  4  4  3  2  1  2  3
; ;                                            5  5  4  3  2  2  3
; ; 0  1  2  3  4  5  6  7  8                  6  6  5  4  3  3  2
; ; 1  0  1  2  3  4  5  6  7                  7  7  6  5  4  4  3
; ; 2  1  1  2  2  3  4  5  6 
; ; 3  2  2  2  3  3  4  5  6
; ; 4  3  3  3  3  4  3  4  5
; ; 5  4  3  4  4  4  4  3  4
; ; 6  5  4  4  5  5  5  4  3



; ;======================================================
; ;======================================================
; ;======================================================

