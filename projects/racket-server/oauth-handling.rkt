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

;curl --header "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" --header "Content-Length: 29" --header "Accept-Encoding: gzip" --header "Authorization: Basic dkJFNm1Sd0tQS2F3cmpnd2xxNVp0dGFrZzpBUzIzUVhyWGNFcmtuendNMnFJaTlaSEtuRE8x\r\neW1UMTZsYzBoYXBvRU9hNU1WMnM1VA==\r\n" --data "grant_type=client_credentials" --request POST https://api.twitter.com//oauth2/token

;curl --header "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" --header "Content-Length: 29" --header "Authorization: Basic dkJFNm1Sd0tQS2F3cmpnd2xxNVp0dGFrZzpBUzIzUVhyWGNFcmtuendNMnFJaTlaSEtuRE8xeW1UMTZsYzBoYXBvRU9hNU1WMnM1VA==" --data "grant_type=client_credentials" --request POST https://api.twitter.com//oauth2/token



; !!! the docs aren't accurate about the url (i.e., where the twitter name goes...the below works)
;curl --header "Authorization: Bearer AAAAAAAAAAAAAAAAAAAAAIdJZAAAAAAAUSxfkUMGUwdiGaAXsQSNgv4259c%3DPMSQPpiGFb7b1DBKx6bq5Zg8SNarfRZYW3qxGputD6eLqvQcsd" --request GET https://api.twitter.com/1.1/statuses/user_timeline/KaitlynSomersby.json?count=10



  

;AAAAAAAAAAAAAAAAAAAAAIdJZAAAAAAAUSxfkUMGUwdiGaAXsQSNgv4259c%3DPMSQPpiGFb7b1DBKx6bq5Zg8SNarfRZYW3qxGputD6eLqvQcsd  

;access_token=CAAFFHlXO0oIBALkiWZAQRKGVrJfFiYsZCk5PnaJWfXlWD2btbJyVKcZArZAHcmH8MBZCmIr2hYfMdoEw0X8A7QZAzZCDZBgV7sw4anb7QaalfZCxvqewZC8x0RekoBLJpFkZBh8SYeg750hvPuCYXrIQUmxJpXZBtYlD8qnyCeow5qCyXh6PvljdmbS0TFZCuZCJM5TY46KtZAUXfHFmqZBl2qmI147t&expires=5183568


;https://graph.facebook.com/me/email?access_token=CAAFFHlXO0oIBALkiWZAQRKGVrJfFiYsZCk5PnaJWfXlWD2btbJyVKcZArZAHcmH8MBZCmIr2hYfMdoEw0X8A7QZAzZCDZBgV7sw4anb7QaalfZCxvqewZC8x0RekoBLJpFkZBh8SYeg750hvPuCYXrIQUmxJpXZBtYlD8qnyCeow5qCyXh6PvljdmbS0TFZCuZCJM5TY46KtZAUXfHFmqZBl2qmI147t

;https://graph.facebook.com/oauth/access_token?client_id=357471567663746&redirect_uri=https%3A%2F%2Fwww.facebook.com%2Fconnect%2Flogin_success.html&client_secret=de4ed6fc783b0a81e5e7c2c16bfd8cbd&code=AQD_fyd8grXZuI4NdMnujM1jTY-B7L0FJPW9w97PJUY-EBsqnJCYg6NVvFGpDEMhvKZ6lR0OBbmKRkBuTTc4FGr-y-rUcigQK6fZK-ZL6gV7c_pncGk2ipD_-FsGOP4VoczPUplyhfT-hSKRbAfgynSbkUaXRxXglPfacXXq1rDd-1uIYs0aPp1lu6TaTVDLbtTsuTGiwRK8bi4LdISKyfeFIIrQRycGlpZsIPvW8AN3Xp_9m9avz8Au29S3CuWfUJYsAjIrFoQFWnfBcsMlP65260o_uDDkjRiG919qBlnTxSDHruAkfyru_m_azhmeE-gYlZ6Rz8eMy-aOJjDn_fxk

;twitter app key: robPOVzA5hrAPgvIL84u3Z3PA

; temp twitter app id: vBE6mRwKPKawrjgwlq5Zttakg
; temp twitter secret: AS23QXrXcErknzwM2qIi9ZHKnDO1ymT16lc0hapoEOa5MV2s5T

; actual twitter app id:     BcpGCZhC2HljMbNqsap4cg
; actual twitter app secret: 2cg3ccCL2GyPbPiwfUfm0TPTdZQ5AmK3NRWBiA3k0

;vBE6mRwKPKawrjgwlq5Zttakg:AS23QXrXcErknzwM2qIi9ZHKnDO1ymT16lc0hapoEOa5MV2s5T

;fb app id:     357471567663746
;fb app secret: de4ed6fc783b0a81e5e7c2c16bfd8cbd

;https://www.facebook.com/connect/login_success.html?code=AQA5lC9wIbkzFZBCqne0ujwZ8CkPR_CThqrjlX4vw6Qc86523x9JaAAuzBtipoLPJ6RYuR9u7Gfk0TrMRQahsUXw-G2zht2UWH3qYl4A_PHwrRaNj5FsMV72bOIRavfYz1WIxm21M0Wm0EzOS-BrSsvluNLDSt7IUMuJurKcpj0IG9MH2W4B7v0xZp4MKb0ToMzhw7AkP9C5bClKTvivTxt6FWgNOKiA8V9KdxqcFD-dy1j4xgpmaPfV1YH5KtGmus4yzxidoaEAPb3w0-eAA9ZFoWqhw1vKeOGUZoYzo9C1XbpkzHFxDEZB6vWA3an_ZXzsrcU2PnQDNx9458Yvrsh-#_=_

;https://www.facebook.com/dialog/oauth?response_type=code&client_id=357471567663746&redirect_uri=https%3A%2F%2Fwww.facebook.com%2Fconnect%2Flogin_success.html&scope=user_about_me
;https://www.facebook.com/dialog/oauth?response_type=code&client_id=357471567663746&redirect_uri=https%3A%2F%2Fwww.facebook.com%2Fconnect%2Flogin_success.html&scope=user_about_me+user_activities+user_birthday+user_checkins+user_education_history+user_events+user_groups+user_hometown+user_interests+user_likes+user_location+user_notes+user_questions+user_relationships+user_relationship_details+user_religion_politics+user_status+user_subscriptions+user_videos+user_website+user_work_history+read_stream+user_online_presence+email&state=

;https://facebook.com/dialog/oauth?response_type=token&client_id=CLIENT_ID&redirect_uri=REDIRECT_URI&scope=email
