(module aws racket
        (provide put-post-processing-lines-for-exposure-analysis)
        (provide get-post-processing-lines)
        (provide put-nlp-results)
        (provide get-nlp-results)
        (provide put-exposure-results)
        (provide get-exposure-results)
        (provide perform-aws-tests)

(require net/uri-codec)
(require net/base64)
(require racket/date)
(require net/url)
(require racket/port)
(require xml)
(require xml/path)

(require (planet gh/sha:1:1))

;=======================================================================================
;=======================================================================================
;; externally sourced

;; taken from:
;; db/private/mysql/connection.rkt:
(define (hex-string->bytes s)
  (define (hex-digit->int c)
    (let ([c (char->integer c)])
      (cond [(<= (char->integer #\0) c (char->integer #\9))
            (- c (char->integer #\0))]
            [(<= (char->integer #\a) c (char->integer #\f))
            (+ 10 (- c (char->integer #\a)))]
            [(<= (char->integer #\A) c (char->integer #\F))
            (+ 10 (- c (char->integer #\A)))])))
  (unless (and (string? s) (even? (string-length s))
               (regexp-match? #rx"[0-9a-zA-Z]*" s))
    (raise-type-error 'hex-string->bytes
                      "string containing an even number of hexadecimal digits" s))
  (let* ([c (quotient (string-length s) 2)]
            [b (make-bytes c)])
    (for ([i (in-range c)])
         (let ([high (hex-digit->int (string-ref s (+ i i)))]
                     [low  (hex-digit->int (string-ref s (+ i i 1)))])
           (bytes-set! b i (+ (arithmetic-shift high 4) low))))
    b))


;; taken from here:
;; http://lists.racket-lang.org/users/archive/2002-August/000365.html
(define (byte->fixed-string integer)
  (substring (number->string (+ integer 100)) 1 3))

;=======================================================================================
;=======================================================================================
;; internal functions

(define (access-key)        "AKIAINPG4U32H5JDUQWQ")
(define (secret-key)        "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")
(define (expires)           (let ([now (seconds->date (current-seconds) #f)])
                              (format "~a-~a-~aT~a:~a:~aZ"
                                      (date-year now)
                                      (byte->fixed-string (date-month  now))
                                      (byte->fixed-string (date-day    now))
                                      (byte->fixed-string (+ 1 (date-hour now)))
                                      (byte->fixed-string (date-minute now))
                                      (byte->fixed-string (date-second now)))))
(define (version)           "2012-11-05")
(define (account-number)    "321180246337")
(define (region)            "us-west-2")

;; (define (access-key) "AKIAIOSFODNN7EXAMPLE")
;; (define (secret-key) "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY")

(define (get-http-status-code response)
  (car (regexp-match* #px"HTTP/1.1[[:space:]]*([[:digit:]]{3})" response #:match-select cadr)))

(define (get-response-xml-xexpr response)
  (xml->xexpr
   (document-element
    (read-xml
     (open-input-string (car (regexp-match* #px"<?xml version=\"1.0\".*\\?>(.*)" response #:match-select cadr)))))))

(define (get-get-response-data response)
  (car (regexp-match* #px"[[:space:]]{4}(.*)" response #:match-select cadr)))

(define (date-stamp-and-x-amz-date-and-rfc2822)
  (date-display-format 'rfc2822)
  (let* ((current-seconds (current-seconds))
         (now             (seconds->date current-seconds #f))
         (raw-date-string (date->string now current-seconds))
         (rfc2822-string  (string-append (substring raw-date-string 0 (- (string-length raw-date-string) 5))
                                         "GMT")))
    (values
     (format "~a~a~a"         (date-year now)
                                          (byte->fixed-string (date-month now))
                                          (byte->fixed-string (date-day   now)))
     (format "~a~a~aT~a~a~aZ" (date-year now)
                                          (byte->fixed-string (date-month  now))
                                          (byte->fixed-string (date-day    now))
                                          (byte->fixed-string (date-hour   now))
                                          (byte->fixed-string (date-minute now))
                                          (byte->fixed-string (date-second now)))
     rfc2822-string)))

(define (get-delimited-parameter-string parameter-name/value-hash)
  (let ([delimited-parameter-string (foldl
                                     (lambda (key delimited-parameter-string)
                                       (string-append delimited-parameter-string
                                                      key
                                                      "="
                                                      (uri-encode (hash-ref parameter-name/value-hash key))
                                                      "&"))
                                     ""
                                     (sort
                                      (hash-keys parameter-name/value-hash)
                                      (lambda (x y)
                                        (string<? x y))))])
    (set! delimited-parameter-string
          (substring delimited-parameter-string 0 (- (string-length delimited-parameter-string) 1)))
    delimited-parameter-string))

(define (signed-header-string-and-header-names-pair header-name/value-hash)
  (let* ([hash-keys                      (hash-keys header-name/value-hash)]
         [canonical-header/values-string (foldl
                                          (lambda (key canonical-header/values-string)
                                            (string-append canonical-header/values-string
                                                           key
                                                           ":"
                                                           (hash-ref header-name/value-hash key)
                                                           "\n"))
                                          ""
                                          (sort
                                           hash-keys
                                           (lambda (x y)
                                             (string<? (string-downcase x) (string-downcase y)))))]
         [canonical-header-names-string  (foldl
                                          (lambda (key canonical-header/values-string)
                                            (string-append canonical-header/values-string
                                                           (string-downcase key)
                                                           ";"))
                                          ""
                                          (sort
                                           hash-keys
                                           (lambda (x y)
                                             (string<? (string-downcase x) (string-downcase y)))))])
    (set! canonical-header-names-string
          (substring canonical-header-names-string 0 (- (string-length canonical-header-names-string) 1)))
    (cons (string-append canonical-header/values-string "\n" canonical-header-names-string)
          canonical-header-names-string)))

(define (get-header-list header-name/value-hash)
  (let* ([hash-keys   (hash-keys header-name/value-hash)]
         [header-list (foldl
                       (lambda (key internal-header-list)
                         (cons
                          (string-append key
                                         ":"
                                         (hash-ref header-name/value-hash key))
                          internal-header-list))
                       (list)
                       (sort
                        hash-keys
                        (lambda (x y)
                          (string<? (string-downcase x) (string-downcase y)))))])
    (reverse header-list)))

(define (get-query-list query-name/value-hash)
  (let* ([hash-keys   (hash-keys query-name/value-hash)]
         [header-list (foldl
                       (lambda (key internal-header-list)
                         (cons
                          (cons (string->symbol key) (hash-ref query-name/value-hash key))
                          internal-header-list))
                       (list)
                       (sort
                        hash-keys
                        (lambda (x y)
                          (string<? x y))))])
    (reverse header-list)))

(define (string-to-sign x-amz-date date-stamp region-name service-name hashed-canonical-request)
  (format
   "AWS4-HMAC-SHA256\n~a\n~a/~a/~a/aws4_request\n~a"
   x-amz-date
   date-stamp
   region-name
   service-name
   hashed-canonical-request))

(define (signing-string date-stamp region-name service-name secret-key)
  (bytes->hex-string (hmac-sha256
                      (hmac-sha256
                       (hmac-sha256
                        (hmac-sha256 (bytes-append #"AWS4" secret-key)
                                     date-stamp)
                        region-name)
                       service-name)
                      #"aws4_request")))

(define (hashed-canonical-request canonical-request)
  (bytes->hex-string
   (sha256
    (string->bytes/utf-8 canonical-request))))

(define (signature signing-string string-to-sign)  
    (bytes->hex-string
     (hmac-sha256 (hex-string->bytes signing-string)
                  (string->bytes/utf-8 string-to-sign))))

(define (aws-request-authorization-string
         date-stamp
         x-amz-date
         request-type
         relative-uri
         query
         region-name
         service-name
         header-name/value-hash
         data-sha256
         [show-strings #f])
  (let* ((date-stamp-bytes                           (string->bytes/utf-8 date-stamp))
         (x-amz-date-bytes                           (string->bytes/utf-8 x-amz-date))
         (region-name-bytes                          (string->bytes/utf-8 region-name))
         (service-name-bytes                         (string->bytes/utf-8 service-name))
         (access-key-bytes                           (string->bytes/utf-8 (access-key)))
         (secret-key-bytes                           (string->bytes/utf-8 (secret-key)))
         (signed-header-string-and-header-names-pair (signed-header-string-and-header-names-pair header-name/value-hash))
         (canonical-request                          (format "~a\n/~a\n~a\n~a\n~a"
                                                             request-type
                                                             relative-uri
                                                             query
                                                             (car signed-header-string-and-header-names-pair)
                                                             data-sha256))
         (hashed-canonical-request                   (hashed-canonical-request canonical-request))
         (string-to-sign                             (string-to-sign x-amz-date-bytes
                                                                     date-stamp-bytes
                                                                     region-name-bytes
                                                                     service-name-bytes
                                                                     hashed-canonical-request))
         (signing-string                             (signing-string date-stamp-bytes
                                                                     region-name-bytes
                                                                     service-name-bytes
                                                                     secret-key-bytes))
         (signature                                  (signature signing-string string-to-sign))
         (authorization-string                       (format " AWS4-HMAC-SHA256 Credential=~a/~a/~a/~a/aws4_request, SignedHeaders=~a, Signature=~a"
                                                             (access-key)
                                                             date-stamp
                                                             region-name
                                                             service-name
                                                             (cdr signed-header-string-and-header-names-pair) 
                                                             signature)))
    (cond [show-strings
          (begin
            (display canonical-request)
            (newline)
            (display ";-------------------------------------------------------------------------------------")
            (newline)
            (display string-to-sign)
            (newline)
            (display ";-------------------------------------------------------------------------------------")
            (newline)
            (display signature)
            (newline)
            (display ";-------------------------------------------------------------------------------------")    
            (newline))])
    authorization-string))

(define (sqs-send-message message queue-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([parameter-name/value-hash (make-hash `(,(cons "Action"         "SendMessage")
                                                             ,(cons "AWSAccessKeyId" (access-key))
                                                             ,(cons "Expires"        (expires))
                                                             ,(cons "MessageBody"    message)
                                                             ,(cons "Version"        (version))))]
                     [payload                                (get-delimited-parameter-string parameter-name/value-hash)]
                     [data-sha256                            (bytes->hex-string
                                                              (sha256
                                                               (string->bytes/utf-8
                                                                payload)))]
                     [header-hash                            (make-hash
                                                              `(,(cons "host"         (format "sqs.~a.amazonaws.com" (region)))
                                                                ,(cons "content-type" "application/x-www-form-urlencoded; charset=utf-8")
                                                                ,(cons "x-amz-date"   x-amz-date)))]
                     [authorization-string                   (aws-request-authorization-string
                                                              date-stamp
                                                              x-amz-date
                                                              "POST"
                                                              (format "~a/~a" (account-number) queue-name)
                                                              ""
                                                              (region)
                                                              "sqs"
                                                              header-hash
                                                              data-sha256)]
                     [url                                    (make-url "https"
                                                                       #f
                                                                       (format "sqs.~a.amazonaws.com" (region))
                                                                       #f
                                                                       #t
                                                                       `(,(make-path/param (account-number) '()),(make-path/param queue-name '()))
                                                                       (list)
                                                                       #f)])
                (hash-set! header-hash "Authorization" authorization-string)
                (let ([response (port->string
                                 (post-impure-port
                                  url
                                  (string->bytes/utf-8 payload)
                                  (get-header-list header-hash)))])
                  (cond [(string=? "200" (get-http-status-code response)) #t]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "POST"
                                                                                                        (format "~a/~a" (account-number) queue-name)
                                                                                                        ""
                                                                                                        (region)
                                                                                                        "sqs"
                                                                                                        header-hash
                                                                                                        data-sha256))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            (let ([response (port->string
                                                                                             (post-impure-port
                                                                                              url
                                                                                              (string->bytes/utf-8 payload)
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "200" (get-http-status-code response))
                                                                                  #t
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))

(define (sqs-delete-message receipt-handle queue-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([parameter-name/value-hash (make-hash `(,(cons "Action"         "DeleteMessage")
                                                             ,(cons "AWSAccessKeyId" (access-key))
                                                             ,(cons "Expires"        (expires))
                                                             ,(cons "ReceiptHandle"  receipt-handle)
                                                             ,(cons "Version"        (version))))]
                     [payload                                (get-delimited-parameter-string parameter-name/value-hash)]
                     [data-sha256                            (bytes->hex-string
                                                              (sha256
                                                               (string->bytes/utf-8
                                                                payload)))]
                     [header-hash                            (make-hash
                                                              `(,(cons "host"         (format "sqs.~a.amazonaws.com" (region)))
                                                                ,(cons "content-type" "application/x-www-form-urlencoded; charset=utf-8")
                                                                ,(cons "x-amz-date"   x-amz-date)))]
                     [authorization-string                   (aws-request-authorization-string
                                                              date-stamp
                                                              x-amz-date
                                                              "POST"
                                                              (format "~a/~a" (account-number) queue-name)
                                                              ""
                                                              (region)
                                                              "sqs"
                                                              header-hash
                                                              data-sha256)]
                     [url                                    (make-url "https"
                                                                       #f
                                                                       (format "sqs.~a.amazonaws.com" (region))
                                                                       #f
                                                                       #t
                                                                       `(,(make-path/param (account-number) '()),(make-path/param queue-name '()))
                                                                       (list)
                                                                       #f)])
                (hash-set! header-hash "Authorization" authorization-string)
                (let ([response (port->string
                                 (post-impure-port
                                  url
                                  (string->bytes/utf-8 payload)
                                  (get-header-list header-hash)))])
                  (cond [(string=? "200" (get-http-status-code response)) #t]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "POST"
                                                                                                        (format "~a/~a" (account-number) queue-name)
                                                                                                        ""
                                                                                                        (region)
                                                                                                        "sqs"
                                                                                                        header-hash
                                                                                                        data-sha256))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            (let ([response (port->string
                                                                                             (post-impure-port
                                                                                              url
                                                                                              (string->bytes/utf-8 payload)
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "200" (get-http-status-code response))
                                                                                  #t
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))

(define (sqs-receive-message queue-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([query-name/value-hash      (make-hash `(,(cons "Action"         "ReceiveMessage")
                                                              ,(cons "AWSAccessKeyId" (access-key))
                                                              ,(cons "Expires"        (expires))
                                                              ,(cons "Version"        (version))))]
                     [query                      (get-delimited-parameter-string query-name/value-hash)]
                     [data-sha256                (bytes->hex-string
                                                  (sha256
                                                   (string->bytes/utf-8
                                                    "")))]
                     [header-hash                (make-hash
                                                  `(,(cons "host"         (format "sqs.~a.amazonaws.com" (region)))
                                                    ,(cons "x-amz-date"   x-amz-date)))]
                     [authorization-string       (aws-request-authorization-string
                                                  date-stamp
                                                  x-amz-date
                                                  "GET"
                                                  (format "~a/~a" (account-number) queue-name)
                                                  query
                                                  (region)
                                                  "sqs"
                                                  header-hash
                                                  data-sha256)]
                     [query-list                 (get-query-list query-name/value-hash)]
                     [url                        (make-url "https"
                                                           #f
                                                           (format "sqs.~a.amazonaws.com" (region))
                                                           #f
                                                           #t
                                                           `(,(make-path/param (account-number) '()),(make-path/param queue-name '()))
                                                           query-list
                                                           '#f)])
                (hash-set! header-hash "Authorization" authorization-string)
                (let ([response (port->string
                                 (get-impure-port
                                  url
                                  (get-header-list header-hash)))])
                  (cond [(string=? "200" (get-http-status-code response)) (let* ([response-xexpr  (get-response-xml-xexpr response)]
                                                                                 [receipt-handle  (se-path* '(ReceiptHandle) response-xexpr)]
                                                                                 [message-body    (se-path* '(Body) response-xexpr)])
                                                                            (if (and receipt-handle (sqs-delete-message receipt-handle queue-name))
                                                                                message-body
                                                                                #f))]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "GET"
                                                                                                        (format "~a/~a" (account-number) queue-name)
                                                                                                        query
                                                                                                        (region)
                                                                                                        "sqs"
                                                                                                        header-hash
                                                                                                        data-sha256))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            (let ([response (port->string
                                                                                             (get-impure-port
                                                                                              url
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "200" (get-http-status-code response))
                                                                                  #t
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))

(define (s3-put name data storage-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([encoded-data         (uri-encode data)]
                     [encoded-data-length  (number->string(string-length encoded-data))]
                     [data-sha256          (bytes->hex-string(sha256(string->bytes/utf-8 encoded-data)))]
                     [header-hash          (make-hash `(,(cons "host"                         (format "~a.s3.amazonaws.com" storage-name))
                                                        ,(cons "x-amz-content-sha256"         data-sha256)
                                                        ,(cons "content-length"               encoded-data-length)
                                                        ,(cons "x-amz-server-side-encryption" "AES256")
                                                        ,(cons "x-amz-date"                   x-amz-date)))]
                     [authorization-string (aws-request-authorization-string
                                            date-stamp
                                            x-amz-date
                                            "PUT"
                                            name
                                            ""
                                            (region)
                                            "s3"
                                            header-hash
                                            data-sha256
                                            #f)]
                     [url                   (make-url "https"
                                                      #f
                                                      (format "~a.s3.amazonaws.com" storage-name)
                                                      #f
                                                      #t
                                                      `(,(make-path/param name '()))
                                                      (list)
                                                      #f)])
                (hash-set! header-hash "Authorization" authorization-string)
                ; 'put-impure-port' adds these. we needed them
                ; for the authorization string calculation, but
                ; we have to take them out or the values will
                ; get doubled up and it'll fail
                (hash-remove! header-hash "content-length")
                (hash-remove! header-hash "host")
                (let ([response (port->string
                                 (put-impure-port
                                  url
                                  (string->bytes/utf-8 encoded-data)
                                  (get-header-list header-hash)))])
                  (cond [(string=? "200" (get-http-status-code response)) #t]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "PUT"
                                                                                                        name
                                                                                                        ""
                                                                                                        (region)
                                                                                                        "s3"
                                                                                                        header-hash
                                                                                                        data-sha256
                                                                                                        #f))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            ;; see above for why these needed to be removed
                                                                            (hash-remove! header-hash "content-length")
                                                                            (hash-remove! header-hash "host")
                                                                            (let ([response (port->string
                                                                                             (put-impure-port
                                                                                              url
                                                                                              (string->bytes/utf-8 encoded-data)
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "200" (get-http-status-code response))
                                                                                  #t
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))


(define (s3-get name storage-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([data-sha256                (bytes->hex-string(sha256(string->bytes/utf-8 "")))]
                     [header-hash                (make-hash `(,(cons "host"                 (format "~a.s3.amazonaws.com" storage-name))
                                                              ,(cons "x-amz-content-sha256" data-sha256)
                                                              ,(cons "x-amz-date"           x-amz-date)))]
                     [authorization-string       (aws-request-authorization-string
                                                  date-stamp
                                                  x-amz-date
                                                  "GET"
                                                  name
                                                  ""
                                                  (region)
                                                  "s3"
                                                  header-hash
                                                  data-sha256)]
                     [url                        (make-url "https"
                                                           #f
                                                           (format "~a.s3.amazonaws.com" storage-name)
                                                           #f
                                                           #t
                                                           `(,(make-path/param name '()))
                                                           (list)
                                                           '#f)])
                (hash-set! header-hash "Authorization" authorization-string)
                ; 'get-impure-port' adds this. we needed it
                ; for the authorization string calculation, but
                ; we have to take it out or the value will
                ; get doubled up and it'll fail
                (hash-remove! header-hash "host")
                (let ([response (port->string
                                 (get-impure-port
                                  url
                                  (get-header-list header-hash)))])
                  (cond [(string=? "200" (get-http-status-code response)) (let ([data (get-get-response-data response)])
                                                                            (if (s3-delete name storage-name)
                                                                                (uri-decode data)
                                                                                (begin (newline)
                                                                                       (display response)
                                                                                       (newline)
                                                                                       #f)))]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "GET"
                                                                                                        name
                                                                                                        ""
                                                                                                        (region)
                                                                                                        "s3"
                                                                                                        header-hash
                                                                                                        data-sha256))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            ;; see above
                                                                            (hash-remove! header-hash "host")
                                                                            (let ([response (port->string
                                                                                             (get-impure-port
                                                                                              url
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "200" (get-http-status-code response))
                                                                                  (let ([data (get-get-response-data response)])
                                                                                    (if (s3-delete name storage-name)
                                                                                        (uri-decode data)
                                                                                        (begin (newline)
                                                                                               (display response)
                                                                                               (newline)
                                                                                               #f)))
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))

(define (s3-delete name storage-name)
  (let-values ([(date-stamp x-amz-date rfc-2822) (date-stamp-and-x-amz-date-and-rfc2822)])
              (let* ([data-sha256                (bytes->hex-string(sha256(string->bytes/utf-8 "")))]
                     [header-hash                (make-hash `(,(cons "host"                 (format "~a.s3.amazonaws.com" storage-name))
                                                              ,(cons "x-amz-content-sha256" data-sha256)
                                                              ,(cons "x-amz-date"           x-amz-date)))]
                     [authorization-string       (aws-request-authorization-string
                                                  date-stamp
                                                  x-amz-date
                                                  "DELETE"
                                                  name
                                                  ""
                                                  (region)
                                                  "s3"
                                                  header-hash
                                                  data-sha256)]
                     [url                        (make-url "https"
                                                           #f
                                                           (format "~a.s3.amazonaws.com" storage-name)
                                                           #f
                                                           #t
                                                           `(,(make-path/param name '()))
                                                           (list)
                                                           '#f)])
                (hash-set! header-hash "Authorization" authorization-string)
                ; 'delete-impure-port' adds this. we needed it
                ; for the authorization string calculation, but
                ; we have to take it out or the value will
                ; get doubled up and it'll fail
                (hash-remove! header-hash "host")
                (let ([response (port->string
                                 (delete-impure-port
                                  url
                                  (get-header-list header-hash)))])                  
                  (cond [(string=? "204" (get-http-status-code response)) #t]
                        [(string=? "307" (get-http-status-code response)) (let* ([response-xexpr     (get-response-xml-xexpr response)]
                                                                                 [temporary-redirect (se-path* '(Endpoint) response-xexpr)])
                                                                            (set-url-host! url temporary-redirect)
                                                                            (hash-remove! header-hash "Authorization")
                                                                            (hash-set!    header-hash "host"          temporary-redirect)
                                                                            (set! authorization-string (aws-request-authorization-string
                                                                                                        date-stamp
                                                                                                        x-amz-date
                                                                                                        "DELETE"
                                                                                                        name
                                                                                                        ""
                                                                                                        (region)
                                                                                                        "s3"
                                                                                                        header-hash
                                                                                                        data-sha256))
                                                                            (hash-set!    header-hash "Authorization" authorization-string)
                                                                            ;; see above
                                                                            (hash-remove! header-hash "host")
                                                                            (let ([response (port->string
                                                                                             (delete-impure-port
                                                                                              url
                                                                                              (get-header-list header-hash)))])
                                                                              (if (string=? "204" (get-http-status-code response))
                                                                                  #t
                                                                                  (begin (newline)
                                                                                         (display response)
                                                                                         (newline)
                                                                                         #f))))]
                        [else                                             (begin (newline)
                                                                                 (display response)
                                                                                 (newline)
                                                                                 #f)])))))

;=======================================================================================
;=======================================================================================
;; external API

(require (planet williams/uuid:1:3/uuid))


(define (put-post-processing-lines-for-exposure-analysis exposure-analysis-uuid-string post-processing-lines)
  (if (s3-put exposure-analysis-uuid-string post-processing-lines "post-processing-lines-storage")
      (if (sqs-send-message exposure-analysis-uuid-string "post-processing-lines-queue")
          #t
          (begin
            (s3-delete exposure-analysis-uuid-string "post-processing-lines-storage")
            #f))
      #f))

(define (get-post-processing-lines)
  (let ([post-processing-lines-name (sqs-receive-message "post-processing-lines-queue")])
    (if post-processing-lines-name
        (let ([post-processing-lines (s3-get post-processing-lines-name "post-processing-lines-storage")])
          (if post-processing-lines
              (cons post-processing-lines-name post-processing-lines)
              #f))
        #f)))

(define (put-nlp-results exposure-analysis-uuid-string nlp-results)
  (if (s3-put exposure-analysis-uuid-string nlp-results "nlp-results-storage")
      (if (sqs-send-message exposure-analysis-uuid-string "nlp-results-queue")
          #t
        (begin
         (s3-delete exposure-analysis-uuid-string "nlp-results-storage")
         #f))
    #f))

(define (get-nlp-results)
  (let ([nlp-results-name (sqs-receive-message "nlp-results-queue")])
    (if nlp-results-name
        (let ([nlp-results (s3-get nlp-results-name "nlp-results-storage")])
          (if nlp-results
              (cons nlp-results-name nlp-results)
              #f))
        #f)))

(define (put-exposure-results exposure-analysis-uuid-string exposure-results)
  (if (s3-put exposure-analysis-uuid-string exposure-results "exposure-results-storage")
      #t
      #f))

(define (get-exposure-results exposure-analysis-uuid-string)
  (s3-get exposure-analysis-uuid-string "exposure-results-storage"))

;=======================================================================================
;=======================================================================================
;; API tests

(define (post-processing-lines-put/get-test exposure-analysis-uuid-string)
  (display (format "(put-post-processing-lines ~a ~a) -> " exposure-analysis-uuid-string "post lines test<><>(){}!@##%$^&*"))
  (display (put-post-processing-lines-for-exposure-analysis exposure-analysis-uuid-string "post lines test<><>(){}!@##%$^&*"))
  (newline)
  (sleep 9)
  (display "(get-post-processing-lines) -> ")
  (display (get-post-processing-lines)))

(define (nlp-results-put/get-test exposure-analysis-uuid-string)
  (display (format "(put-nlp-results ~a ~a) -> " exposure-analysis-uuid-string "nlp results test<><>(){}!@##%$^&*"))
  (display (put-nlp-results exposure-analysis-uuid-string "nlp results test<><>(){}!@##%$^&*"))
  (newline)
  (sleep 9)
  (display "(get-nlp-results) -> ")
  (display (get-nlp-results)))

(define (exposure-results-put/get-test exposure-analysis-uuid-string)
  (display (format "(put-exposure-results ~a ~a) -> " exposure-analysis-uuid-string "exposure results test<><>(){}!@##%$^&*"))
  (display (put-exposure-results exposure-analysis-uuid-string "exposure results test<><>(){}!@##%$^&*"))
  (newline)
  (sleep 9)
  (display "(get-exposure-results) -> ")
  (display (get-exposure-results exposure-analysis-uuid-string)))

(define (perform-aws-tests)
  (let ([exposure-analysis-uuid-string (uuid->string (make-uuid-4))])
    (newline)
    (post-processing-lines-put/get-test exposure-analysis-uuid-string)
    (newline)
    (nlp-results-put/get-test           exposure-analysis-uuid-string)
    (newline)
    (exposure-results-put/get-test      exposure-analysis-uuid-string)
    (newline)))


)



