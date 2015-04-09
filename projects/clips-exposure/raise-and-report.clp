(defclass RAISE-AND-REPORT::EXPOSURE-INCIDENT-TITLE (is-a USER)
   (slot incident-title (type LEXEME)))


(defclass RAISE-AND-REPORT::EXPOSURE-CONSTANTS (is-a USER)
    (slot other-service-youtube-video-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.25))
    (slot other-service-youtube-video-exposure-who-exposure-constant            (type NUMBER) (default 0.1))
    (slot other-service-youtube-video-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.25))
    (slot other-service-youtube-video-exposure-what-exposure-constant           (type NUMBER) (default 0.1))
    (slot other-service-youtube-video-exposure-where-instance-exposure-constant (type NUMBER) (default 0.25))
    (slot other-service-youtube-video-exposure-where-exposure-constant          (type NUMBER) (default 0.1))

    (slot other-service-user-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.25))
    (slot other-service-user-name-exposure-who-exposure-constant            (type NUMBER) (default 0.1))
    (slot other-service-user-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.25))
    (slot other-service-user-name-exposure-what-exposure-constant           (type NUMBER) (default 0.1))
    (slot other-service-user-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.25))
    (slot other-service-user-name-exposure-where-exposure-constant          (type NUMBER) (default 0.1))

    (slot last-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.25))
    (slot last-name-exposure-who-exposure-constant            (type NUMBER) (default 0.06))
    (slot last-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot last-name-exposure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot last-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.0))
    (slot last-name-exposure-where-exposure-constant          (type NUMBER) (default 0.0))

    (slot middle-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.25))
    (slot middle-name-exposure-who-exposure-constant            (type NUMBER) (default 0.01))
    (slot middle-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot middle-name-exposure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot middle-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.0))
    (slot middle-name-exposure-where-exposure-constant          (type NUMBER) (default 0.0))

    (slot first-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.25))
    (slot first-name-exposure-who-exposure-constant            (type NUMBER) (default 0.005))
    (slot first-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot first-name-exposure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot first-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.0))
    (slot first-name-exposure-where-exposure-constant          (type NUMBER) (default 0.0))

    (slot hometown-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.0))
    (slot hometown-name-exposure-who-exposure-constant            (type NUMBER) (default 0.0))
    (slot hometown-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot hometown-name-exposure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot hometown-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.33))
    (slot hometown-name-exposure-where-exposure-constant          (type NUMBER) (default 0.1))

    (slot high-school-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.0))
    (slot high-school-name-exposure-who-exposure-constant            (type NUMBER) (default 0.0))
    (slot high-school-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot high-school-name-exposure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot high-school-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0.33))
    (slot high-school-name-exposure-where-exposure-constant          (type NUMBER) (default 0.055))

    (slot facebook-email-expsosure-who-instance-exposure-constant   (type NUMBER) (default 0.33))
    (slot facebook-email-expsosure-who-exposure-constant            (type NUMBER) (default 0.1))
    (slot facebook-email-expsosure-what-instance-exposure-constant  (type NUMBER) (default 0.0))
    (slot facebook-email-expsosure-what-exposure-constant           (type NUMBER) (default 0.0))
    (slot facebook-email-expsosure-where-instance-exposure-constant (type NUMBER) (default 0.0))
    (slot facebook-email-expsosure-where-exposure-constant          (type NUMBER) (default 0.0))

    (slot personal-interest-exposure-who-instance-exposure-constant   (type NUMBER) (default 0))
    (slot personal-interest-exposure-who-exposure-constant            (type NUMBER) (default 0))
    (slot personal-interest-exposure-what-instance-exposure-constant  (type NUMBER) (default 0.1))
    (slot personal-interest-exposure-what-exposure-constant           (type NUMBER) (default 0.47))
    (slot personal-interest-exposure-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot personal-interest-exposure-where-exposure-constant          (type NUMBER) (default 0))

    (slot reused-login-name-who-instance-exposure-constant   (type NUMBER) (default 0.5))
    (slot reused-login-name-who-exposure-constant            (type NUMBER) (default 0.15))
    (slot reused-login-name-what-instance-exposure-constant  (type NUMBER) (default 0.5))
    (slot reused-login-name-what-exposure-constant           (type NUMBER) (default 0.15))
    (slot reused-login-name-where-instance-exposure-constant (type NUMBER) (default 0.5))
    (slot reused-login-name-where-exposure-constant          (type NUMBER) (default 0.15))

    (slot intrascope-aggregated-first-and-last-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.6))
    (slot intrascope-aggregated-first-and-last-name-exposure-who-exposure-constant            (type NUMBER) (default 0.2))
    (slot intrascope-aggregated-first-and-last-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot intrascope-aggregated-first-and-last-name-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot intrascope-aggregated-first-and-last-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot intrascope-aggregated-first-and-last-name-exposure-where-exposure-constant          (type NUMBER) (default 0))

    (slot interscope-aggregated-first-and-last-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.6))
    (slot interscope-aggregated-first-and-last-name-exposure-who-exposure-constant            (type NUMBER) (default 0.07))
    (slot interscope-aggregated-first-and-last-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot interscope-aggregated-first-and-last-name-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot interscope-aggregated-first-and-last-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot interscope-aggregated-first-and-last-name-exposure-where-exposure-constant          (type NUMBER) (default 0))

    (slot potential-interscope-aggregated-first-and-last-name-exposure-who-instance-exposure-constant   (type NUMBER) (default 0.6))
    (slot potential-interscope-aggregated-first-and-last-name-exposure-who-exposure-constant            (type NUMBER) (default 0.045))
    (slot potential-interscope-aggregated-first-and-last-name-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-first-and-last-name-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-first-and-last-name-exposure-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-first-and-last-name-exposure-where-exposure-constant          (type NUMBER) (default 0))

    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-who-instance-exposure-constant   (type NUMBER) (default 0))
    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-who-exposure-constant            (type NUMBER) (default 0))
    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-where-instance-exposure-constant (type NUMBER) (default 0.6))
    (slot intrascope-aggregated-high-school-and-hometown-names-exposure-where-exposure-constant          (type NUMBER) (default 0.2))

    (slot interscope-aggregated-high-school-and-hometown-names-exposure-who-instance-exposure-constant   (type NUMBER) (default 0))
    (slot interscope-aggregated-high-school-and-hometown-names-exposure-who-exposure-constant            (type NUMBER) (default 0))
    (slot interscope-aggregated-high-school-and-hometown-names-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot interscope-aggregated-high-school-and-hometown-names-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot interscope-aggregated-high-school-and-hometown-names-exposure-where-instance-exposure-constant (type NUMBER) (default 0.6))
    (slot interscope-aggregated-high-school-and-hometown-names-exposure-where-exposure-constant          (type NUMBER) (default 0.07))

    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-who-instance-exposure-constant   (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-who-exposure-constant            (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-what-exposure-constant           (type NUMBER) (default 0))
    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-where-instance-exposure-constant (type NUMBER) (default 0.6))
    (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-where-exposure-constant          (type NUMBER) (default 0.045))

    (slot scope-with-high-identity-resolution-who-instance-exposure-constant   (type NUMBER) (default 0.33))
    (slot scope-with-high-identity-resolution-who-exposure-constant            (type NUMBER) (default 0.06))
    (slot scope-with-high-identity-resolution-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot scope-with-high-identity-resolution-what-exposure-constant           (type NUMBER) (default 0.08))
    (slot scope-with-high-identity-resolution-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot scope-with-high-identity-resolution-where-exposure-constant          (type NUMBER) (default 0.08))

    (slot scopes-with-similar-identity-resolution-who-instance-exposure-constant   (type NUMBER) (default 0.4))
    (slot scopes-with-similar-identity-resolution-who-exposure-constant            (type NUMBER) (default 0.1))
    (slot scopes-with-similar-identity-resolution-what-instance-exposure-constant  (type NUMBER) (default 0))
    (slot scopes-with-similar-identity-resolution-what-exposure-constant           (type NUMBER) (default 0.1))
    (slot scopes-with-similar-identity-resolution-where-instance-exposure-constant (type NUMBER) (default 0))
    (slot scopes-with-similar-identity-resolution-where-exposure-constant          (type NUMBER) (default 0.1))

    ; (slot  -who-instance-exposure-constant   (type NUMBER) (default 0))
    ; (slot  -who-exposure-constant            (type NUMBER) (default 0))
    ; (slot  -what-instance-exposure-constant  (type NUMBER) (default 0))
    ; (slot  -what-exposure-constant           (type NUMBER) (default 0))
    ; (slot  -where-instance-exposure-constant (type NUMBER) (default 0))
    ; (slot  -where-exposure-constant          (type NUMBER) (default 0))

    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(deffunction RAISE-AND-REPORT::get-exposure-rising-taper-curve-value (?exposure-value)

  ; this is the interval the logistic curve (see notes below),
  ; between x values -1 and 6. 
  
  (if (not (= 0 ?exposure-value))
      then
      (bind ?adjustedExposureValue (- (* 7 ?exposure-value) 1))

      (/ 1 (+ 1 (exp (- 0 ?adjustedExposureValue))))
      else
      0))


(deffunction RAISE-AND-REPORT::get-exposure-sigmoid-value (?exposure-value)

  ; the logistic curve is goes asymptotic at -6 and 6.
  ; the exposure results range from  0 to 1. to make
  ; them fit with the range of the logistic equation
  ; multiply by 12 and subtract 6.
  
  (bind ?adjustedExposureValue (- (* 12 ?exposure-value) 6))

  (/ 1 (+ 1 (exp (- 0 ?adjustedExposureValue)))))


(deffunction RAISE-AND-REPORT::get-status-value-from-exposure-value (?exposure-value)

  ; the result of the logistic equation, between 0 and 1,
  ; is then used as a selector for one of the 25 status
  ; values by multiplying it by 24 and then rouding.

  (round (* 24
            (get-exposure-sigmoid-value ?exposure-value))))


(deffunction RAISE-AND-REPORT::normalize-status-value (?status-value)

  ; ensure that we have a value in the 0 through 24 range in
  ; case a calulation goes wonky

  (bind ?normalized-status-value ?status-value)


  (if (< ?status-value 0)
      then
      (bind ?normalized-status-value 0)
      else
      (if (> ?status-value 24)
          then
          (bind ?normalized-status-value 24)))

  ?normalized-status-value)

(deffunction RAISE-AND-REPORT::generalized-logistic-function (?t  ; Y(t)
                                                              ?A  ; the lower asymptote
                                                              ?K  ; the upper asymptote
                                                              ?B  ; the growth rate
                                                              ?v  ; affects near which asymptote maximum growth occurs v > 0
                                                              ?Q  ; depends on the value Y(0)
                                                              ?M) ; the time of maximum growth if Q=v
  (bind ?e (exp 1))
  (bind ?qe-exponent (- 0 (* ?B (- ?t ?M))))
  (bind ?divisor-exponent (/ 1 ?v))
  (+ ?A
     (/ (- ?K ?A)
        (** (+ 1 (* ?Q (** ?e ?qe-exponent))) ?divisor-exponent))))

(deffunction RAISE-AND-REPORT::synthesize-exposure-status-value (?normalized-who-status-value
                                                                 ?normalized-what-status-value
                                                                 ?normalized-where-status-value)

  (generalized-logistic-function (+ (send [current-exposure-values] get-who-value)
                                    (send [current-exposure-values] get-what-value)
                                    (send [current-exposure-values] get-where-value))
                                 0
                                 1
                                 (+ 2.5
                                    (* 0.95
                                       (/ 1
                                          (* (/ 1 (send [current-exposure-values] get-who-value))
                                             (/ 1 (send [current-exposure-values] get-what-value)))))
                                    (* 0.9
                                       (/ 1
                                          (* (/ 1 (send [current-exposure-values] get-who-value))
                                             (/ 1 (send [current-exposure-values] get-where-value)))))
                                    (* 0.85
                                       (/ 1
                                          (* (/ 1 (send [current-exposure-values] get-what-value))
                                             (/ 1 (send [current-exposure-values] get-where-value))))))
                                 0.5
                                 0.5
                                 1.2))


(defclass RAISE-AND-REPORT::CURRENT-EXPOSURE-VALUES (is-a USER)
  (slot who-value   (type INTEGER) (default 0))
  (slot what-value  (type INTEGER) (default 0))
  (slot where-value (type INTEGER) (default 0)))

(defclass RAISE-AND-REPORT::EXPOSURE-INCIDENT-COUNTER (is-a USER)
  (slot incident-title (type LEXEME)))

(defclass RAISE-AND-REPORT::STATS (is-a USER)
  (slot incident-count                                                                (type INTEGER) (default -1))
  (slot scope-count                                                                   (type INTEGER) (default -1))
  (slot other-service-youtube-video-exposure-count                                    (type INTEGER) (default -1))
  (slot other-service-user-name-exposure-count                                        (type INTEGER) (default -1))
  (slot last-name-exposure-count                                                      (type INTEGER) (default -1))
  (slot middle-name-exposure-count                                                    (type INTEGER) (default -1))
  (slot first-name-exposure-count                                                     (type INTEGER) (default -1))
  (slot hometown-name-exposure-count                                                  (type INTEGER) (default -1))
  (slot high-school-name-exposure-count                                               (type INTEGER) (default -1))
  (slot facebook-email-exposure-count                                                 (type INTEGER) (default -1))
  (slot personal-interest-exposure-count                                              (type INTEGER) (default -1))
  (slot reused-login-name-count                                                       (type INTEGER) (default -1))
  (slot intrascope-aggregated-first-and-last-name-exposure-count                      (type INTEGER) (default -1))
  (slot interscope-aggregated-first-and-last-name-exposure-count                      (type INTEGER) (default -1))
  (slot potential-interscope-aggregated-first-and-last-name-exposure-count            (type INTEGER) (default -1))
  (slot intrascope-aggregated-high-school-and-hometown-names-exposure-count           (type INTEGER) (default -1))
  (slot interscope-aggregated-high-school-and-hometown-names-exposure-count           (type INTEGER) (default -1))
  (slot potential-interscope-aggregated-high-school-and-hometown-names-exposure-count (type INTEGER) (default -1))
  (slot scope-with-high-identity-resolution-count                                     (type INTEGER) (default -1))
  (slot scopes-with-similar-identity-resolution-count                                 (type INTEGER) (default -1)))




(defrule RAISE-AND-REPORT::create-current-exposure-values
  (declare (salience 10000))
  (not
   (object
    (is-a CURRENT-EXPOSURE-VALUES)))
  =>
  (make-instance current-exposure-values of CURRENT-EXPOSURE-VALUES))

(defrule RAISE-AND-REPORT::create-stats
  (declare (salience 10000))
  (not
   (object
    (is-a STATS)))
  =>
  (bind ?incident-count (length$ (find-all-instances ((?incident EXPOSURE-INCIDENT)) TRUE)))
  (bind ?scope-count    (length$ (find-all-instances ((?scope    EXPOSURE-SCOPE))    TRUE)))

  (make-instance stats of STATS
                          (incident-count ?incident-count)
                          (scope-count    ?scope-count)))

(defrule RAISE-AND-REPORT::create-exposure-incident-titles
  (declare (salience 10000))
  (not
   (object
    (is-a EXPOSURE-INCIDENT-TITLE)))
  =>
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title other-service-youtube-video-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title other-service-user-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title last-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title middle-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title first-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title hometown-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title high-school-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title facebook-email-expsosure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title personal-interest-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title reused-login-name))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title intrascope-aggregated-first-and-last-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title interscope-aggregated-first-and-last-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title potential-interscope-aggregated-first-and-last-name-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title intrascope-aggregated-high-school-and-hometown-names-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title interscope-aggregated-high-school-and-hometown-names-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title potential-interscope-aggregated-high-school-and-hometown-names-exposure))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title scope-with-high-identity-resolution))
  (make-instance of EXPOSURE-INCIDENT-TITLE (incident-title scopes-with-similar-identity-resolution))
  
  )

(defrule RAISE-AND-REPORT::create-exposure-constants
  (declare (salience 10000))
  (not
   (object
    (is-a EXPOSURE-CONSTANTS)))
  =>
  (make-instance exposure-constants of EXPOSURE-CONSTANTS))


(defrule RAISE-AND-REPORT::create-incident-counter
  (declare (salience 10000))
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title ?incident-title))
  =>

  ; (printout t
  ;           crlf
  ;           "-----------------------"
  ;           "?incident-title -> " ?incident-title crlf
  ;           crlf)
  (make-instance of EXPOSURE-INCIDENT-COUNTER
                    (incident-title ?incident-title)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defrule RAISE-AND-REPORT::update-incident-stats
  (declare (salience 9000))
  ?exposure-incident-counter <- (object
                                 (is-a EXPOSURE-INCIDENT-COUNTER)
                                 (incident-title ?incident-title))
  =>
  (bind ?incident-count-slot (sym-cat ?incident-title "-count"))

  ; (printout t
  ;           crlf
  ;           ":::::::::::::::::::::::::::::" crlf
  ;           "?incident-title      -> " ?incident-title crlf
  ;           "?incident-count-slot -> " ?incident-count-slot crlf
  ;           crlf)


  (unmake-instance ?exposure-incident-counter)  
  (modify-instance [stats]
                   (?incident-count-slot (+ 1
                                            (send [stats]
                                                  (sym-cat "get-"
                                                           ?incident-count-slot))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; the general idea is how to account for multiple incidents of the same type,
  ; their diminishing effect on exposure, and ultimately how much this 
  ; type of incident can overall effect the exposure values.
  ;
  ; ?<type>instance-exposure-constant  : the base input for any one instance
  ; ?<type>running-input-value         : running total of the above
  ; ?<type>current-exposure-multiplier : the output of the exposure taper curve
  ;                                    : for an input of ?running-input-value
  ; ?<type>exposure-constant           : the maximum exposure level for this
  ;                                    : incident type. this will be attenuated
  ;                                    : by ?current-exposure-multiplier
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defrule RAISE-AND-REPORT::raise-exposure-for-exposure-incident
  (declare (salience 5000))
  (object
   (is-a EXPOSURE-INCIDENT-TITLE)
   (incident-title ?incident-title))
  =>
  (bind ?who-running-input-value           0)
  (bind ?who-current-exposure-multiplier   0)

  (bind ?what-running-input-value          0)
  (bind ?what-current-exposure-multiplier  0)

  (bind ?where-running-input-value         0)
  (bind ?where-current-exposure-multiplier 0)
                                        

  (do-for-all-instances ((?exposure-incident EXPOSURE-INCIDENT))
                        (eq ?incident-title
                            (send ?exposure-incident get-incident-title))
                        
                        (bind ?who-running-input-value
                              (+ ?who-running-input-value
                                 (send [exposure-constants] (sym-cat "get-"
                                                                     ?incident-title
                                                                     "-who-instance-exposure-constant"))))
                        (bind ?who-current-exposure-multiplier
                              (get-exposure-rising-taper-curve-value ?who-running-input-value))

                        (bind ?what-running-input-value
                              (+ ?what-running-input-value
                                 (send [exposure-constants] (sym-cat "get-"
                                                                     ?incident-title
                                                                     "-what-instance-exposure-constant"))))
                        (bind ?what-current-exposure-multiplier
                              (get-exposure-rising-taper-curve-value ?what-running-input-value))

                        (bind ?where-running-input-value
                              (+ ?where-running-input-value
                                 (send [exposure-constants] (sym-cat "get-"
                                                                     ?incident-title
                                                                     "-where-instance-exposure-constant"))))
                        (bind ?where-current-exposure-multiplier
                              (get-exposure-rising-taper-curve-value ?where-running-input-value)))
                        
  (modify-instance [current-exposure-values]
                   (who-value   (+ (send [current-exposure-values] get-who-value)
                                   (* (send [exposure-constants] (sym-cat "get-"
                                                                          ?incident-title
                                                                          "-who-exposure-constant"))
                                      ?who-current-exposure-multiplier)))
                   (what-value  (+ (send [current-exposure-values] get-what-value)
                                   (* (send [exposure-constants] (sym-cat "get-"
                                                                          ?incident-title
                                                                          "-what-exposure-constant"))
                                      ?what-current-exposure-multiplier)))
                   (where-value (+ (send [current-exposure-values] get-where-value)
                                   (* (send [exposure-constants] (sym-cat "get-"
                                                                          ?incident-title
                                                                          "-where-exposure-constant"))
                                      ?where-current-exposure-multiplier))))

  (printout t
            crlf
            "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
            crlf
            "RAISE-AND-REPORT::raise-exposure-for-exposure-incident: " ?incident-title
            crlf
            "(send [current-exposure-values] get-who-value)   ->" (send [current-exposure-values] get-who-value)
            crlf
            "(send [current-exposure-values] get-what-value)  ->" (send [current-exposure-values] get-what-value)
            crlf
            "(send [current-exposure-values] get-where-value) ->" (send [current-exposure-values] get-where-value)
            crlf)
                                                                     

  (get-status-value-from-exposure-value (send [current-exposure-values] get-who-value))
  (get-status-value-from-exposure-value (send [current-exposure-values] get-what-value))
  (get-status-value-from-exposure-value (send [current-exposure-values] get-where-value)))


(defrule RAISE-AND-REPORT::raise-exposure-level-due-to-scope-association-metrics
  (declare (salience -9000))
  (object
   (is-a EXPOSURE-ASSOCIATION)
   (association ?association))
  =>
  (bind ?level-increase-ceiling 3)
  (bind ?level-increase (round (* ?level-increase-ceiling
                                  (get-exposure-rising-taper-curve-value ?association))))
  (printout t
            crlf
            "///////////////////////////////////////////////"
            crlf
            "?association    -> " ?association
            crlf
            "?level-increase -> " ?level-increase
            crlf)
  
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-who-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-what-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-where-value)))))

(defrule RAISE-AND-REPORT::raise-exposure-level-due-to-identity-resolution
  (declare (salience -9000))
  (object
   (is-a EXPOSURE-IDENTITY-RESOLUTION)
   (resolution ?resolution))
  =>
  (bind ?level-increase-ceiling 2)
  (bind ?level-increase (round (* ?level-increase-ceiling
                                  (get-exposure-rising-taper-curve-value ?resolution))))
  (printout t
            crlf
            "///////////////////////////////////////////////"
            crlf
            "?resolution     -> " ?resolution
            crlf
            "?level-increase -> " ?level-increase
            crlf)

  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-who-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-what-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-where-value)))))

(defrule RAISE-AND-REPORT::raise-exposure-level-due-to-discoverability
  (declare (salience -9000))
  (object
   (is-a EXPOSURE-DISCOVERABILITY)
   (discoverability ?discoverability))
  =>
  (bind ?level-increase-ceiling 3)
  (bind ?level-increase (round (* ?level-increase-ceiling
                                  (get-exposure-rising-taper-curve-value ?discoverability))))
  (printout t
            crlf
            "///////////////////////////////////////////////"
            crlf
            "?discoverability -> " ?discoverability
            crlf
            "?level-increase  -> " ?level-increase
            crlf)

  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-who-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-what-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-where-value)))))

(defrule RAISE-AND-REPORT::raise-exposure-level-due-to-privacy-dilution
  (declare (salience -9000))
  (object
   (is-a EXPOSURE-SCOPE-PRIVACY-DILUTION-METRICS)
   (scope    "overall")
   (dilution ?dilution))
  =>
  (bind ?level-increase-ceiling 3)
  (bind ?level-increase (round (* ?level-increase-ceiling
                                  (get-exposure-rising-taper-curve-value ?dilution))))
  (printout t
            crlf
            "///////////////////////////////////////////////"
            crlf
            "?dilution       -> " ?dilution
            crlf
            "?level-increase -> " ?level-increase
            crlf)

  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-who-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-what-value))))
  (normalize-status-value (+ ?level-increase (get-status-value-from-exposure-value (send [current-exposure-values] get-where-value)))))


;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@
;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@
;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@
; this needs to become an accumulator for all the incidents
; and the consolidated status valuea
;
; all the info needs to be in the uploaded report...if we
; keep the post uuids, then the posts need to go with the
; report ------> THIS CAN BE PROCESSED ON THE SCHEME SIDE <------
;                      ^ ^ ^
;                      | | |
;                       or, since we have to make an
; accumulator anyway, we might want to accumulate the PDIs as
; well and send up a reasonably pre-formated (i.e., consed)
; report
;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@
;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@
;@#$%@#%#$^$&$^%*%&*&#$%^@$#%@$#%^&$%^&^#$%!#$@$#%$^$%@$$#%#%^@

(defglobal ?*exposure-report*              = "")
(defglobal ?*processed-exposure-incidents* = (create$))


(defrule RAISE-AND-REPORT::collate-incidents
  (declare (salience -10000))
  ?exposure-incident <- (object
                         (is-a EXPOSURE-INCIDENT)
                         (uuid           ?incident-uuid&~:(member$ ?incident-uuid
                                                                   ?*processed-exposure-incidents*))
                         (incident-title ?incident-title)
                         (incident-type  ?incident-type)
                         (post-uuids     $?post-uuids))
  =>
  (bind ?exposure-incident-details (str-cat "'(\"exposure-incident\"(\""
                                            ?incident-uuid
                                            "\" \""
                                            ?incident-title
                                            "\" \""
                                            ?incident-type
                                            "\" ("))

  (do-for-all-instances ((?posted-data-item POSTED-DATA-ITEM))
                        (member$ (send ?posted-data-item get-uuid) $?post-uuids)
                        (bind ?exposure-incident-details
                              (str-cat ?exposure-incident-details
                                       "(\"posted-data-item\"(\""
                                       (send ?posted-data-item get-service-name)
                                       "\" \""
                                       (send ?posted-data-item get-raw-url)
                                       "\" \""
                                       (send ?posted-data-item get-raw-post)
                                       "\"))")))
  
  (bind ?exposure-incident-details (str-cat ?exposure-incident-details
                                            ")))"
    ; this is ugly, but 'str-cat' doesn't handle escaped 
    ; characters...so, we have to put in a hard newline
                                            "
"))

  (bind ?*exposure-report* (str-cat ?*exposure-report* ?exposure-incident-details))

  (bind ?*processed-exposure-incidents*
        (create$ ?*processed-exposure-incidents*
                 ?incident-uuid)))

(defrule RAISE-AND-REPORT::put-exposure-report
  (declare (salience -10000))
  (object
   (is-a EXPOSURE-UUID)
   (uuid ?exposure-uuid))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (uuid           ?incident-uuid&:(member$ ?incident-uuid
                                             ?*processed-exposure-incidents*))))
  =>
  (bind ?exposure-values (str-cat "'(\"exposure-values\"("
                                  (send [current-exposure-values] get-who-value)
                                  " "
                                  (send [current-exposure-values] get-what-value)
                                  " "
                                  (send [current-exposure-values] get-where-value)
                                  " "
                                  (synthesize-exposure-status-value (send [current-exposure-values] get-who-value)
                                                                    (send [current-exposure-values] get-what-value)
                                                                    (send [current-exposure-values] get-where-value))
                                  "))"
    ; this is ugly, but 'str-cat' doesn't handle escaped 
    ; characters...so, we have to put in a hard newline
                                  "
"))
  (bind ?*exposure-report* (str-cat ?*exposure-report* ?exposure-values))
  (put-exposure-results ?exposure-uuid (base64-encode ?*exposure-report*)))




