;; Copyright 2015 Ryan B. Hicks

#lang racket

(require web-server/servlet
         web-server/servlet-env
         xml
         net/uri-codec
         net/base64
         db/mongodb)


(require (planet williams/uuid:1:3/uuid))

(require "aws.rkt")

(define server-namespace (make-base-namespace))

(define (saexa-servlet request)
  (saexa-dispatch request))

(define (get-exposure-incident-uuid exposure-incident)
  (caadr exposure-incident))

(define (get-exposure-incident-title exposure-incident)
  (cadadr exposure-incident))

(define (get-exposure-incident-type exposure-incident)
  (car (cdr (cdr (car (cdr exposure-incident))))))

(define (get-exposure-incident-posted-data-items exposure-incident)
  (if (empty? (cdr (cdr (cdr (car (cdr exposure-incident))))))
      '()
      (car (cdr (cdr (cdr (car (cdr exposure-incident))))))))

(define (get-posted-data-item-service-name posted-data-item)
  (caadr posted-data-item))

(define (get-posted-data-item-link posted-data-item)
  (cadadr posted-data-item))

(define (get-posted-data-item-raw-post posted-data-item)
  (car (cddadr posted-data-item)))

(define (get-exposure-values-who-value exposure-values)
  (caadr exposure-values))

(define (get-exposure-values-what-value exposure-values)
  (cadadr exposure-values))

(define (get-exposure-values-where-value exposure-values)
  (car (cdr (cdr (car (cdr exposure-values))))))

(define (get-exposure-values-synthesized-exposure-value exposure-values)
  (car (cdr (cdr (cdr (car (cdr exposure-values)))))))

(define (process-exposure-report-lines exposure-report-string-port exposure-analysis-uuid-string)
  (let ([exposure-report-line (read-line exposure-report-string-port)])
      ;; (display "exposure-incident-line >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
      ;; (newline)
      ;; (display exposure-incident-line)
      ;; (newline)
      ;; (display "+++++++++++++++++++++++++++++++++++++++++++++++++++++")
      ;; (newline)
      (if (eof-object? exposure-report-line)
          (void)
          (with-input-from-string exposure-report-line
            (lambda ()
              (let* ([exposure-report-line-read (read/recursive)]
                     [exposure-report-line-data (eval exposure-report-line-read server-namespace)])
                (if (eq? "exposure-incident" (car exposure-report-line-data))
                    (begin 
                      (make-exposure-incident #:exposure_analysis_uuid            exposure-analysis-uuid-string
                                              #:uuid                              (get-exposure-incident-uuid exposure-report-line-data)
                                              #:title                             (get-exposure-incident-title exposure-report-line-data)
                                              #:type                              (get-exposure-incident-type exposure-report-line-data))
                      ;; (display (get-exposure-incident-posted-data-items exposure-report-line-data))
                      ;; (newline)
                      (for-each (lambda (posted-data-item)
                                  (make-posted-data-item #:exposure_analysis_uuid exposure-analysis-uuid-string
                                                         #:exposure_incident_uuid (get-exposure-incident-uuid exposure-report-line-data)
                                                         #:service_name           (get-posted-data-item-service-name posted-data-item)
                                                         #:link                   (get-posted-data-item-link posted-data-item)
                                                         #:raw_post               (get-posted-data-item-raw-post posted-data-item)))
                                (get-exposure-incident-posted-data-items exposure-report-line-data)))
                    (begin
                      (make-exposure-analysis-numerical-result #:exposure_analysis_uuid            exposure-analysis-uuid-string
                                                               #:exposure_who_value                (get-exposure-values-who-value                  exposure-report-line-data)
                                                               #:exposure_what_value               (get-exposure-values-what-value                 exposure-report-line-data)
                                                               #:exposure_where_value              (get-exposure-values-where-value                exposure-report-line-data)
                                                               #:synthesized_exposure_status_value (get-exposure-values-synthesized-exposure-value exposure-report-line-data))))
                (process-exposure-report-lines exposure-report-string-port exposure-analysis-uuid-string)))))))

(define (extract-actions results-string-port)
  (let ([result-line (read-line results-string-port)])
    ;; (display "result-line----------------------------------------->")
    ;; (newline)
    ;; (display result-line)
    ;; (newline)
    ;; (display "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
    ;; (newline)
    (if (eof-object? result-line)
        '()
        (with-input-from-string result-line
          (lambda ()
            (cons (eval (read) server-namespace)
                  (extract-actions results-string-port)))))))

(define (group-actions action-type extracted-actions)
  (foldl
   (lambda (action grouped-actions)
     (if (equal? action-type (car action))
         (string-append grouped-actions (cdr action) "\n")
         grouped-actions))
   ""
   extracted-actions))

(define (process-service-details service-details)
  (newline)
  (display "process-service-details")
  (newline)
  ;; (display service-details)
  ;; (newline)
  (with-input-from-string service-details
    (lambda ()
      (letrec ([process-line (lambda ()
                                    (let ([service-details-line (read-line)])
                                      (if (eof-object? service-details-line)
                                          (void)
                                          (begin
                                            (with-input-from-string service-details-line
                                              (lambda ()
                                                (let* ([service-details-line-read (read/recursive)]
                                                       [service-details-line-data (eval service-details-line-read server-namespace)])
                                                  (for-each (lambda (service-detail-item)
                                                              (if (not (empty? (cdr service-detail-item)))
                                                                  (begin
                                                                    (make-exposure-analysis-service-detail
                                                                     #:service_name           (car service-details-line-data)
                                                                     #:exposure_analysis_uuid (cadr service-details-line-data)
                                                                     #:key                    (car service-detail-item)
                                                                     #:value                  (car (cdr service-detail-item)))
                                                                    (if (name-item? (car service-details-line-data)
                                                                                    (car service-detail-item))
                                                                        (add-unique-name-item (cadr service-details-line-data)
                                                                                              (car service-details-line-data)
                                                                                              (car service-detail-item)
                                                                                              (car (cdr service-detail-item)))
                                                                        (add-unique-personal-interest-item (cadr service-details-line-data)
                                                                                                           (car service-details-line-data)
                                                                                                           (car service-detail-item)
                                                                                                           (car (cdr service-detail-item)))))
                                                                  (void)))
                                                            (cddr service-details-line-data))
                                                  (newline))))
                                            
                                            (process-line)))))])
        (process-line)))))

(define (name-item? service-name key)
  (or
    (and (eq? "facebook"  service-name) (eq? "name-string"  key))
    (and (eq? "facebook"  service-name) (eq? "first-name"   key))
    (and (eq? "facebook"  service-name) (eq? "middle-name"  key))
    (and (eq? "facebook"  service-name) (eq? "last-name"    key))
    (and (eq? "instagram" service-name) (eq? "user-name"    key))
    (and (eq? "youtube"   service-name) (eq? "channel-name" key))
    (and (eq? "tumblr"    service-name) (eq? "blog-name"    key))
    (and (eq? "twitter"   service-name) (eq? "account-name" key))))

(define (add-unique-name-item analysis-uuid service-name key value)
  (let ([name-item (list analysis-uuid service-name key value)])
    (cond [(not (member name-item *names*))
           (begin
             (cons name-item *names*)
             (make-exposure-analysis-name
              #:service_name           service-name
              #:exposure_analysis_uuid analysis-uuid
              #:key                    key
              #:value                  value))])))

(define (add-unique-personal-interest-item analysis-uuid service-name key value)
  (let ([personal-interest-item (list analysis-uuid service-name key value)])
    (cond [(not (member personal-interest-item *personal-interests*))
           (begin
             (cons personal-interest-item *personal-interests*)
             (make-exposure-analysis-personal-interest
              #:service_name           service-name
              #:exposure_analysis_uuid analysis-uuid
              #:key                    key
              #:value                  value))])))

(define (purge exposure-analysis-uuid-string)
    (set! *names*
          (filter (lambda (l)
                    (if (equal? (car l)
                                exposure-analysis-uuid-string)
                        #f
                        l))
                  *names*))
    (set! *personal-interests*
          (filter (lambda (l)
                    (if (equal? (car l)
                                exposure-analysis-uuid-string)
                        #f
                        l))
                  *personal-interests*)))

(define-values (saexa-dispatch req)
  (dispatch-rules

   (("put-post-processing-lines-for-exposure-analysis"  (string-arg)) #:method "post" put-post-processing-lines-for-exposure-analysis-handler)
   (("put-service-details-lines"                        (string-arg)) #:method "post" put-service-details-lines-handler)
   (("get-post-processing-lines")                                                     get-post-processing-lines-handler)
   (("put-nlp-results"                                  (string-arg)) #:method "post" put-nlp-results-handler)
   (("get-nlp-results")                                                               get-nlp-results-handler)
   (("put-exposure-results"                             (string-arg)) #:method "post" put-exposure-results-handler)
   (("get-exposure-results"                             (string-arg)) #:method "post" get-exposure-results-handler)
   (("get-uuid")                                                                      get-uuid-handler)
   (("extract-prolog-actions")                                        #:method "post" extract-prolog-actions-handler)
   (("extract-clips-actions")                                         #:method "post" extract-clips-actions-handler)
   (("purge"                                            (string-arg)) #:method "post" purge-handler)
   (else interface-error)
   
   ))

(define (put-post-processing-lines-for-exposure-analysis-handler request exposure-analysis-uuid-string)
    (print "put-post-processing-lines-for-exposure-analysis-handler called")
    (newline)
    ;; (display (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))
    ;; (newline)
    ;; (display exposure-analysis-uuid-string)
    ;; (newline)
    (let retry ([count 0])
      (when
        (and (< count 10)
             (not (put-post-processing-lines-for-exposure-analysis
                   exposure-analysis-uuid-string
                   (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))))
        (begin
          (sleep 2)
          (retry (+ 1 count)))))
    (response/output
     (lambda (output)
       (write-string
        (format "{exposure_analysis_uuid_string : \"~a\"}"
                exposure-analysis-uuid-string)
        output)
       (void))))

(define (put-service-details-lines-handler request exposure-analysis-uuid-string)
  (print "put-service-details-lines-handler")
  (newline)
  ;; (display (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))
  ;; (newline)
  (let retry ([count 0])
      (when
          (and (< count 10)
               (not (process-service-details (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))))
        (begin
          (sleep)
          (retry (+ 1 count)))))
  (response/output
   (lambda (output)
     (write-string
      (format "{exposure_analysis_uuid_string : \"~a\"}"
              exposure-analysis-uuid-string)
      output)
     (void))))

(define (get-post-processing-lines-handler request)
    (print "get-post-processing-lines called")
    (newline)
    (let ([post-processing-lines-data (get-post-processing-lines)])
      (if post-processing-lines-data
          (response/output
           (lambda (output)
             (write-string
              (format "{status: \"process\", post-processing-lines-name : \"~a\", post-processing-lines : \"~a\"}"
                      (car post-processing-lines-data)
                      (cdr post-processing-lines-data))
              output)
             (void)))
          (response/output
           (lambda (output)
             (write-string
              "{status: \"wait\"}"
              output)
             (void))))))

(define (put-nlp-results-handler request exposure-analysis-uuid-string)
    (print "put-nlp-results called")
    (newline)
    ;; (print (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))
    ;; (newline)
    (let retry ([count 0])
      (when
          (and (< count 10)
               (not (put-nlp-results exposure-analysis-uuid-string
                                     (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))))
        (begin
          (sleep 2)
          (retry (+ 1 count)))))
    (response/output
     (lambda (output)
       (write-string
        "{}"
        output)
       (void))))

(define (get-nlp-results-handler request)
    (print "get-nlp-results called")
    (newline)
    (let ([nlp-results-data (get-nlp-results)])
      (if nlp-results-data
          (response/output
           (lambda (output)
             (write-string
              (bytes->string/utf-8 
               (base64-encode (string->bytes/utf-8 
                               (format "{status: \"process\", nlp-results-data-name : \"~a\", nlp-results-data-lines : \"~a\"}"
                                       (car nlp-results-data)
                                       (cdr nlp-results-data)))
                              #""))
              output)
             (void)))
          (response/output
           (lambda (output)
             (write-string
              "{status: \"wait\"}"
              output)
             (void))))))

(define (put-exposure-results-handler request exposure-analysis-uuid-string)
    (display "put-exposure-results called")
    (newline)
    ;; (display exposure-analysis-uuid-string)
    ;; (newline)
    ;; (display (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))
    ;; (newline)
    (let* ([string-data (bytes->string/utf-8 (base64-decode (request-post-data/raw request)))]
           [string-port (open-input-string string-data)])
      (let retry ([count 0])
        (when
            (and (< count 10)
                 (not (process-exposure-report-lines string-port exposure-analysis-uuid-string)))
          (begin
            (sleep 2)
            (retry (+ 1 count)))))
      (close-input-port string-port))
    (purge exposure-analysis-uuid-string)
    (response/output
     (lambda (output)
       (write-string
        "{}"
        output)
       (void))))

(define (get-exposure-results-handler request exposure-analysis-uuid-string)
    (print "put-exposure-results called")
    (newline)
    ;; (print exposure-analysis-uuid-string)
    ;; (newline)
    ;; (print (bytes->string/utf-8 (base64-decode (request-post-data/raw request))))
    ;; (newline)
    (let retry ([count            0]
                [exposure-results (get-exposure-results exposure-analysis-uuid-string)])
      (when (and (< count 10)
                 (not exposure-results))
            (begin
              (sleep 2)
              (retry (+ 1 count) exposure-results)))
    (response/output
     (lambda (output)
       (write-string
        exposure-results
        output)
       (void)))))

(define (get-uuid-handler req)
  (print "get-uuid called")
  (newline)
  (response/output
   (lambda (output)
     (write-string
      (uuid->string (make-uuid-4))
      output)
     (void))))

(define (extract-prolog-actions-handler request)
    (print "extract-prolog-actions called")
    (newline)
    ;; (display (request-post-data/raw request))
    ;; (newline)
    ;; (display (uri-decode (bytes->string/utf-8 (request-post-data/raw request))))
    ;; (newline)
    (response/output
     (lambda (output)
       (write-string
        (let* ([post-data-string-port    (open-input-string (unescape-prolog-quotes (uri-decode (bytes->string/utf-8 (request-post-data/raw request)))))]
               [extracted-prolog-actions (group-actions 'prolog (extract-actions post-data-string-port))])
          (close-input-port post-data-string-port)
          extracted-prolog-actions)
        output)
       (void))))

(define (extract-clips-actions-handler request)
    (print "extract-clips-actions called")
    (newline)
    ;; (display (unescape-clips-quotes (uri-decode (bytes->string/utf-8 (request-post-data/raw request)))))
    ;; (newline)
    (response/output
     (lambda (output)
       (write-string
        (let* ([post-data-string-port   (open-input-string (unescape-clips-quotes (uri-decode (bytes->string/utf-8 (request-post-data/raw request)))))]
               [extracted-clips-actions (group-actions 'clips (extract-actions post-data-string-port))])
          
          (newline)
          (display extracted-clips-actions)
          (newline)
          
          (close-input-port post-data-string-port)
          extracted-clips-actions)
        output)
       (void))))

(define (purge-handler request exposure-analysis-uuid-string)
    (print "purge called")
    (newline)
    (purge exposure-analysis-uuid-string)
    (response/output
     (lambda (output)
       (write-string
        "{}"
        output)
       (void))))

(define (unescape-clips-quotes lines)
  (string-replace (string-replace lines ">{OQ}<" "\"" #:all? #t) ">{IQ}<" "\\\"" #:all? #t))

(define (unescape-prolog-quotes lines)
  (string-replace (string-replace lines ">{OQ}<" "\"" #:all? #t) ">{IQ}<" "\\\"" #:all? #t))

(define (interface-error request)
  (print "unknown interface called")
  (newline)
  (display request)
  (newline)
  (display (url->string (request-uri request)))
  (newline)
  (response/output
   (lambda (output)
     (write-string
      (format "unknown interface called~n")
      output)
     (void))))

;; @#$%@$#%@#$%@#$%@#$%@$#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@$#%
(define *mongo* (create-mongo))
(define *db*    (make-mongo-db *mongo* "meteor"))
(define *names* '())
(define *personal-interests* '())

(current-mongo-db *db*)
(define-mongo-struct exposure-incident
                     "exposure_incidents"
                     ([exposure_analysis_uuid #:required]
                      [uuid                   #:required]
                      [title                  #:required]
                      [type                   #:required]))
(define-mongo-struct posted-data-item
                     "posted_data_items"
                     ([exposure_analysis_uuid #:required]
                      [exposure_incident_uuid #:required]
                      [service_name           #:required]
                      [link                   #:required]
                      [raw_post               #:required]))
(define-mongo-struct exposure-analysis-numerical-result
                     "exposure_analysis_numerical_results"
                     ([exposure_analysis_uuid            #:required]
                      [exposure_who_value                #:required]
                      [exposure_what_value               #:required]
                      [exposure_where_value              #:required]
                      [synthesized_exposure_status_value #:required]))
(define-mongo-struct exposure-analysis-service-detail
                     "exposure_analysis_service_details"
                     ([service_name           #:required]
                      [exposure_analysis_uuid #:required]
                      [key                    #:required]
                      [value                  #:required]))
(define-mongo-struct exposure-analysis-name
                     "exposure_analysis_names"
                     ([exposure_analysis_uuid #:required]
                      [service_name           #:required]
                      [key                    #:required]
                      [value                  #:required]))
(define-mongo-struct exposure-analysis-personal-interest
                     "exposure_analysis_personal_interests"
                     ([exposure_analysis_uuid #:required]
                      [service_name           #:required]
                      [key                    #:required]
                      [value                  #:required]))
  

(serve/servlet saexa-servlet
               #:stateless?      #t
               #:launch-browser? #f
               #:port            53535
               #:servlet-regexp  #rx"")
;; @#$%@$#%@#$%@#$%@#$%@$#%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@#$%@$#%



; %^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&
; %^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&
; %^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&$%^&

(define (moskit)
  (set! *zorg* (get-exposure-results))
  (display *zorg*)
  (newline))

(define (grom)
  (set! *oop* (get-exposure-results))
  (let* (;[results-string       (cdr (get-exposure-results))]
         ;[results-string       "'(exposure-incident (\"119022c9-8d96-4106-9273-338ecba0277f\" \"last-name-exposure\" \"who\" \"0.87\" \"0.79\" \"0.65\" \"0.91\" (posted-data-item (\"https://twitter.com/kaitiejsomersby/status/336381540357525504\" \"trying to find out what my last name means. it-----singlequote-----s in a baby book but somersby is not a boys first name ;-P\"))))"]
         [results-string       (cdr *oop*)]
         [results-string-port  (open-input-string results-string)])
    (display results-string)
    (newline)
    (display "VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV")
    (newline)
    (newline)
    (newline)
    (newline)
;      (igla results-string-port)
    (jehlice results-string-port)
    (close-input-port results-string-port)))

(define (igla results-string-port)
  (let ([read-results (read/recursive results-string-port)])
    (when (not (eof-object? read-results))
      (display "|||||||||||||||||||||||||||||")
      (newline)
      (display read-results)
      (newline)
      (display "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
      (newline)
      (display (car (eval read-results server-namespace)))
      (newline)
      (display "WWWWWWWWWWWWWWWWWWWWWWWWWWWWW")
      (newline)
      (igla results-string-port))))


(define *oop* "")
(define *zorg* "")
(define *ack* "")


(define (jehlice)
  (let* ([string-data "'(exposure-incident (\"119022c9-8d96-4106-9273-338ecba0277f\" \"last-name-exposure\" \"who\" \"0.87\" \"0.79\" \"0.65\" \"0.91\" (posted-data-item (\"https://twitter.com/kaitiejsomersby/status/336381540357525504\" \"trying to find out what my last name means. it-----singlequote-----s in a baby book but somersby is not a boys first name ;-P\"))))"]
         [string-port (open-input-string string-data)]
         [read-data   (read/recursive string-port)]
         [data        (eval read-data server-namespace)])
    ;;                  (car  data)
    ;;                  (cadr data)))
    (newline)
    (newline)
    (newline)
    (display data)
    (newline)
    (newline)
    (newline)
    (set! *ack* data)
;    (display (cdr data))
;    (display (first (first (cdr data))))
    (newline)
    (close-input-port string-port)))


;; sudo ROOT_URL=http://ec2-54-148-135-191.us-west-2.compute.amazonaws.com MONGO_URL=mongodb://localhost:27017/meteor NODE_ENV=production /usr/local/bin/meteor --port 80
