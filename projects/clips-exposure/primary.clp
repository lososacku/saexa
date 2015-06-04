; Copyright 2015 Ryan B. Hicks


(defrule PRIMARY::found-reused-login-name
  (object
   (is-a NLP-CLASSIFICATION)
   (target-uuid    ?target-uuid-0)
   (classification login-name-found|profile-user-id-found|profile-display-name-found)
   (taxonomy       ?taxonomy)
   (item           ?login-name))
  (object
   (is-a NLP-CLASSIFICATION)
   (classification login-name-found|profile-user-id-found|profile-display-name-found)
   (target-uuid    ?target-uuid-1&~?target-uuid-0)
   (taxonomy       ~?taxonomy)
   (item           ?login-name))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title   reused-login-name)
    (post-uuids       $?post-uuids&:(member$ ?target-uuid-0 $?post-uuids)
                                  &:(member$ ?target-uuid-1 $?post-uuids))))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title reused-login-name)
    (incident-type  who)
    (post-uuids     (create$ ?target-uuid-0 ?target-uuid-1))))

(defrule PRIMARY::found-catalogued-constituent-exposure
  (declare (salience -1000))
  (object
   (is-a NLP-CLASSIFICATION)
   (target-uuid    ?target-uuid)
   (classification catalogued-constituent-found)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name   ?service-name&~"facebook")
   (uuid           ?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title personal-interest-exposure)
    (incident-type  what)
    (post-uuids     (create$ ?target-uuid))))

(defrule PRIMARY::found-facebook-email-address-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification email-address-found)
   (target-uuid    ?target-uuid)
   (taxonomy       "facebook")
   (item           ?item))
  =>
  (bind ?incident-uuid (get-uuid))

  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title facebook-email-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?target-uuid))))

(defrule PRIMARY::found-high-school-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification high-school-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"facebook")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title high-school-name-exposure)
    (incident-type  where)
    (post-uuids     (create$ ?pdi-uuid))))

(defrule PRIMARY::found-hometown-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification hometown-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"facebook")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title hometown-name-exposure)
    (incident-type  where)
    (post-uuids     (create$ ?pdi-uuid))))

(defrule PRIMARY::found-first-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification first-name-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"facebook")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title first-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?pdi-uuid))))

(defrule PRIMARY::found-middle-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification middle-name-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"facebook")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title middle-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?pdi-uuid))))

(defrule PRIMARY::found-last-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification last-name-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"facebook")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title last-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?pdi-uuid))))

(defrule PRIMARY::found-user-name-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification login-name-found|profile-user-id-found|profile-display-name-found)
   (target-uuid    ?target-uuid)
   (taxonomy       ?taxonomy)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name   ?pdi-service-name&~?taxonomy)
   (uuid           ?target-uuid))
  (not
   (object
    (is-a NLP-CLASSIFICATION)
    (classification login-name-found|profile-user-id-found|profile-display-name-found)
    (taxonomy       ?pdi-service-name)
    (item           ?item)))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title other-service-user-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?target-uuid))))


;
; add a rule to increase the exposure level if there's a url
; associated with the same post (this will likely only apply
; if it's a youtube video id)
;
(defrule PRIMARY::found-youtube-video-exposure
  (object
   (is-a NLP-CLASSIFICATION)
   (classification youtube-video-title-found|youtube-video-id-found)
   (target-uuid    ?target-uuid)
   (item           ?item))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name ~"youtube")
   (uuid           ?pdi-uuid&?target-uuid))
  =>
  (bind ?incident-uuid (get-uuid))
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ?incident-uuid)
    (incident-title other-service-youtube-video-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?pdi-uuid))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule PRIMARY::process-identity-resolution
  (declare (salience -9000))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-identity-resolution" crlf)
  (focus IDENTITY-RESOLUTION))

(defrule PRIMARY::process-scope-association
  (declare (salience -9100))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-scope-association" crlf)
  (focus SCOPE-ASSOCIATION))

(defrule PRIMARY::process-privacy-dilution
  (declare (salience -9200))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-privacy-dilution" crlf)
  (focus PRIVACY-DILUTION))

(defrule PRIMARY::process-scope-discoverability
  (declare (salience -9300))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-scope-discoverability" crlf)
  (focus SCOPE-DISCOVERABILITY))

(defrule PRIMARY::process-secondary
  (declare (salience -9400))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-secondary" crlf)
  (focus SECONDARY))

(defrule PRIMARY::process-tertiary
  (declare (salience -9500))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::process-tertiary" crlf)
  (focus TERTIARY))

(defrule PRIMARY::process-secondary-and-tertiary-incidents
  (declare (salience -9600))
  ?exposure-incident <- (object
                         (is-a EXPOSURE-INCIDENT)
                         (uuid                 ready-for-uuid)
                         (incident-title       ?incident-title)
                         (incident-type        ?incident-type)
                         (post-uuids           $?post-uuids))
  =>
  (bind ?incident-uuid (get-uuid))
  (modify-instance ?exposure-incident (uuid ?incident-uuid)))

(defrule PRIMARY::raise-exposure-level-and-report-incidents
  (declare (salience -9700))
  (exists
   (object
    (is-a EXPOSURE-INCIDENT)))
  =>
  (printout t crlf "PRIMARY::raise-exposure-level-and-report-incidents" crlf)
  (focus RAISE-AND-REPORT))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule PRIMARY::init-exposure-scope-privacy-dilution-metrics
  (declare (salience 10000))
  (not
   (object
    (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)))
  =>
  (make-instance of EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS (scope "overall")   (dilution 0.0))
  (make-instance of EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS (scope "tumblr")    (dilution 0.0))
  (make-instance of EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS (scope "twitter")   (dilution 0.0))
  (make-instance of EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS (scope "youtube")   (dilution 0.0))
  (make-instance of EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS (scope "instagram") (dilution 0.0)))


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

