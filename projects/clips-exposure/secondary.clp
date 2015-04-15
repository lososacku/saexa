; Copyright 2015 Ryan B. Hicks


(defrule SECONDARY::found-intrascope-aggregated-first-and-last-name-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title first-name-exposure)
    (post-uuids     $?first-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title last-name-exposure)
    (post-uuids     $?last-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?first-name-service-name)
   (uuid            ?first-name-post-uuid&=(nth$ 1 ?first-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?first-name-service-name)
   (uuid            ?last-name-post-uuid&=(nth$ 1 ?last-name-post-uuids)))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title intrascope-aggregated-first-and-last-name-exposure)
    (post-uuids     $?post-uuids&:(member$ ?first-name-post-uuid $?post-uuids)
                                &:(member$ ?last-name-post-uuid  $?post-uuids))))
  =>
  (printout t crlf "SECONDARY::found-intrascope-aggregated-first-and-last-name-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title intrascope-aggregated-first-and-last-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?first-name-post-uuid ?last-name-post-uuid))))

(defrule SECONDARY::found-interscope-aggregated-first-and-last-name-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title first-name-exposure)
    (post-uuids     $?first-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title last-name-exposure)
    (post-uuids     $?last-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?first-name-service-name)
   (uuid            ?first-name-post-uuid&=(nth$ 1 ?first-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?last-name-service-name&~?first-name-service-name)
   (uuid            ?last-name-post-uuid&=(nth$ 1 ?last-name-post-uuids)))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope    ?origin-scope)
   (linked-scope    ?linked-scope))
  (test (or
         (and (eq ?origin-scope ?first-name-service-name)
              (eq ?linked-scope ?last-name-service-name))
         (and (eq ?origin-scope ?last-name-service-name)
              (eq ?linked-scope ?first-name-service-name))))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title interscope-aggregated-first-and-last-name-exposure)
    (post-uuids     $?post-uuids&:(member$ ?first-name-post-uuid $?post-uuids)
                                &:(member$ ?last-name-post-uuid  $?post-uuids))))

  =>
  (printout t crlf "SECONDARY::found-interscope-aggregated-first-and-last-name-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title interscope-aggregated-first-and-last-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?first-name-post-uuid ?last-name-post-uuid))))

(defrule SECONDARY::found-potential-interscope-aggregated-first-and-last-name-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title first-name-exposure)
    (post-uuids     $?first-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title last-name-exposure)
    (post-uuids     $?last-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?first-name-service-name)
   (uuid            ?first-name-post-uuid&=(nth$ 1 ?first-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?last-name-service-name&~?first-name-service-name)
   (uuid            ?last-name-post-uuid&=(nth$ 1 ?last-name-post-uuids)))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope    ?origin-scope)
   (linked-scope    ?linked-scope))
  (test (not
         (or
          (and (eq ?origin-scope ?first-name-service-name)
               (eq ?linked-scope ?last-name-service-name))
          (and (eq ?origin-scope ?last-name-service-name)
               (eq ?linked-scope ?first-name-service-name)))))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title potential-interscope-aggregated-first-and-last-name-exposure)
    (post-uuids     $?post-uuids&:(member$ ?first-name-post-uuid $?post-uuids)
                                &:(member$ ?last-name-post-uuid  $?post-uuids))))
  =>
  (printout t crlf "SECONDARY::found-potential-interscope-aggregated-first-and-last-name-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title potential-interscope-aggregated-first-and-last-name-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?first-name-post-uuid ?last-name-post-uuid))))

(defrule SECONDARY::found-intrascope-aggregated-high-school-and-hometown-names-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title high-school-name-exposure)
    (post-uuids     $?high-school-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title hometown-name-exposure)
    (post-uuids     $?hometown-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?high-school-name-service-name)
   (uuid            ?high-school-name-post-uuid&=(nth$ 1 ?high-school-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?high-school-name-service-name)
   (uuid            ?hometown-name-post-uuid&=(nth$ 1 ?hometown-name-post-uuids)))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title intrascope-aggregated-high-school-and-hometown-names-exposure)
    (post-uuids     $?post-uuids&:(member$ ?high-school-name-post-uuid $?post-uuids)
                                &:(member$ ?hometown-name-post-uuid    $?post-uuids))))
  =>
  (printout t crlf "SECONDARY::found-intrascope-aggregated-high-school-and-hometown-names-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title intrascope-aggregated-high-school-and-hometown-names-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?high-school-name-post-uuid ?hometown-name-post-uuid))))

(defrule SECONDARY::found-interscope-aggregated-high-school-and-hometown-names-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title high-school-name-exposure)
    (post-uuids     $?high-school-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title hometown-name-exposure)
    (post-uuids     $?hometown-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?high-school-name-service-name)
   (uuid            ?high-school-name-post-uuid&=(nth$ 1 ?high-school-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?hometown-name-service-name&~?high-school-name-service-name)
   (uuid            ?hometown-name-post-uuid&=(nth$ 1 ?hometown-name-post-uuids)))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope    ?origin-scope)
   (linked-scope    ?linked-scope))
  (test (or
         (and (eq ?origin-scope ?high-school-name-service-name)
              (eq ?linked-scope ?hometown-name-service-name))
         (and (eq ?origin-scope ?hometown-name-service-name)
              (eq ?linked-scope ?high-school-name-service-name))))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title interscope-aggregated-high-school-and-hometown-names-exposure)
    (post-uuids     $?post-uuids&:(member$ ?high-school-name-post-uuid $?post-uuids)
                                &:(member$ ?hometown-name-post-uuid    $?post-uuids))))

  =>
  (printout t crlf "SECONDARY::found-interscope-aggregated-high-school-and-hometown-names-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title interscope-aggregated-high-school-and-hometown-names-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?high-school-name-post-uuid ?hometown-name-post-uuid))))

(defrule SECONDARY::found-potential-interscope-aggregated-high-school-and-hometown-names-exposure
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title high-school-name-exposure)
    (post-uuids     $?high-school-name-post-uuids))
  (object
   (is-a EXPOSURE-INCIDENT)
    (incident-title hometown-name-exposure)
    (post-uuids     $?hometown-name-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?high-school-name-service-name)
   (uuid            ?high-school-name-post-uuid&=(nth$ 1 ?high-school-name-post-uuids)))
  (object
   (is-a POSTED-DATA-ITEM)
   (service-name    ?hometown-name-service-name&~?high-school-name-service-name)
   (uuid            ?hometown-name-post-uuid&=(nth$ 1 ?hometown-name-post-uuids)))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope    ?origin-scope)
   (linked-scope    ?linked-scope))
  (test (not
         (or
          (and (eq ?origin-scope ?high-school-name-service-name)
               (eq ?linked-scope ?hometown-name-service-name))
          (and (eq ?origin-scope ?hometown-name-service-name)
               (eq ?linked-scope ?high-school-name-service-name)))))
  (not
   (object
    (is-a EXPOSURE-INCIDENT)
    (incident-title potential-interscope-aggregated-high-school-and-hometown-names-exposure)
    (post-uuids     $?post-uuids&:(member$ ?high-school-name-post-uuid $?post-uuids)
                                &:(member$ ?hometown-name-post-uuid    $?post-uuids))))
  =>
  (printout t crlf "SECONDARY::found-potential-interscope-aggregated-high-school-and-hometown-names-exposure" crlf)
  (make-instance of EXPOSURE-INCIDENT
    (uuid           ready-for-uuid)
    (incident-title potential-interscope-aggregated-high-school-and-hometown-names-exposure)
    (incident-type  who)
    (post-uuids     (create$ ?high-school-name-post-uuid ?hometown-name-post-uuid))))

(defrule SECONDARY::found-scope-with-high-identity-resolution
  (object
   (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION)
   (scope        ?scope)
   (resolution   ?resolution&:(> ?resolution 0.3)))
  (object
   (is-a EXPOSURE-SCOPE)
   (service-name ?scope)
   (pdi-uuid     ?pdi-uuid))
  =>
  ; (printout t
  ;           crlf
  ;           "}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}" crlf
  ;           "scope      -> " ?scope crlf
  ;           "resolution -> " ?resolution crlf
  ;           "pdi-uuid   -> " ?pdi-uuid crlf
  ;           crlf
  ;           crlf)
  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scope-with-high-identity-resolution)
                    (incident-type  who)
                    (post-uuids     (create$ ?pdi-uuid)))
  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scope-with-high-identity-resolution)
                    (incident-type  what)
                    (post-uuids     (create$ ?pdi-uuid)))
  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scope-with-high-identity-resolution)
                    (incident-type  where)
                    (post-uuids     (create$ ?pdi-uuid))))

(defrule SECONDARY::found-scopes-with-similar-identity-resolution
  (object
   (is-a EXPOSURE-SCOPE-IDENTITY-RESOLUTION-DELTA)
   (scope-0      ?scope-0)
   (scope-1      ?scope-1)
   (delta        ?delta&:(< ?delta 0.83)))
  (object
   (is-a EXPOSURE-SCOPE)
   (service-name ?scope-0)
   (pdi-uuid     ?pdi-uuid-0))
  (object
   (is-a EXPOSURE-SCOPE)
   (service-name ?scope-1)
   (pdi-uuid     ?pdi-uuid-1))
  =>
  ; (printout t
  ;           crlf
  ;           "{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{" crlf
  ;           "scope-0 -> " ?scope-0 crlf
  ;           "scope-1 -> " ?scope-1 crlf
  ;           "delta   -> " ?delta crlf
  ;           crlf
  ;           crlf)

  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scopes-with-similar-identity-resolution)
                    (incident-type  who)
                    (post-uuids     (create$ ?pdi-uuid-0 ?pdi-uuid-1)))
  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scopes-with-similar-identity-resolution)
                    (incident-type  what)
                    (post-uuids     (create$ ?pdi-uuid-0 ?pdi-uuid-1)))
  (make-instance of EXPOSURE-INCIDENT
                    (uuid           ready-for-uuid)
                    (incident-title scopes-with-similar-identity-resolution)
                    (incident-type  where)
                    (post-uuids     (create$ ?pdi-uuid-0 ?pdi-uuid-1))))





