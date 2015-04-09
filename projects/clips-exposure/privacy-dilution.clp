

(defclass PRIVACY-DILUTION::PRIVACY-DOMAIN-POST (is-a USER))

(defclass PRIVACY-DILUTION::PRIVACY-DOMAIN (is-a USER)
  (slot count (type NUMBER)))

(defclass PRIVACY-DILUTION::DILUTING-POST (is-a USER)
  (slot uuid  (type LEXEME))
  (slot scope (type LEXEME)))

(defclass PRIVACY-DILUTION::NON-DILUTING-POST (is-a USER)
  (slot uuid  (type LEXEME))
  (slot scope (type LEXEME)))

(defclass PRIVACY-DILUTION::DILUTION-COUNTS (is-a USER)
  (slot scope                    (type LEXEME))
  (slot total-diluting-posts     (type NUMBER))
  (slot total-non-diluting-posts (type NUMBER)))

(defclass PRIVACY-DILUTION::INTERNAL-DILUTION-METRICS (is-a USER)
  (slot scope    (type LEXEME))
  (slot dilution (type NUMBER))
  (slot counted  (type LEXEME)))

(defclass PRIVACY-DILUTION::SCOPES-PROCESSED (is-a USER)
  (slot count (type NUMBER)))


(defrule PRIVACY-DILUTION::found-privacy-domain-post
  (object
   (is-a NLP-CLASSIFICATION)
   (taxonomy "facebook"))
  =>
;  (printout t crlf "PRIVACY-DILUTION::found-privacy-domain-post" crlf)
  (make-instance of PRIVACY-DOMAIN-POST))

(defrule PRIVACY-DILUTION::update-privacy-domain
  ?privacy-domain      <- (object
                           (is-a PRIVACY-DOMAIN)
                           (count ?count))
  ?privacy-domain-post <- (object
                           (is-a PRIVACY-DOMAIN-POST))
  =>
  ;(printout t crlf "PRIVACY-DILUTION::update-privacy-domain" crlf)
  (modify-instance ?privacy-domain (count (+ 1 ?count)))
  (unmake-instance ?privacy-domain-post))

(defrule PRIVACY-DILUTION::found-diluting-post
  (object
   (is-a NLP-CLASSIFICATION)
   (taxonomy     "facebook")
   (target-uuid  ?target-uuid))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ?service-name&~"facebook")
   (uuid         ?target-uuid))
  =>
 ; (printout t crlf "PRIVACY-DILUTION::found-diluting-post" crlf)
  (make-instance of DILUTING-POST
                    (uuid  ?target-uuid)
                    (scope ?service-name)))

(defrule PRIVACY-DILUTION::found-non-diluting-post
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ?service-name&~"facebook")
   (uuid         ?non-diluting-post-uuid))
  (not
   (object
    (is-a NLP-CLASSIFICATION)
    (taxonomy    "facebook")
    (target-uuid ?non-diluting-post-uuid)))
  =>
;  (printout t crlf "PRIVACY-DILUTION::found-non-diluting-post" crlf)
  (make-instance of NON-DILUTING-POST
                     (uuid  ?non-diluting-post-uuid)
                     (scope ?service-name)))

(defrule PRIVACY-DILUTION::update-single-scope-dilution-counts
  ?dilution-counts <- (object
                       (is-a DILUTION-COUNTS)
                       (scope                ?scope)
                       (total-diluting-posts ?total-diluting-posts))
  ?diluting-post   <- (object
                       (is-a DILUTING-POST)
                       (scope                ?scope&~"overall"))
  =>
  ;(printout t crlf "total-diluting-posts (" ?scope "): " (+ 1 ?total-diluting-posts) crlf)
  (modify-instance ?dilution-counts (total-diluting-posts (+ 1 ?total-diluting-posts)))
  (unmake-instance ?diluting-post))

(defrule PRIVACY-DILUTION::update-single-scope-non-dilution-counts
  ?dilution-counts   <- (object
                         (is-a DILUTION-COUNTS)
                         (scope                    ?scope)
                         (total-non-diluting-posts ?total-non-diluting-posts))
  ?non-diluting-post <- (object
                         (is-a NON-DILUTING-POST)
                         (scope                    ?scope&~"overall"))
  =>
 ; (printout t crlf "total-non-diluting-posts: (" ?scope "): " (+ 1 ?total-non-diluting-posts) crlf)
  (modify-instance ?dilution-counts (total-non-diluting-posts (+ 1 ?total-non-diluting-posts)))
  (unmake-instance ?non-diluting-post))

(defrule PRIVACY-DILUTION::create-dilution-counts
  (object
   (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
   (scope ?scope))
  =>
;  (printout t crlf "PRIVACY-DILUTION::create-dilution-counts" crlf)
  (make-instance of DILUTION-COUNTS
                    (scope                    ?scope)
                    (total-diluting-posts     0.0)
                    (total-non-diluting-posts 0.0)))

(defrule PRIVACY-DILUTION::create-privacy-domain
  (not
   (object
    (is-a PRIVACY-DOMAIN)))
  =>
 ; (printout t crlf "PRIVACY-DILUTION::create-privacy-domain" crlf)
  (make-instance of PRIVACY-DOMAIN (count 0)))


(defrule PRIVACY-DILUTION::create-scopes-processed
  (not
   (object
    (is-a SCOPES-PROCESSED)))
  =>
;  (printout t crlf "PRIVACY-DILUTION::create-scopes-processed" crlf)
  (make-instance of SCOPES-PROCESSED (count 0)))
  
(defrule PRIVACY-DILUTION::found-exposure-scope-privacy-dilution-metrics
  (object
   (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
   (scope ?scope&~"overall"))
  =>
 ; (printout t crlf "PRIVACY-DILUTION::found-exposure-scope-privacy-dilution-metrics" crlf)
  (make-instance of INTERNAL-DILUTION-METRICS
                    (scope    ?scope)
                    (dilution -1.0)
                    (counted  NO)))

(defrule PRIVACY-DILUTION::update-single-scope-privacy-dilution-metrics
  (declare (salience -9000))
  ?dilution-metrics <- (object
                        (is-a INTERNAL-DILUTION-METRICS)
                        (scope    ?scope)
                        (dilution -1.0))
                       (object
                        (is-a DILUTION-COUNTS)
                        (scope                    ?scope)
                        (total-diluting-posts     ?total-diluting-posts))
                       (object
                        (is-a PRIVACY-DOMAIN)
                        (count                    ?count&~0))
  =>
;  (printout t crlf "PRIVACY-DILUTION::update-single-scope-privacy-dilution-metrics" crlf)
  (modify-instance ?dilution-metrics (scope    ?scope)
                                     (dilution (/ ?total-diluting-posts ?count))))

(defrule PRIVACY-DILUTION::count-dilution-metrics-scopes
  (declare (salience -9000))
  ?dilution-metrics <- (object
                        (is-a INTERNAL-DILUTION-METRICS)
                        (scope    ?scope)
                        (counted  NO))
  ?scopes-processed <- (object
                        (is-a SCOPES-PROCESSED)
                        (count ?count))
  =>
  (modify-instance ?scopes-processed (count   (+ 1 ?count)))
  (modify-instance ?dilution-metrics (counted YES)))

(defrule PRIVACY-DILUTION::sum-and-propagate-internal-dilution-metrics
  (declare (salience -9500))
  ?overall-dilution-metrics  <- (object
                                 (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
                                 (scope    "overall")
                                 (dilution ?overall-dilution))
  ?scope-dilution-metrics    <- (object
                                 (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
                                 (scope    ?scope))
  ?internal-dilution-metrics <- (object
                                 (is-a INTERNAL-DILUTION-METRICS)
                                 (scope    ?scope)
                                 (dilution ?scope-dilution))
  =>
  (printout t crlf "scope: " ?scope " dilution: " ?scope-dilution crlf)
  (modify-instance ?overall-dilution-metrics
                     (dilution (+ ?overall-dilution ?scope-dilution)))
  (modify-instance ?scope-dilution-metrics
                     (dilution ?scope-dilution))
  (unmake-instance ?internal-dilution-metrics))


(defrule PRIVACY-DILUTION::finish-overall-dilution-metrics-calculation
  (declare (salience -9500))
                                (not
                                 (object
                                  (is-a INTERNAL-DILUTION-METRICS)))
  ?overall-dilution-metrics  <- (object
                                 (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
                                 (scope    "overall")
                                 (dilution ?overall-dilution))
  ?scopes-processed          <- (object
                                 (is-a SCOPES-PROCESSED)
                                 (count ?count&~0))
  =>
  (printout t crlf "overall-dilution-metrics dilution: " (/ ?overall-dilution ?count) crlf)
  (modify-instance ?overall-dilution-metrics
                     (dilution (/ ?overall-dilution ?count)))
  (unmake-instance ?scopes-processed))


