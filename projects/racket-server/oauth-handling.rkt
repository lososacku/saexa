;; Copyright 2015 Ryan B. Hicks

#lang racket

(require (planet ryanc/webapi:1:=1/oauth2))


(define facebook-oauth2-auth-server
  (oauth2-auth-server #:auth-url     "https://www.facebook.com/dialog/oauth"
                      #:token-url    "https://graph.facebook.com/oauth/access_token"))


(define facebook-client (oauth2-client #:id "357471567663746"))

(define facebook-permissions '("user_about_me"
                               "user_activities"
                               "user_birthday"
                               "user_checkins"
                               "user_education_history"
                               "user_events"
                               "user_groups"
                               "user_hometown"
                               "user_interests"
                               "user_likes"
                               "user_location"
                               "user_notes"
                               "user_questions"
                               "user_relationships"
                               "user_relationship_details"
                               "user_religion_politics"
                               "user_status"
                               "user_subscriptions"
                               "user_videos"
                               "user_website"
                               "user_work_history"
                               "read_stream"
                               "user_online_presence"
                               "email"))

;; (display (send facebook-oauth2-auth-server
;;                get-auth-request-url
;;                #:client       facebook-client
;;                #:scopes       facebook-permissions
;;                #:redirect-uri "https://www.facebook.com/connect/login_success.html"))



(port->string
 (post-impure-port
  (string->url "https://api.twitter.com//oauth2/token"
  (string->bytes/utf-8 payload)
  (get-header-list header-hash))

