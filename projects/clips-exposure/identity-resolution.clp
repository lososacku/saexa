;

;; @$%@#%@#%@#$%@#$%@#$%@#$%@#$%
;; TEIIs represent the domain 
;; @$%@#%@#%@#$%@#$%@#$%@#$%@#$%

(defclass IDENTITY-RESOLUTION::SCOPE-IDENTITY-RESOLUTION (is-a USER)
  (slot      scope                 (type LEXEME))
  (multislot nlp-teii-uuids)
  (multislot resolution-coordinates))

(defclass IDENTITY-RESOLUTION::BASELINE-TEII-UUIDS (is-a USER)
  (slot      sorted                (type SYMBOL) (default NO))
  (multislot uuids))

(deffunction IDENTITY-RESOLUTION::string> (?s0 ?s1)
  (> (str-compare ?s0 ?s1) 0))


(defmessage-handler IDENTITY-RESOLUTION::SCOPE-IDENTITY-RESOLUTION
                    calculate-delta (?endpoint ?baseline-length)
  (bind ?max-magnitude 1)
  (bind ?dot-product   0)
  (progn$ (?coordinate ?self:resolution-coordinates)
          (bind ?dot-product
                (+ ?dot-product
                    (* ?coordinate
                       (nth$ ?coordinate-index
                             (send ?endpoint get-resolution-coordinates))))))

  ; (printout t
  ;           crlf
  ;           ";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;" crlf
  ;           "dot-product      -> " ?dot-product crlf
  ;           "?baseline-length -> " ?baseline-length crlf
  ;           "normalized       -> " (/ ?dot-product ?baseline-length) crlf
  ;           "delta            -> " (- 1 (/ ?dot-product ?baseline-length)) crlf
  ;           crlf)

  (- 1 (/ ?dot-product (* ?baseline-length ?max-magnitude))))



;; @#%@#$%@#$%@#$%@#$%@#$%@#%$
;; having facebook here adds
;; protection in the other
;; direction. i.e., keeping
;; your friends from knowing
;; what you say on your other
;; accounts
;; 
;; add more of this for v1???
;; @#%@#$%@#$%@#$%@#$%@#$%@#%$
(defrule IDENTITY-RESOLUTION::create-scope-identity-resolution-objects
  (declare (salience 8000))
  (not
   (object
    (is-a SCOPE-IDENTITY-RESOLUTION)))
  (not
   (object
    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION)))
  =>
(printout t crlf "IDENTITY-RESOLUTION::create-scope-identity-resolution-objects" crlf)
  (make-instance of SCOPE-IDENTITY-RESOLUTION (scope                  "tumblr")
                                              (nlp-teii-uuids         (create$))
                                              (resolution-coordinates (create$)))
  (make-instance of SCOPE-IDENTITY-RESOLUTION (scope                  "twitter")
                                              (nlp-teii-uuids         (create$))
                                              (resolution-coordinates (create$)))
  (make-instance of SCOPE-IDENTITY-RESOLUTION (scope                  "youtube")
                                              (nlp-teii-uuids         (create$))
                                              (resolution-coordinates (create$))))

(defrule IDENTITY-RESOLUTION::create-baseline-teii-uuids
  (declare (salience 8000))
  (not
   (object
    (is-a BASELINE-TEII-UUIDS)))
  (not
   (object
    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION)))
  =>
(printout t crlf "IDENTITY-RESOLUTION::create-baseline-teii-uuids" crlf)
  (make-instance of BASELINE-TEII-UUIDS (uuids (create$)) (sorted NO)))

(defrule IDENTITY-RESOLUTION::found-next-baseline-teii
  (declare (salience 8000))
  ?baseline-teii-uuids <- (object
                           (is-a BASELINE-TEII-UUIDS)
                           (uuids  $?uuids)
                           (sorted NO))
                          (object
                           (is-a TAXONOMY-ENTITY-ITEM-INFO)
                           (taxonomy "facebook")
                           (uuid     ?teii-uuid&~:(member$ ?teii-uuid
                                                           $?uuids)))
  =>
(printout t crlf "IDENTITY-RESOLUTION::found-next-baseline-teii" crlf)
  (modify-instance ?baseline-teii-uuids
                   (uuids (create$ $?uuids ?teii-uuid))))

(defrule IDENTITY-RESOLUTION::sort-baseline-teiis
  (declare (salience 7000))
  ?baseline-teii-uuids <- (object
                            (is-a BASELINE-TEII-UUIDS)
                            (uuids  $?uuids)
                            (sorted NO))
  =>
(printout t crlf "IDENTITY-RESOLUTION::sort-baseline-teiis" crlf)
  (modify-instance ?baseline-teii-uuids (uuids (sort string> $?uuids))
                                        (sorted YES)))


(defrule IDENTITY-RESOLUTION::found-next-nlp-teii-uuid
  (declare (salience 7000))
  ?scope-identity-resolution <- (object
                                 (is-a SCOPE-IDENTITY-RESOLUTION)
                                 (scope          ?scope)
                                 (nlp-teii-uuids $?nlp-teii-uuids))
                                (object
                                 (is-a NLP-CLASSIFICATION)
                                 (target-uuid    ?target-uuid)
                                 (taxonomy       "facebook")
                                 (teii-uuid      ?nlp-teii-uuid&~:(member$ ?nlp-teii-uuid
                                                                           $?nlp-teii-uuids)))
                                (object
                                 (is-a POSTED-DATA-ITEM)
                                 (uuid           ?target-uuid)
                                 (service-name   ?scope))
 =>
(printout t crlf "IDENTITY-RESOLUTION::found-next-nlp-teii-uuid" crlf)
 (modify-instance ?scope-identity-resolution
                  (nlp-teii-uuids (create$ $?nlp-teii-uuids ?nlp-teii-uuid))))

(defrule IDENTITY-RESOLUTION::populate-resolution-coordinates
  (declare (salience 6000))
                                (object
                                 (is-a BASELINE-TEII-UUIDS)
                                 (uuids  $?baseline-teii-uuids)
                                 (sorted YES))
  ?scope-identity-resolution <- (object
                                 (is-a SCOPE-IDENTITY-RESOLUTION)
                                 (nlp-teii-uuids         $?nlp-teii-uuids)
                                 (resolution-coordinates $?resolution-coordinates&:(= 0 (length$ $?resolution-coordinates))))
  =>
(printout t crlf "IDENTITY-RESOLUTION::populate-resolution-coordinates" crlf)
  (bind ?new-resolution-coordinates (create$))
  (progn$ (?baseline-teii-uuid ?baseline-teii-uuids)
          (if (member$ ?baseline-teii-uuid $?nlp-teii-uuids)
              then
              (bind ?new-resolution-coordinates (create$ ?new-resolution-coordinates 1))
              (modify-instance ?scope-identity-resolution
                               (resolution-coordinates   ?new-resolution-coordinates))
              else
              (bind ?new-resolution-coordinates (create$ ?new-resolution-coordinates 0))
              (modify-instance ?scope-identity-resolution
                               (resolution-coordinates   ?new-resolution-coordinates)))))

(defrule IDENTITY-RESOLUTION::create-scope-identity-resolution
  (declare (salience 6000))
  (object
   (is-a SCOPE-IDENTITY-RESOLUTION)
   (scope                  ?scope)
   (resolution-coordinates $?resolution-coordinates))
  (object
   (is-a BASELINE-TEII-UUIDS)
   (uuids  $?baseline-teii-uuids)
   (sorted YES))
  (test (< 0 (length$ $?baseline-teii-uuids)))
  =>
(printout t crlf "IDENTITY-RESOLUTION::create-scope-identity-resolution" crlf)
  (bind ?running-total 0)
  (progn$ (?resolution-coordinate $?resolution-coordinates)
          (bind ?running-total (+ ?running-total ?resolution-coordinate)))

;   (printout t
;             crlf
;             crlf
;             crlf
;             ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" crlf
;             "EXPOSURE-SCOPE-IDENTITY-RESOLUTION" crlf
;             "?scope      -> " ?scope  crlf
;             "?resolution -> " (/ ?running-total (length$ $?baseline-teii-uuids))  crlf
;             "?running-total -> " ?running-total crlf
; ;            "$?baseline-teii-uuids -> " $?baseline-teii-uuids crlf
;             "(length$ $?baseline-teii-uuids) -> " (length$ $?baseline-teii-uuids) crlf
;             "(length$ $?resolution-coordinates) -> " (length$ $?resolution-coordinates) crlf
;             crlf
;             crlf
;             crlf)

  (make-instance of EXPOSURE-SCOPE-IDENTITY-RESOLUTION
                    (scope      ?scope)
                    (resolution (/ ?running-total (length$ $?baseline-teii-uuids)))))


(defrule IDENTITY-RESOLUTION::create-scope-identity-resolution-delta
  (declare (salience 6000))
  ?scope-identity-resolution-0 <- (object
                                   (is-a SCOPE-IDENTITY-RESOLUTION)
                                   (scope                  ?scope-0)
                                   (resolution-coordinates $?resolution-coordinates-0))
  ?scope-identity-resolution-1 <- (object
                                   (is-a SCOPE-IDENTITY-RESOLUTION)
                                   (scope                  ?scope-1&~?scope-0)
                                   (resolution-coordinates $?resolution-coordinates-1))
                                  (object
                                   (is-a BASELINE-TEII-UUIDS)
                                   (uuids  $?baseline-teii-uuids)
                                   (sorted YES))
                                  (not
                                   (object
                                    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA)
                                    (scope-0 ?scope-0)
                                    (scope-1 ?scope-1)))
                                  (not
                                   (object
                                    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA)
                                    (scope-0 ?scope-1)
                                    (scope-1 ?scope-0)))
                                  (test (< 0 (length$ $?baseline-teii-uuids)))
                                  (test (< 0 (length$ $?resolution-coordinates-0)))
                                  (test (< 0 (length$ $?resolution-coordinates-1)))
  =>
  ; (printout t
  ;           crlf
  ;           crlf
  ;           crlf
  ;           "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<" crlf
  ;           "EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA" crlf
  ;           "?scope-0    -> " ?scope-0  crlf
  ;           "?scope-1    -> " ?scope-1  crlf
  ;           "delta       -> " (send ?scope-identity-resolution-0
  ;                                   calculate-delta
  ;                                   ?scope-identity-resolution-1
  ;                                   (length$ $?baseline-teii-uuids))  crlf
  ;           crlf
  ;           crlf
  ;           crlf)
(printout t crlf "IDENTITY-RESOLUTION::create-scope-identity-resolution-delta" crlf)
  (make-instance of EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA
                    (scope-0      ?scope-0)
                    (scope-1      ?scope-1)
                    (delta        (send ?scope-identity-resolution-0
                                        calculate-delta
                                        ?scope-identity-resolution-1
                                        (length$ $?baseline-teii-uuids)))))



(defrule IDENTITY-RESOLUTION::create-exposure-identity-resolution
  (declare (salience 3000))
  (exists
   (object
    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION)))
  (exists
   (object
    (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA)))
  =>
(printout t crlf "IDENTITY-RESOLUTION::create-exposure-identity-resolution" crlf)
  (bind ?exposure-scope-identity-resolution-total        0)
  (bind ?exposure-scope-identity-resolution-count        0)

  (bind ?exposure-scope-identity-resolution-delta-total  0)
  (bind ?exposure-scope-identity-resolution-delta-count  0)

  (bind ?exposure-scope-identity-resolution-average      0)
  (bind ?exposure-scope-dentity-resolution-delta-average 0)


  (do-for-all-instances ((?exposure-scope-identity-resolution EXPOSURE-SCOPE-IDENTITY-RESOLUTION))
                        TRUE
                        (bind ?exposure-scope-identity-resolution-total
                              (send ?exposure-scope-identity-resolution get-resolution))
                        (bind ?exposure-scope-identity-resolution-count
                              (+ 1 ?exposure-scope-identity-resolution-count))

                        ; (printout t
                        ;           crlf
                        ;           ":::::::::::::::::::::::::::::"
                        ;           crlf
                        ;           "(send ?exposure-scope-identity-resolution get-scope) -> " (send ?exposure-scope-identity-resolution get-scope)
                        ;           crlf
                        ;           "(send ?exposure-scope-identity-resolution get-resolution) -> " (send ?exposure-scope-identity-resolution get-resolution)
                        ;           crlf

                        )

  (do-for-all-instances ((?exposure-scope-identity-resolution-delta EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA))
                        TRUE
                        (bind ?exposure-scope-identity-resolution-delta-total
                              (send ?exposure-scope-identity-resolution-delta get-delta))
                        (bind ?exposure-scope-identity-resolution-delta-count
                              (+ 1 ?exposure-scope-identity-resolution-delta-count)))


  ; (printout t
  ;           crlf
  ;             "==========================================================="
  ;           crlf
  ;           "?exposure-scope-identity-resolution-total       -> " ?exposure-scope-identity-resolution-total
  ;           crlf
  ;           "?exposure-scope-identity-resolution-count       -> " ?exposure-scope-identity-resolution-count
  ;           crlf
  ;           "?exposure-scope-identity-resolution-delta-total -> " ?exposure-scope-identity-resolution-delta-total
  ;           crlf
  ;           "?exposure-scope-identity-resolution-delta-count -> " ?exposure-scope-identity-resolution-delta-count
  ;           crlf)


  (bind ?exposure-scope-identity-resolution-average       (/ ?exposure-scope-identity-resolution-total
                                                             ?exposure-scope-identity-resolution-count))
  (bind ?exposure-scope-identity-resolution-delta-average (/ ?exposure-scope-identity-resolution-delta-total
                                                             ?exposure-scope-identity-resolution-delta-count))

  ; (aIR * (2 - aD)) / 2
  ; the idea is that the overall identity resolution is
  ; produced by adjusting the average resolution by the
  ; average delta; the smaller the delta the higher the
  ; overall resolution
  (bind ?identity-resolution (/ (* ?exposure-scope-identity-resolution-average
                                   (- 2 ?exposure-scope-identity-resolution-delta-average))
                                2))


  (make-instance of
                 EXPOSURE-IDENTITY-RESOLUTION
                 (resolution ?identity-resolution)))


(defrule IDENTITY-RESOLUTION::purge-existing-scope-identity-resolution-objects
  (declare (salience -5000))
  ?scope-identity-resolution <- (object
                                 (is-a SCOPE-IDENTITY-RESOLUTION)
                                 (scope ?scope))
                                (object
                                 (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION)
                                 (scope ?scope))
  =>
(printout t crlf "IDENTITY-RESOLUTION::purge-existing-scope-identity-resolution-objects" crlf)
  (unmake-instance ?scope-identity-resolution))


(defrule IDENTITY-RESOLUTION::purge-existing-baseline-teii-uuids
  (declare (salience -5010))
  ?baseline-teii-uuids <- (object
                           (is-a BASELINE-TEII-UUIDS))
  =>
  (printout t crlf "IDENTITY-RESOLUTION::purge-existing-baseline-teii-uuids" crlf)
  (unmake-instance ?baseline-teii-uuids)
  (return))



