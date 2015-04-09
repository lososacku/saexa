
(defrule SCOPE-DISCOVERABILITY::found-2-discoverable-scope
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope ?origin-scope)
   (linked-scope ?linked-scope-0))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope ?linked-scope-0)
   (linked-scope ?linked-scope-1&~?origin-scope))
  (not
   (object
    (is-a EXPOSURE-SCOPE-LINKAGE)
    (origin-scope ?origin-scope)
    (linked-scope ?linked-scope-1)))
  (not
   (object
    (is-a EXPOSURE-SCOPE-DISCOVERABILITY)
    (origin-scope     ?origin-scope)
    (discovered-scope ?linked-scope-1)))
  =>
  (printout t crlf
              "origin-scope -> " ?origin-scope   crlf
              "linked-scope -> " ?linked-scope-1 crlf
              crlf)
  (make-instance of EXPOSURE-SCOPE-DISCOVERABILITY
                    (origin-scope     ?origin-scope)
                    (discovered-scope ?linked-scope-1)
                    (distance         2)))

(defrule SCOPE-DISCOVERABILITY::found-3-discoverable-scope
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope ?origin-scope)
   (linked-scope ?linked-scope-0))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope ?linked-scope-0)
   (linked-scope ?linked-scope-1&~?origin-scope))
  (object
   (is-a EXPOSURE-SCOPE-LINKAGE)
   (origin-scope ?linked-scope-1)
   (linked-scope ?linked-scope-2&~?origin-scope&~?linked-scope-1))
  (not
   (object
    (is-a EXPOSURE-SCOPE-LINKAGE)
    (origin-scope ?origin-scope)
    (linked-scope ?linked-scope-2)))
  (not
   (object
    (is-a EXPOSURE-SCOPE-DISCOVERABILITY)
    (origin-scope     ?origin-scope)
    (discovered-scope ?linked-scope-2)))
  =>
  (printout t crlf
              "origin-scope -> " ?origin-scope   crlf
              "linked-scope -> " ?linked-scope-2 crlf
              crlf)
  (make-instance of EXPOSURE-SCOPE-DISCOVERABILITY
                    (origin-scope     ?origin-scope)
                    (discovered-scope ?linked-scope-2)
                    (distance         3)))


(defrule SCOPE-DISCOVERABILITY::create-exposure-discoverability
  (exists
   (object
    (is-a EXPOSURE-SCOPE-DISCOVERABILITY)))
  =>
  (bind ?distance-upper-limit 3)
  (bind ?scope-count
        (length$ (find-all-instances ((?exposure-scope EXPOSURE-SCOPE))
                                     TRUE)))
  (bind ?running-total 0)


  (do-for-all-instances ((?exposure-scope-discoverability EXPOSURE-SCOPE-DISCOVERABILITY))
                        TRUE
                        (bind ?running-total
                              (+ ?running-total
                                 (send ?exposure-scope-discoverability get-distance))))

  (printout t
            crlf
            "**************************************"
            crlf
            "?running-total -> " ?running-total
            crlf
            "?scope-count   -> " ?scope-count
            crlf)

  (make-instance of
                 EXPOSURE-DISCOVERABILITY
                 (discoverability (/ (/ ?running-total
                                        ?scope-count)
                                     ?distance-upper-limit))))