# Copyright 2015 Ryan B. Hicks

# login

Template.login.events(
        'click #facebookLogin' : ->
                Meteor.loginWithFacebook(
                        requestPermissions : ['user_about_me']
                        , (err) ->
                                if err
                                        console.log("error with login with facebook " + err)
                                else
                                        console.log("login with facebook succeeded")
                                        Meteor.call("storeFacebookAuthenticationInformation"))
        'click #instagramLogin'  : ->
                Meteor.loginWithInstagram(
                        requestPermissions : []
                        , (err) ->
                                if err
                                        console.log("error with login with instagram " + err)
                                else
                                        console.log("login with instagram succeeded")
                                        Meteor.call("storeInstagramAuthenticationInformation"))
        'click #tumblrLogin'  : ->
                Meteor.call("storeTumblrAuthenticationInformation", document.getElementById("tumblrAccountName").value)
                console.log("tumblr information stored")
        'click #twitterLogin'  : ->
                Meteor.loginWithTwitter(
                        requestPermissions : []
                        , (err) ->
                                if err
                                        console.log("error with login with twitter " + err)
                                else
                                        console.log("login with twitter succeeded")
                                        Meteor.call("storeTwitterAuthenticationInformation"))
        'click #youtubeLogin'  : ->
                Meteor.loginWithGoogle(
                        requestPermissions : ['https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtube']
                        , (err) ->
                                if err
                                        console.log("error with login with youtube " + err)
                                else
                                        console.log("login with youtube succeeded")
                                        Meteor.call("storeGoogleAuthenticationInformation")))
