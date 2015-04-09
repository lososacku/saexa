
; add n-grams
; add levenshtein algorithm


(defclass NLP::GREEDY-MATCH (is-a USER))

; (defclass NLP::TAXONOMY-ENTITY-ITEM-INFO (is-a USER)
;   (slot uuid             (type LEXEME))
;   (slot taxonomy         (type LEXEME))
;   (slot entity           (type LEXEME))
;   (slot item-token-count (type INTEGER)))

(defclass NLP::ITEM-TOKEN (is-a USER)
  (slot taxonomy-entity-item-info-uuid (type LEXEME))
  (slot item-token-index               (type INTEGER))
  (slot item-token                     (type STRING)))

(defclass NLP::TOKEN (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot token-index                    (type INTEGER))
  (slot token                          (type STRING)))

(defclass NLP::TEI-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot taxonomy-entity-item-info-uuid (type LEXEME))
  (slot last-item-token-index          (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot capture                        (type STRING)))

(defclass NLP::TLD-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot first-token-index              (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot capture                        (type STRING)))

(defclass NLP::URL-SCHEME-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot first-token-index              (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot capture                        (type STRING)))

(defclass NLP::COLON-SLASH-SLASH-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot first-token-index              (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot capture                        (type STRING)))

(defclass NLP::EMOTICON-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot first-token-index              (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot capture                        (type STRING)))

(defclass NLP::HEURISTIC-MATCH (is-a USER)
  (slot uuid                           (type LEXEME))
  (slot post-uuid                      (type LEXEME))
  (slot heuristic-type                 (type LEXEME))
  (slot first-token-index              (type INTEGER))
  (slot last-token-index               (type INTEGER))
  (slot last-capture-index             (type INTEGER))
  (slot capture                        (type STRING)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
(defrule NLP::update-ui-start
  (declare (salience 10000))
  (object
   (is-a TOKEN)
   (post-uuid    ?post-uuid))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid         ?post-uuid)
   (service-name ?service-name))
  =>
  (start-analysis-ui-for-service ?service-name))

(defrule NLP::update-stop
  (declare (salience -10000))
  (object
   (is-a TOKEN)
   (post-uuid    ?post-uuid))
  =>
  (stop-analysis-ui))


;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


(defrule NLP::found-tld-match-ac
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ac")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ac")))

(defrule NLP::found-tld-match-ad
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ad")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ad")))

(defrule NLP::found-tld-match-ae
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ae")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ae")))

(defrule NLP::found-tld-match-af
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "af")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "af")))

(defrule NLP::found-tld-match-ag
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ag")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ag")))

(defrule NLP::found-tld-match-ai
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ai")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ai")))

(defrule NLP::found-tld-match-al
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "al")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "al")))

(defrule NLP::found-tld-match-am
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "am")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "am")))

(defrule NLP::found-tld-match-an
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "an")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "an")))

(defrule NLP::found-tld-match-ao
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ao")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ao")))

(defrule NLP::found-tld-match-aq
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "aq")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "aq")))

(defrule NLP::found-tld-match-ar
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ar")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ar")))

(defrule NLP::found-tld-match-as
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "as")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "as")))

(defrule NLP::found-tld-match-at
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "at")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "at")))

(defrule NLP::found-tld-match-au
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "au")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "au")))

(defrule NLP::found-tld-match-aw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "aw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "aw")))

(defrule NLP::found-tld-match-ax
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ax")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ax")))

(defrule NLP::found-tld-match-az
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "az")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "az")))

(defrule NLP::found-tld-match-ba
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ba")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ba")))

(defrule NLP::found-tld-match-bb
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bb")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bb")))

(defrule NLP::found-tld-match-bd
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bd")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bd")))

(defrule NLP::found-tld-match-be
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "be")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "be")))

(defrule NLP::found-tld-match-bf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bf")))

(defrule NLP::found-tld-match-bg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bg")))

(defrule NLP::found-tld-match-bh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bh")))

(defrule NLP::found-tld-match-bi
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bi")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bi")))

(defrule NLP::found-tld-match-bj
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bj")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bj")))

(defrule NLP::found-tld-match-bm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bm")))

(defrule NLP::found-tld-match-bn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bn")))

(defrule NLP::found-tld-match-bo
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bo")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bo")))

(defrule NLP::found-tld-match-br
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "br")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "br")))

(defrule NLP::found-tld-match-bs
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bs")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bs")))

(defrule NLP::found-tld-match-bt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bt")))

(defrule NLP::found-tld-match-bv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bv")))

(defrule NLP::found-tld-match-bw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bw")))

(defrule NLP::found-tld-match-by
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "by")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "by")))

(defrule NLP::found-tld-match-bz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "bz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "bz")))

(defrule NLP::found-tld-match-ca
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ca")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ca")))

(defrule NLP::found-tld-match-cc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cc")))

(defrule NLP::found-tld-match-cd
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cd")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cd")))

(defrule NLP::found-tld-match-cf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cf")))

(defrule NLP::found-tld-match-cg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cg")))

(defrule NLP::found-tld-match-ch
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ch")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ch")))

(defrule NLP::found-tld-match-ci
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ci")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ci")))

(defrule NLP::found-tld-match-ck
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ck")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ck")))

(defrule NLP::found-tld-match-cl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cl")))

(defrule NLP::found-tld-match-cm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cm")))

(defrule NLP::found-tld-match-cn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cn")))

(defrule NLP::found-tld-match-co
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "co")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "co")))

(defrule NLP::found-tld-match-cr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cr")))

(defrule NLP::found-tld-match-cs
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cs")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cs")))

(defrule NLP::found-tld-match-cu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cu")))

(defrule NLP::found-tld-match-cv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cv")))

(defrule NLP::found-tld-match-cx
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cx")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cx")))

(defrule NLP::found-tld-match-cy
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cy")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cy")))

(defrule NLP::found-tld-match-cz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cz")))

(defrule NLP::found-tld-match-dd
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "dd")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "dd")))

(defrule NLP::found-tld-match-de
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "de")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "de")))

(defrule NLP::found-tld-match-dj
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "dj")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "dj")))

(defrule NLP::found-tld-match-dk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "dk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "dk")))

(defrule NLP::found-tld-match-dm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "dm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "dm")))

(defrule NLP::found-tld-match-do
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "do")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "do")))

(defrule NLP::found-tld-match-dz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "dz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "dz")))

(defrule NLP::found-tld-match-ec
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ec")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ec")))

(defrule NLP::found-tld-match-ee
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ee")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ee")))

(defrule NLP::found-tld-match-eg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "eg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "eg")))

(defrule NLP::found-tld-match-eh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "eh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "eh")))

(defrule NLP::found-tld-match-er
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "er")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "er")))

(defrule NLP::found-tld-match-es
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "es")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "es")))

(defrule NLP::found-tld-match-et
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "et")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "et")))

(defrule NLP::found-tld-match-eu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "eu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "eu")))

(defrule NLP::found-tld-match-fi
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fi")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fi")))

(defrule NLP::found-tld-match-fj
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fj")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fj")))

(defrule NLP::found-tld-match-fk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fk")))

(defrule NLP::found-tld-match-fm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fm")))

(defrule NLP::found-tld-match-fo
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fo")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fo")))

(defrule NLP::found-tld-match-fr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "fr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "fr")))

(defrule NLP::found-tld-match-ga
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ga")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ga")))

(defrule NLP::found-tld-match-gb
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gb")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gb")))

(defrule NLP::found-tld-match-gd
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gd")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gd")))

(defrule NLP::found-tld-match-ge
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ge")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ge")))

(defrule NLP::found-tld-match-gf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gf")))

(defrule NLP::found-tld-match-gg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gg")))

(defrule NLP::found-tld-match-gh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gh")))

(defrule NLP::found-tld-match-gi
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gi")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gi")))

(defrule NLP::found-tld-match-gl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gl")))

(defrule NLP::found-tld-match-gm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gm")))

(defrule NLP::found-tld-match-gn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gn")))

(defrule NLP::found-tld-match-gp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gp")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gp")))

(defrule NLP::found-tld-match-gq
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gq")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gq")))

(defrule NLP::found-tld-match-gr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gr")))

(defrule NLP::found-tld-match-gs
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gs")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gs")))

(defrule NLP::found-tld-match-gt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gt")))

(defrule NLP::found-tld-match-gu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gu")))

(defrule NLP::found-tld-match-gw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gw")))

(defrule NLP::found-tld-match-gy
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gy")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gy")))

(defrule NLP::found-tld-match-hk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "hk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "hk")))

(defrule NLP::found-tld-match-hm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "hm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "hm")))

(defrule NLP::found-tld-match-hn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "hn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "hn")))

(defrule NLP::found-tld-match-hr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "hr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "hr")))

(defrule NLP::found-tld-match-ht
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ht")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ht")))

(defrule NLP::found-tld-match-hu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "hu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "hu")))

(defrule NLP::found-tld-match-id
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "id")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "id")))

(defrule NLP::found-tld-match-ie
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ie")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ie")))

(defrule NLP::found-tld-match-il
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "il")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "il")))

(defrule NLP::found-tld-match-im
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "im")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "im")))

(defrule NLP::found-tld-match-in
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "in")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "in")))

(defrule NLP::found-tld-match-io
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "io")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "io")))

(defrule NLP::found-tld-match-iq
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "iq")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "iq")))

(defrule NLP::found-tld-match-ir
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ir")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ir")))

(defrule NLP::found-tld-match-is
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "is")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "is")))

(defrule NLP::found-tld-match-it
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "it")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "it")))

(defrule NLP::found-tld-match-je
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "je")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "je")))

(defrule NLP::found-tld-match-jm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "jm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "jm")))

(defrule NLP::found-tld-match-jo
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "jo")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "jo")))

(defrule NLP::found-tld-match-jp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "jp")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "jp")))

(defrule NLP::found-tld-match-ke
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ke")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ke")))

(defrule NLP::found-tld-match-kg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kg")))

(defrule NLP::found-tld-match-kh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kh")))

(defrule NLP::found-tld-match-ki
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ki")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ki")))

(defrule NLP::found-tld-match-km
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "km")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "km")))

(defrule NLP::found-tld-match-kn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kn")))

(defrule NLP::found-tld-match-kp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kp")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kp")))

(defrule NLP::found-tld-match-kr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kr")))

(defrule NLP::found-tld-match-kw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kw")))

(defrule NLP::found-tld-match-ky
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ky")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ky")))

(defrule NLP::found-tld-match-kz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "kz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "kz")))

(defrule NLP::found-tld-match-la
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "la")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "la")))

(defrule NLP::found-tld-match-lb
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lb")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lb")))

(defrule NLP::found-tld-match-lc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lc")))

(defrule NLP::found-tld-match-li
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "li")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "li")))

(defrule NLP::found-tld-match-lk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lk")))

(defrule NLP::found-tld-match-lr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lr")))

(defrule NLP::found-tld-match-ls
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ls")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ls")))

(defrule NLP::found-tld-match-lt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lt")))

(defrule NLP::found-tld-match-lu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lu")))

(defrule NLP::found-tld-match-lv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "lv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "lv")))

(defrule NLP::found-tld-match-ly
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ly")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ly")))

(defrule NLP::found-tld-match-ma
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ma")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ma")))

(defrule NLP::found-tld-match-mc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mc")))

(defrule NLP::found-tld-match-md
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "md")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "md")))

(defrule NLP::found-tld-match-me
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "me")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "me")))

(defrule NLP::found-tld-match-mg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mg")))

(defrule NLP::found-tld-match-mh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mh")))

(defrule NLP::found-tld-match-mk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mk")))

(defrule NLP::found-tld-match-ml
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ml")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ml")))

(defrule NLP::found-tld-match-mm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mm")))

(defrule NLP::found-tld-match-mn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mn")))

(defrule NLP::found-tld-match-mo
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mo")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mo")))

(defrule NLP::found-tld-match-mp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mp")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mp")))

(defrule NLP::found-tld-match-mq
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mq")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mq")))

(defrule NLP::found-tld-match-mr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mr")))

(defrule NLP::found-tld-match-ms
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ms")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ms")))

(defrule NLP::found-tld-match-mt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mt")))

(defrule NLP::found-tld-match-mu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mu")))

(defrule NLP::found-tld-match-mv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mv")))

(defrule NLP::found-tld-match-mw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mw")))

(defrule NLP::found-tld-match-mx
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mx")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mx")))

(defrule NLP::found-tld-match-my
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "my")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "my")))

(defrule NLP::found-tld-match-mz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mz")))

(defrule NLP::found-tld-match-na
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "na")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "na")))

(defrule NLP::found-tld-match-nc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nc")))

(defrule NLP::found-tld-match-ne
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ne")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ne")))

(defrule NLP::found-tld-match-nf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nf")))

(defrule NLP::found-tld-match-ng
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ng")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ng")))

(defrule NLP::found-tld-match-ni
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ni")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ni")))

(defrule NLP::found-tld-match-nl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nl")))

(defrule NLP::found-tld-match-no
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "no")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "no")))

(defrule NLP::found-tld-match-np
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "np")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "np")))

(defrule NLP::found-tld-match-nr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nr")))

(defrule NLP::found-tld-match-nu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nu")))

(defrule NLP::found-tld-match-nz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "nz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "nz")))

(defrule NLP::found-tld-match-om
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "om")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "om")))

(defrule NLP::found-tld-match-pa
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pa")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pa")))

(defrule NLP::found-tld-match-pe
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pe")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pe")))

(defrule NLP::found-tld-match-pf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pf")))

(defrule NLP::found-tld-match-pg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pg")))

(defrule NLP::found-tld-match-ph
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ph")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ph")))

(defrule NLP::found-tld-match-pk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pk")))

(defrule NLP::found-tld-match-pl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pl")))

(defrule NLP::found-tld-match-pm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pm")))

(defrule NLP::found-tld-match-pn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pn")))

(defrule NLP::found-tld-match-pr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pr")))

(defrule NLP::found-tld-match-ps
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ps")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ps")))

(defrule NLP::found-tld-match-pt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pt")))

(defrule NLP::found-tld-match-pw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pw")))

(defrule NLP::found-tld-match-py
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "py")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "py")))

(defrule NLP::found-tld-match-qa
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "qa")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "qa")))

(defrule NLP::found-tld-match-re
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "re")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "re")))

(defrule NLP::found-tld-match-ro
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ro")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ro")))

(defrule NLP::found-tld-match-rs
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "rs")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "rs")))

(defrule NLP::found-tld-match-ru
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ru")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ru")))

(defrule NLP::found-tld-match-rw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "rw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "rw")))

(defrule NLP::found-tld-match-sa
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sa")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sa")))

(defrule NLP::found-tld-match-sb
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sb")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sb")))

(defrule NLP::found-tld-match-sc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sc")))

(defrule NLP::found-tld-match-sd
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sd")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sd")))

(defrule NLP::found-tld-match-se
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "se")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "se")))

(defrule NLP::found-tld-match-sg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sg")))

(defrule NLP::found-tld-match-sh
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sh")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sh")))

(defrule NLP::found-tld-match-si
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "si")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "si")))

(defrule NLP::found-tld-match-sj
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sj")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sj")))

(defrule NLP::found-tld-match-sk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sk")))

(defrule NLP::found-tld-match-sl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sl")))

(defrule NLP::found-tld-match-sm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sm")))

(defrule NLP::found-tld-match-sn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sn")))

(defrule NLP::found-tld-match-so
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "so")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "so")))

(defrule NLP::found-tld-match-sr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sr")))

(defrule NLP::found-tld-match-ss
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ss")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ss")))

(defrule NLP::found-tld-match-st
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "st")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "st")))

(defrule NLP::found-tld-match-su
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "su")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "su")))

(defrule NLP::found-tld-match-sv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sv")))

(defrule NLP::found-tld-match-sx
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sx")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sx")))

(defrule NLP::found-tld-match-sy
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sy")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sy")))

(defrule NLP::found-tld-match-sz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "sz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "sz")))

(defrule NLP::found-tld-match-tc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tc")))

(defrule NLP::found-tld-match-td
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "td")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "td")))

(defrule NLP::found-tld-match-tf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tf")))

(defrule NLP::found-tld-match-tg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tg")))

(defrule NLP::found-tld-match-th
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "th")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "th")))

(defrule NLP::found-tld-match-tj
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tj")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tj")))

(defrule NLP::found-tld-match-tk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tk")))

(defrule NLP::found-tld-match-tl
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tl")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tl")))

(defrule NLP::found-tld-match-tm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tm")))

(defrule NLP::found-tld-match-tn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tn")))

(defrule NLP::found-tld-match-to
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "to")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "to")))

(defrule NLP::found-tld-match-tp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tp")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tp")))

(defrule NLP::found-tld-match-tr
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tr")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tr")))

(defrule NLP::found-tld-match-tt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tt")))

(defrule NLP::found-tld-match-tv
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tv")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tv")))

(defrule NLP::found-tld-match-tw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tw")))

(defrule NLP::found-tld-match-tz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tz")))

(defrule NLP::found-tld-match-ua
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ua")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ua")))

(defrule NLP::found-tld-match-ug
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ug")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ug")))

(defrule NLP::found-tld-match-uk
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "uk")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "uk")))

(defrule NLP::found-tld-match-us
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "us")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "us")))

(defrule NLP::found-tld-match-uy
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "uy")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "uy")))

(defrule NLP::found-tld-match-uz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "uz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "uz")))

(defrule NLP::found-tld-match-va
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "va")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "va")))

(defrule NLP::found-tld-match-vc
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "vc")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "vc")))

(defrule NLP::found-tld-match-ve
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ve")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ve")))

(defrule NLP::found-tld-match-vg
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "vg")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "vg")))

(defrule NLP::found-tld-match-vi
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "vi")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "vi")))

(defrule NLP::found-tld-match-vn
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "vn")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "vn")))

(defrule NLP::found-tld-match-vu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "vu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "vu")))

(defrule NLP::found-tld-match-wf
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "wf")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "wf")))

(defrule NLP::found-tld-match-ws
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ws")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ws")))

(defrule NLP::found-tld-match-ye
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "ye")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ye")))

(defrule NLP::found-tld-match-yt
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "yt")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "yt")))

(defrule NLP::found-tld-match-yu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "yu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "yu")))

(defrule NLP::found-tld-match-za
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "za")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "za")))

(defrule NLP::found-tld-match-zm
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "zm")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "zm")))

(defrule NLP::found-tld-match-zw
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "zw")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "zw")))

(defrule NLP::found-tld-match-edu
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "edu")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "edu")))

(defrule NLP::found-tld-match-gov
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "gov")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "gov")))

(defrule NLP::found-tld-match-mil
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mil")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mil")))

(defrule NLP::found-tld-match-aero
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "aero")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "aero")))

(defrule NLP::found-tld-match-asia
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "asia")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "asia")))

(defrule NLP::found-tld-match-biz
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "biz")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "biz")))

(defrule NLP::found-tld-match-cat
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "cat")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "cat")))

(defrule NLP::found-tld-match-com
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "com")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "com")))

(defrule NLP::found-tld-match-coop
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "coop")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "coop")))

(defrule NLP::found-tld-match-info
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "info")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "info")))

(defrule NLP::found-tld-match-int
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "int")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "int")))

(defrule NLP::found-tld-match-jobs
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "jobs")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "jobs")))

(defrule NLP::found-tld-match-mobi
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "mobi")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "mobi")))

(defrule NLP::found-tld-match-museum
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "museum")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "museum")))

(defrule NLP::found-tld-match-name
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "name")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "name")))

(defrule NLP::found-tld-match-net
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "net")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "net")))

(defrule NLP::found-tld-match-org
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "org")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "org")))

(defrule NLP::found-tld-match-pro
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "pro")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "pro")))

(defrule NLP::found-tld-match-tel
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "tel")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "tel")))

(defrule NLP::found-tld-match-travel
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "travel")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "travel")))

(defrule NLP::found-tld-match-xxx
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       ".")
   (token-index ?dot-token-index)
   (post-uuid   ?post-uuid))
  (object
   (is-a TOKEN)
   (token       "xxx")
   (token-index ?token-index&=(+ 1 ?dot-token-index))
   (post-uuid   ?post-uuid))
  =>
  (make-instance of TLD-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "xxx")))

(defrule NLP::found-url-scheme-match-http
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       "http")
   (token-index ?token-index)
   (post-uuid   ?post-uuid))
  =>
  (make-instance of URL-SCHEME-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "http")))

(defrule NLP::found-url-scheme-match-https
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       "https")
   (token-index ?token-index)
   (post-uuid   ?post-uuid))
  =>
  (make-instance of URL-SCHEME-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "https")))

(defrule NLP::found-url-scheme-match-ftp
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       "ftp")
   (token-index ?token-index)
   (post-uuid   ?post-uuid))
  =>
  (make-instance of URL-SCHEME-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "ftp")))

(defrule NLP::found-url-scheme-match-file
  (declare (salience 8000))
  (object
   (is-a TOKEN)
   (token       "file")
   (token-index ?token-index)
   (post-uuid   ?post-uuid))
  =>
  (make-instance of URL-SCHEME-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?token-index)
                 (last-token-index  ?token-index)
                 (capture           "file")))

(defrule NLP::found-initial-tei-match
  (declare (salience 8000))
  (object
   (is-a ITEM-TOKEN)
   (taxonomy-entity-item-info-uuid ?taxonomy-entity-item-info-uuid)
   (item-token-index               1)
   (item-token                     ?item-token))
  (object
   (is-a TOKEN)
   (token-index                    ?token-index)
   (token                          ?item-token)
   (post-uuid                      ?post-uuid))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (uuid                           ?taxonomy-entity-item-info-uuid))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name))
  =>
  (start-analysis-ui-for-service ?service-name)
  (make-instance of TEI-MATCH
                 (uuid                           (get-uuid))
                 (post-uuid                      ?post-uuid)
                 (taxonomy-entity-item-info-uuid ?taxonomy-entity-item-info-uuid)
                 (last-item-token-index          1)
                 (last-token-index               ?token-index)
                 (capture                        ?item-token)))

(defrule NLP::found-subsequent-tei-match
  (declare (salience 8000))
  ?match <- (object
             (is-a TEI-MATCH)
             (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
             (last-item-token-index           ?last-item-token-index)
             (last-token-index                ?last-token-index)
             (capture                         ?capture))
            (object
             (is-a TAXONOMY-ENTITY-ITEM-INFO)
             (item-token-count                ?item-token-count&:(< 1 ?item-token-count))
             (uuid                            ?taxonomy-entity-item-info-uuid))
            (object
             (is-a ITEM-TOKEN)
             (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
             (item-token-index                ?item-token-index&=(+ 1 ?last-item-token-index))
             (item-token                      ?item-token))
            (object
             (is-a TOKEN)
             (token-index                     ?token-index&=(+ 1 ?last-token-index))
             (token                           ?item-token)
             (post-uuid                       ?post-uuid))
            (object
             (is-a POSTED-DATA-ITEM)
             (uuid                            ?post-uuid)
             (service-name                    ?service-name))
            =>
            (start-analysis-ui-for-service ?service-name)
            (modify-instance ?match (last-item-token-index ?item-token-index)
                                    (last-token-index      ?token-index)
                                    (capture     (str-cat ?capture ?item-token))))

(defrule NLP::found-colon-slash-slash-match
  (declare (salience 8000))
  (object (is-a TOKEN)(token ":")(post-uuid ?post-uuid)(token-index ?colon-index))
  (object (is-a TOKEN)(token "/")(post-uuid ?post-uuid)(token-index =(+ 1 ?colon-index)))
  (object (is-a TOKEN)(token "/")(post-uuid ?post-uuid)(token-index =(+ 2 ?colon-index)))
  =>
  (make-instance of COLON-SLASH-SLASH-MATCH
                 (uuid              (get-uuid))
                 (post-uuid         ?post-uuid)
                 (first-token-index ?colon-index)
                 (last-token-index  (+ ?colon-index 2))
                 (capture           "://")))


(defrule NLP::found-ampersand-in-left-side-url-heuristic-match
  "since the email and url heuristic matching both start the same
   way, part of an email address will be captured as a url. in this
   case we need to unmake the url heuristic match instance. this
   will only be an issue on the left side"
 (declare (salience 8000))
  ?mismatched-as-url <- (object
                         (is-a HEURISTIC-MATCH)
                         (post-uuid         ?post-uuid)
                         (heuristic-type    left-side-url-heuristic-match)
                         (first-token-index ?leftmost-url-token-index)
                         (capture           ""))
                        (object
                         (is-a TOKEN)
                         (post-uuid         ?post-uuid)
                         (token             "@")
                         (token-index       =(- ?leftmost-url-token-index 1)))

  =>
  (unmake-instance ?mismatched-as-url))

(defrule NLP::found-initial-left-side-url-heuristic-match
  (declare (salience 8000))

  (object
   (is-a TLD-MATCH)
   (post-uuid         ?post-uuid)
   (first-token-index ?tld-first-index))
  (object
   (is-a TOKEN)
   (post-uuid         ?post-uuid)
   (token             ~" "&~"@")
   (token-index       ?leftmost-url-token-index&=(- ?tld-first-index 1)))
   =>
   ; (printout t
   ;           "NLP::found-initial-left-side-url-heuristic-match"
   ;           crlf
   ;           "?leftmost-url-token-index: " ?leftmost-url-token-index
   ;           crlf
   ;           "?tld-first-index: " ?tld-first-index
   ;           crlf
   ;           crlf
   ;           crlf)
   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     left-side-url-heuristic-match)
                    (first-token-index  ?leftmost-url-token-index)
                    (last-token-index   (- ?tld-first-index 1))))

(defrule NLP::found-further-left-side-url-heuristic-match
  (declare (salience 8000))
  ?previous-leftmost <- (object
                         (is-a HEURISTIC-MATCH)
                         (post-uuid          ?post-uuid)
                         (heuristic-type     left-side-url-heuristic-match)
                         (first-token-index  ?previous-leftmost-url-token-index)
                         (capture            ""))
                        (object
                         (is-a TLD-MATCH)
                         (post-uuid         ?post-uuid)
                         (first-token-index ?tld-first-index))
                        (object
                         (is-a TOKEN)
                         (post-uuid         ?post-uuid)
                         (token             ~" "&~"@")
                         (token-index       ?leftmost-url-token-index&:(< ?leftmost-url-token-index ?previous-leftmost-url-token-index)))
                        (not
                         (object
                          (is-a TOKEN)
                          (post-uuid        ?post-uuid)
                          (token            " "|"@")
                          (token-index      ?invalid-index&:(> ?invalid-index ?leftmost-url-token-index)
                                            &:(< ?invalid-index ?tld-first-index))))
   =>
   (unmake-instance ?previous-leftmost)

   ; (printout t crlf "(make-instance of HEURISTIC-MATCH
   ;                    (uuid               " (get-uuid) ")
   ;                    (post-uuid          " ?post-uuid ")
   ;                    (heuristic-type     left-side-url-heuristic-match)
   ;                    (first-token-index  " ?leftmost-url-token-index ")
   ;                    (last-token-index   " (- ?tld-first-index 1) "))" crlf crlf)

   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     left-side-url-heuristic-match)
                    (first-token-index  ?leftmost-url-token-index)
                    (last-token-index   (- ?tld-first-index 1))
                    (last-capture-index (- ?leftmost-url-token-index 1)))) ; need to move one back so concating works

(defrule NLP::found-initial-right-side-url-heuristic-match
  (declare (salience 8000))
  (object
   (is-a TLD-MATCH)
   (post-uuid         ?post-uuid)
   (first-token-index ?tld-first-index))
  (object
   (is-a TOKEN)
   (post-uuid         ?post-uuid)
   (token             ~" "&~"@")
   (token-index       ?rightmost-url-token-index&=(+ ?tld-first-index 1)))
   =>
   ; (printout t
   ;           "NLP::found-initial-right-side-url-heuristic-match"
   ;           crlf
   ;           "?rightmost-url-token-index: " ?rightmost-url-token-index
   ;           crlf
   ;           "?tld-first-index: " ?tld-first-index
   ;           crlf
   ;           crlf
   ;           crlf)
   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     right-side-url-heuristic-match)
                    (first-token-index  ?rightmost-url-token-index)
                    (last-token-index   ?rightmost-url-token-index)
                    (last-capture-index ?rightmost-url-token-index)))

(defrule NLP::found-further-right-side-url-heuristic-match
  (declare (salience 8000))
  ?previous-rightmost <- (object
                          (is-a HEURISTIC-MATCH)
                          (post-uuid          ?post-uuid)
                          (heuristic-type     right-side-url-heuristic-match)
                          (last-token-index   ?previous-rightmost-url-token-index)
                          (capture            ""))
                         (object
                          (is-a TLD-MATCH)
                          (post-uuid          ?post-uuid)
                          (first-token-index  ?tld-first-index))
                         (object
                          (is-a TOKEN)
                          (post-uuid          ?post-uuid)
                          (token              ~" "&~"@")
                          (token-index        ?rightmost-url-token-index&:(> ?rightmost-url-token-index ?previous-rightmost-url-token-index)))
                         (not
                          (object
                           (is-a TOKEN)
                           (post-uuid        ?post-uuid)
                           (token            " "|"@")
                           (token-index      ?invalid-index&:(< ?invalid-index ?rightmost-url-token-index)
                                                           &:(> ?invalid-index ?tld-first-index))))
   =>
   (unmake-instance ?previous-rightmost)

   ; (printout t crlf "(make-instance of HEURISTIC-MATCH
   ;                    (uuid               " (get-uuid) ")
   ;                    (post-uuid          " ?post-uuid ")
   ;                    (heuristic-type     right-side-url-heuristic-match)
   ;                    (first-token-index  " (+ ?tld-first-index 1) ")
   ;                    (last-token-index   " ?rightmost-url-token-index "))" crlf crlf)

   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     right-side-url-heuristic-match)
                    (first-token-index  (+ ?tld-first-index 1))
                    (last-token-index   ?rightmost-url-token-index)
                    (last-capture-index ?tld-first-index))) ; need to be one back from the first so concating works



(defrule NLP::found-initial-email-address-heuristic-match
  (declare (salience 8000))

  (object
   (is-a TLD-MATCH)
   (post-uuid         ?post-uuid)
   (first-token-index ?tld-first-index))
  (object
   (is-a TOKEN)
   (post-uuid         ?post-uuid)
   (token             "@")
   (token-index       ?ampersand-token-index&:(< ?ampersand-token-index ?tld-first-index)))
  (not
   (object
    (is-a TOKEN)
    (post-uuid        ?post-uuid)
    (token            " "|"@")
    (token-index      ?invalid-index&:(> ?invalid-index ?ampersand-token-index)
                                    &:(< ?invalid-index ?tld-first-index))))

   =>
   ; (printout t crlf "(make-instance of HEURISTIC-MATCH
   ;                    (uuid               " (get-uuid) ")
   ;                    (post-uuid          " ?post-uuid ")
   ;                    (heuristic-type     email-address)
   ;                    (first-token-index  " ?ampersand-token-index ")
   ;                    (last-token-index   " ?tld-first-index "))" crlf crlf)
   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     email-address)
                    (first-token-index  ?ampersand-token-index)
                    (last-token-index   ?tld-first-index)))

(defrule NLP::found-further-email-address-heuristic-match
  (declare (salience 8000))
  ?previous-leftmost <- (object
                         (is-a HEURISTIC-MATCH)
                         (uuid               ?heuristic-match-uuid)
                         (post-uuid          ?post-uuid)
                         (heuristic-type     email-address)
                         (first-token-index  ?previous-leftmost-email-address-token-index&~1)
                         (last-token-index   ?last-token-index)
                         (capture            ""))
                        (object
                         (is-a TLD-MATCH)
                         (post-uuid         ?post-uuid)
                         (first-token-index ?tld-first-index))
                        (object
                         (is-a TOKEN)
                         (post-uuid         ?post-uuid)
                         (token             ~" ")
                         (token-index       ?leftmost-email-address-token-index&:(< ?leftmost-email-address-token-index ?previous-leftmost-email-address-token-index)))
                        (not
                         (object
                          (is-a TOKEN)
                          (post-uuid        ?post-uuid)
                          (token            " ")
                          (token-index      ?invalid-index&:(> ?invalid-index ?leftmost-email-address-token-index)
                                                          &:(< ?invalid-index ?tld-first-index))))
   =>
   (unmake-instance ?previous-leftmost)

   ; (printout t crlf "(make-instance of HEURISTIC-MATCH
   ;                    (uuid               " (get-uuid) ")
   ;                    (post-uuid          " ?post-uuid ")
   ;                    (heuristic-type     email-address)
   ;                    (first-token-index  " ?leftmost-email-address-token-index ")
   ;                    (last-token-index   " ?tld-first-index ")
   ;                    (last-capture-index " (- ?leftmost-email-address-token-index 1) "))" crlf crlf)

   (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     email-address)
                    (first-token-index  ?leftmost-email-address-token-index)
                    (last-token-index   ?tld-first-index)
                    (last-capture-index (- ?leftmost-email-address-token-index 1)))) ; need to move one back so concating works

(defrule NLP::greedily-concatenate-heuristic-match
  (declare (salience 6000))
  ?match <- (object
             (is-a HEURISTIC-MATCH)
             (post-uuid          ?post-uuid)
             (last-token-index   ?last-token-index)
             (last-capture-index ?last-capture-index&:(< ?last-capture-index (+ 1 ?last-token-index)))
             (capture            ?capture))
            (object
             (is-a TOKEN)
             (post-uuid          ?post-uuid)
             (token-index        ?token-index&=(+ 1 ?last-capture-index))
             (token              ?token))
            =>
            (modify-instance ?match (last-capture-index ?token-index)
                                    (capture            (str-cat ?capture ?token))))


(defrule NLP::concatenate-sides-from-url-heuristic-match
  (declare (salience 5000))

  ?left-side <- (object
                  (is-a HEURISTIC-MATCH)
                  (post-uuid          ?post-uuid)
                  (heuristic-type     left-side-url-heuristic-match)
                  (first-token-index  ?first-token-index)
                  (last-token-index   ?left-last-token-index)
                  (capture            ?left-side-capture))

  ?right-side <- (object
                  (is-a HEURISTIC-MATCH)
                  (post-uuid          ?post-uuid)
                  (heuristic-type     right-side-url-heuristic-match)
                  (first-token-index  =(+ ?left-last-token-index 2))
                  (last-token-index   ?last-token-index)
                  (capture            ?right-side-capture))

  =>
  (unmake-instance ?left-side)
  (unmake-instance ?right-side)

;  (printout t crlf ">>>>>>>>>>>>>>>" crlf (str-cat ?left-side-capture ?right-side-capture) crlf crlf)

  (make-instance of HEURISTIC-MATCH
                    (uuid               (get-uuid))
                    (post-uuid          ?post-uuid)
                    (heuristic-type     url)
                    (first-token-index  ?first-token-index)
                    (last-token-index   ?last-token-index)
                    (last-capture-index ?last-token-index)
                    (capture            (str-cat ?left-side-capture ?right-side-capture))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule NLP::profile-login-name-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"login-name")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ;(printout t "NLP::profile-login-name-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification login-name-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification login-name-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::profile-user-id-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"user-id")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::profile-user-id-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification profile-user-id-found)
  ;                (taxonomy      \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification profile-user-id-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::profile-display-name-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"display-name")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::profile-display-name-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification profile-display-name-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification profile-display-name-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::youtube-video-id-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"video-id")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~"youtube"))
  =>
  ; (printout t "NLP::youtube-video-id-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification youtube-video-id-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification youtube-video-id-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::youtube-video-title-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"video-title")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~"youtube"))
  =>
  ; (printout t "NLP::youtube-video-title-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification youtube-video-title-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification youtube-video-title-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::high-school-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"highschool")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::high-school-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification high-school-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification high-school-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::hometown-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"hometown")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::hometown-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification hometown-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification hometown-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::first-name-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"first-name")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::first-name-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification first-name-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification first-name-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::middle-name-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"middle-name")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::middle-name-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification middle-name-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)
  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification middle-name-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::last-name-found
  (declare (salience 2000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity&"last-name")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::last-name-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification last-name-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" ?entity "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (start-analysis-ui-for-service ?service-name)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification last-name-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

(defrule NLP::catalogued-constituent-found
  (declare (salience 1000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (not
   (object
    (is-a NLP-CLASSIFICATION)
    (target-uuid                    ?post-uuid)
    (classification                 ~catalogued-constituent-found)))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          ?entity)
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid                            ?post-uuid)
   (service-name                    ?service-name&~?taxonomy))
  =>
  ; (printout t "NLP::catalogued-constituent-found" crlf)
  
  (start-analysis-ui-for-service ?service-name)

  (printout t "(make-instance of NLP-CLASSIFICATION
                 (target-uuid    " ?post-uuid ")
                 (classification catalogued-constituent-found)
                 (taxonomy       \"" ?taxonomy "\")
                 (entity         \"" ?entity "\")
                 (item           \"" ?capture "\"))" crlf)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification catalogued-constituent-found)
                 (taxonomy       ?taxonomy)
                 (entity         ?entity)
                 (item           ?capture)))

; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%
; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%
; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%
; (defrule NLP::ack
;   (declare (salience 10000))
;   (object
;    (is-a TEI-MATCH)
;    (taxonomy-entity-item-info-uuid ?taxonomy-entity-item-info-uuid)
;    (last-item-token-index          ?last-item-token-index)
;    (last-token-index               ?last-token-index)
;    (post-uuid                      ?post-uuid)
;    (capture                        ?capture))
;   =>
;   (printout t
;             crlf crlf crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             "taxonomy-entity-item-info-uuid -> " ?taxonomy-entity-item-info-uuid crlf
;             "last-item-token-index -> " ?last-item-token-index crlf
;             "last-token-index -> " ?last-token-index crlf
;             "post-uuid -> " ?post-uuid crlf
;             "capture -> " ?capture crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>" crlf
;             crlf crlf crlf))


; (defrule NLP::oop
;   (declare (salience 10000))
;   (object
;    (is-a TAXONOMY-ENTITY-ITEM-INFO)
;    (entity                          ?entity)
;    (uuid                            ?taxonomy-entity-item-info-uuid)
;    (taxonomy                        ?taxonomy)
;    (item-token-count                ?item-token-count))
;   =>
;   (printout t
;             crlf crlf crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             "taxonomy-entity-item-info-uuid -> " ?taxonomy-entity-item-info-uuid crlf
;             "taxonomy -> " ?taxonomy crlf
;             "entity -> " ?entity crlf
;             "item-token-count -> " ?item-token-count crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" crlf
;             crlf crlf crlf))
; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%
; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%
; ;;$%@#%@#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#%@#$%@#$%@#$%@#$%@#$%@#%@#%@#%


(defrule NLP::catalogued-email-address-found
  (declare (salience 1000))
  (object
   (is-a TEI-MATCH)
   (taxonomy-entity-item-info-uuid  ?taxonomy-entity-item-info-uuid)
   (last-item-token-index           ?last-item-token-index)
   (last-token-index                ?last-token-index)
   (post-uuid                       ?post-uuid)
   (capture                         ?capture))
  (object
   (is-a TAXONOMY-ENTITY-ITEM-INFO)
   (entity                          "email-address")
   (uuid                            ?taxonomy-entity-item-info-uuid)
   (item-token-count                ?last-item-token-index)
   (taxonomy                        ?taxonomy))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?post-uuid)
   (service-name ~"facebook"))
  =>
  ; (printout t "NLP::catalogued-constituent-found" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification catalogued-email-address-found)
  ;                (taxonomy       \"" ?taxonomy "\")
  ;                (entity         \"" email-address "\")
  ;                (item           \"" ?capture "\"))" crlf)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (teii-uuid      ?taxonomy-entity-item-info-uuid)
                 (classification catalogued-email-address-found)
                 (taxonomy       ?taxonomy)
                 (entity         email-address)
                 (item           ?capture)))

(defrule NLP::post-contains-url
  (object
   (is-a HEURISTIC-MATCH)
   (post-uuid      ?post-uuid)
   (heuristic-type url)
   (capture        ?capture))
  =>
  ; (printout t "NLP::post-contains-url: " ?capture crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification url-found)
  ;                (taxonomy       heuristic)
  ;                (entity         url)
  ;                (item           \"" ?capture "\"))" crlf)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (classification url-found)
                 (taxonomy       heuristic)
                 (entity         url)
                 (item           ?capture)))

(defrule NLP::post-contains-email-address
  (object
   (is-a HEURISTIC-MATCH)
   (post-uuid      ?post-uuid)
   (heuristic-type email-address)
   (capture        ?capture))
  (not
   (object
    (is-a NLP-CLASSIFICATION)
    (classification catalogued-email-address-found)
    (entity         email-address)
    (item           ?capture)))
  =>
  ; (printout t "NLP::post-contains-email-address" crlf)

  ; (printout t "(make-instance of NLP-CLASSIFICATION
  ;                (target-uuid    " ?post-uuid ")
  ;                (classification email-address-found)
  ;                (taxonomy       heuristic)
  ;                (entity         email-address)
  ;                (item           \"" ?capture "\"))" crlf)

  (make-instance of NLP-CLASSIFICATION
                 (target-uuid    ?post-uuid)
                 (classification email-address-found)
                 (taxonomy       heuristic)
                 (entity         email-address)
                 (item           ?capture)))


; (defrule NLP::zorg
;   (declare (salience -10000))
;   (object
;    (is-a TAXONOMY-ENTITY-ITEM-INFO)
;    (uuid                           ?teii-uuid)
;    (taxonomy                       "facebook")
;    (entity                         ?entity))
;   (object
;    (is-a ITEM-TOKEN)
;    (taxonomy-entity-item-info-uuid ?teii-uuid)
;    (item-token-index               ?item-token-index)
;    (item-token                     ?item-token))
;   =>
;   (printout t
;             crlf
;             crlf
;             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf
;             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf
;             "facebook -> " ?entity " (" ?item-token-index ") -> " ?item-token crlf
;             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf
;             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf
;             crlf
;             crlf))
