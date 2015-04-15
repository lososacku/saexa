; Copyright 2015 Ryan B. Hicks


; depth:   simply     <connectedness>, only uni-directional
;          strongly   <connectedness>, at least one bi-directional
;          completely <connectedness>  all bi-directional
;
; breadth: connected,                  1 scope
;          interconnected              more than one scope, less than all scopes
;          hyperconnected              all scopes

; service-name-exposure-linkage
; reused-login-name-linkage
; facebook-email-address-exposure-linkage
; user-name-exposure-linkage
; youtube-video-exposure-linkage



(deffunction SCOPE-ASSOCIATION::get-unique-linked-scopes (?origin-scope)
  (bind $?all-linked-scopes (create$))
  (do-for-all-instances ((?exposure-scope-linkage EXPOSURE-SCOPE-LINKAGE))
                        (eq ?origin-scope
                            (send ?exposure-scope-linkage get-origin-scope))
                        (if (not
                             (member$ (send ?exposure-scope-linkage get-linked-scope)
                                      $?all-linked-scopes))
                            then
                            (bind $?all-linked-scopes
                                  (create$ $?all-linked-scopes
                                           (send ?exposure-scope-linkage get-linked-scope)))))
  $?all-linked-scopes)

(deffunction SCOPE-ASSOCIATION::scope-is-connected (?origin-scope)
  (= 1 (length$ (get-unique-linked-scopes ?origin-scope))))

(deffunction SCOPE-ASSOCIATION::scope-is-interconnected (?origin-scope)
  (bind ?unique-linked-scopes-count (length$ (get-unique-linked-scopes ?origin-scope)))
  (bind ?exposure-scopes-count      (length$ (find-all-instances ((?exposure-scope EXPOSURE-SCOPE))
                                                                 TRUE)))
  (and
   (< 1                           ?unique-linked-scopes-count)
   (< ?unique-linked-scopes-count (- ?exposure-scopes-count 1))))

(deffunction SCOPE-ASSOCIATION::scope-is-hyperconnected (?origin-scope)
  (bind ?unique-linked-scopes-count (length$ (get-unique-linked-scopes ?origin-scope)))
  (bind ?exposure-scopes-count      (length$ (find-all-instances ((?exposure-scope EXPOSURE-SCOPE))
                                                                 TRUE)))
  (= ?unique-linked-scopes-count (- ?exposure-scopes-count 1)))

(deffunction SCOPE-ASSOCIATION::get-unique-linkage-directions (?origin-scope)
  (bind $?all-linkage-directions (create$))
  (do-for-all-instances ((?exposure-scope-linkage EXPOSURE-SCOPE-LINKAGE))
                        (eq ?origin-scope
                            (send ?exposure-scope-linkage get-origin-scope))
                        (if (not
                             (member$ (send ?exposure-scope-linkage get-linkage-direction)
                                      $?all-linkage-directions))
                            then
                            (bind $?all-linkage-directions
                                  (create$ $?all-linkage-directions
                                           (send ?exposure-scope-linkage get-linkage-direction)))))
  $?all-linkage-directions)

(deffunction SCOPE-ASSOCIATION::depth-is-simple (?origin-scope)
  (bind $?linkage-directions (get-unique-linkage-directions ?origin-scope))
  (and
   (= 1 (length$ $?linkage-directions))
   (eq uni-directional (nth$ 1 $?linkage-directions))))

(deffunction SCOPE-ASSOCIATION::depth-is-strong (?origin-scope)
  (= 2 (length$ (get-unique-linkage-directions ?origin-scope))))

(deffunction SCOPE-ASSOCIATION::depth-is-complete (?origin-scope)
  (bind $?linkage-directions (get-unique-linkage-directions ?origin-scope))
  (and
   (= 1 (length$ $?linkage-directions))
   (eq bi-directional (nth$ 1 $?linkage-directions))))

(defrule SCOPE-ASSOCIATION::process-youtube-video-exposure
  (declare (salience 9000))
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title other-service-youtube-video-exposure)
   (post-uuids     $?exposure-incidents-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 1 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-0))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 2 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-1))
  =>
  (make-instance of EXPOSURE-SCOPE-LINKAGE
                    (origin-scope      ?service-name-0)
                    (linked-scope      ?service-name-1)
                    (linkage-type      youtube-video-exposure-linkage)
                    (linkage-direction bi-directional)))

(defrule SCOPE-ASSOCIATION::process-user-name-exposure
  (declare (salience 9000))  
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title other-service-user-name-exposure)
   (post-uuids     $?exposure-incidents-post-uuids))
  (object
   (is-a NLP-CLASSIFICATION)
   (classification login-name-found|profile-user-id-found|profile-display-name-found)
   (target-uuid    ?target-uuid&=(nth$ 1 $?exposure-incidents-post-uuids))
   (taxonomy       ?service-name-0))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?target-uuid)
   (service-name   ?service-name-1))
  (not
   (object
    (is-a EXPOSURE-SCOPE-LINKAGE)
    (origin-scope      ?service-name-0)
    (linked-scope      ?service-name-1)
    (linkage-type      user-name-exposure-linkage)
    (linkage-direction uni-directional)))
  =>
  (make-instance of EXPOSURE-SCOPE-LINKAGE
                    (origin-scope      ?service-name-0)
                    (linked-scope      ?service-name-1)
                    (linkage-type      user-name-exposure-linkage)
                    (linkage-direction uni-directional)))

(defrule SCOPE-ASSOCIATION::process-facebook-email-address-exposure
  (declare (salience 9000))
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title facebook-email-expsosure)
   (post-uuids     $?exposure-incidents-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 1 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-0))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 2 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-1))
  =>
  (make-instance of EXPOSURE-SCOPE-LINKAGE
                    (origin-scope      ?service-name-0)
                    (linked-scope      ?service-name-1)
                    (linkage-type      facebook-email-address-exposure-linkage)
                    (linkage-direction bi-directional)))

(defrule SCOPE-ASSOCIATION::found-accounts-linked-by-reused-login-name
  (declare (salience 9000))
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title reused-login-name)
   (post-uuids     $?exposure-incidents-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 1 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-0))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 2 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-1))
  =>
  (make-instance of EXPOSURE-SCOPE-LINKAGE
                    (origin-scope      ?service-name-0)
                    (linked-scope      ?service-name-1)
                    (linkage-type      reused-login-name-linkage)
                    (linkage-direction bi-directional)))

(defrule SCOPE-ASSOCIATION::process-service-name-exposure
  (declare (salience 9000))
  (object
   (is-a EXPOSURE-INCIDENT)
   (incident-title other-service-user-name-exposure)
   (post-uuids     $?exposure-incidents-post-uuids))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 1 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-0))
  (object
   (is-a POSTED-DATA-ITEM)
   (uuid           ?pdi-uuid&=(nth$ 2 $?exposure-incidents-post-uuids))
   (service-name   ?service-name-1))
  =>
  (make-instance of EXPOSURE-SCOPE-LINKAGE
                    (origin-scope      ?service-name-0)
                    (linked-scope      ?service-name-1)
                    (linkage-type      service-name-exposure-linkage)
                    (linkage-direction uni-directional)))

(defrule SCOPE-ASSOCIATION::found-simply-connected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope            ?origin-scope)
   (linked-scope            ?linked-scope)
   (linkage-direction       ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                  ?origin-scope)))
  (test (depth-is-simple    ?origin-scope))
  (test (scope-is-connected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   simple)
                    (breadth connected)))

(defrule SCOPE-ASSOCIATION::found-strongly-connected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope            ?origin-scope)
   (linked-scope            ?linked-scope)
   (linkage-direction       ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                  ?origin-scope)))
  (test (depth-is-strong    ?origin-scope))
  (test (scope-is-connected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   strong)
                    (breadth connected)))

(defrule SCOPE-ASSOCIATION::found-completely-connected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope            ?origin-scope)
   (linked-scope            ?linked-scope)
   (linkage-direction       ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                  ?origin-scope)))
  (test (depth-is-complete  ?origin-scope))
  (test (scope-is-connected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   complete)
                    (breadth connected)))

(defrule SCOPE-ASSOCIATION::found-simply-interconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-simple         ?origin-scope))
  (test (scope-is-interconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   simple)
                    (breadth interconnected)))

(defrule SCOPE-ASSOCIATION::found-strongly-interconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-strong         ?origin-scope))
  (test (scope-is-interconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   strong)
                    (breadth interconnected)))

(defrule SCOPE-ASSOCIATION::found-completely-interconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-complete       ?origin-scope))
  (test (scope-is-interconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   complete)
                    (breadth interconnected)))


(defrule SCOPE-ASSOCIATION::found-simply-hyperconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-complete       ?origin-scope))
  (test (scope-is-hyperconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   simple)
                    (breadth hyperconnected)))

(defrule SCOPE-ASSOCIATION::found-strongly-hyperconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-strong         ?origin-scope))
  (test (scope-is-hyperconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   strong)
                    (breadth hyperconnected)))

(defrule SCOPE-ASSOCIATION::found-completely-hyperconnected-scope
  (declare (salience 8000))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope                 ?origin-scope)
   (linked-scope                 ?linked-scope)
   (linkage-direction            ?linkage-direction))
  (not
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)
    (scope                       ?origin-scope)))
  (test (depth-is-complete       ?origin-scope))
  (test (scope-is-hyperconnected ?origin-scope))
  =>
  (make-instance of EXPOSURE-SCOPE-ASSOCIATION
                    (scope   ?origin-scope)
                    (depth   complete)
                    (breadth hyperconnected)))


(defrule SCOPE-ASSOCIATION::create-exposure-association
; ; found-simply-connected-scope          0.1
; ; found-strongly-connected-scope        0.15
; ; found-completely-connected-scope      0.2
; ; found-simply-interconnected-scope     0.6
; ; found-strongly-interconnected-scope   0.7
; ; found-completely-interconnected-scope 0.8
; ; found-simply-hyperconnected-scope     0.9
; ; found-strongly-hyperconnected-scope   0.95
; ; found-completely-hyperconnected-scope 1.0
  (exists
   (object
    (is-a EXPOSURE-SCOPE-ASSOCIATION)))
  =>
  (bind ?scope-count
        (length$ (find-all-instances ((?exposure-scope EXPOSURE-SCOPE))
                                     TRUE)))
  (bind ?running-total 0)


  (bind ?running-total (+ ?running-total
                          (* 0.1
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq simple    (send ?exposure-scope-association get-depth))
                                                       (eq connected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.15
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq strong    (send ?exposure-scope-association get-depth))
                                                       (eq connected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.2
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq complete  (send ?exposure-scope-association get-depth))
                                                       (eq connected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.6
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq simple  (send ?exposure-scope-association get-depth))
                                                       (eq interconnected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.7
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq strong  (send ?exposure-scope-association get-depth))
                                                       (eq interconnected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.8
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq complete (send ?exposure-scope-association get-depth))
                                                       (eq interconnected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.9
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq simple  (send ?exposure-scope-association get-depth))
                                                       (eq hyperconnected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 0.95
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq strong  (send ?exposure-scope-association get-depth))
                                                       (eq hyperconnected (send ?exposure-scope-association get-breadth))))))))
  (bind ?running-total (+ ?running-total
                          (* 1.0
                             (length$
                              (find-all-instances ((?exposure-scope-association EXPOSURE-SCOPE-ASSOCIATION))
                                                  (and (eq complete (send ?exposure-scope-association get-depth))
                                                       (eq hyperconnected (send ?exposure-scope-association get-breadth))))))))


  ; (printout t
  ;           crlf
  ;           "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  ;           crlf
  ;           "?running-total -> " ?running-total
  ;           crlf
  ;           "?scope-count   -> " ?scope-count
  ;           crlf)

  (if (not (= 0 ?scope-count))
    then
    (make-instance of EXPOSURE-ASSOCIATION (association (/ ?running-total ?scope-count)))))
                 
