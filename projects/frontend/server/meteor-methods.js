// Copyright 2015 Ryan B. Hicks

Meteor.startup(function () {

     twitter = new TwitterApi();

     facebookProcurer  = new FacebookProcurer("facebook");
     twitterProcurer   = new TwitterProcurer("twitter");
     tumblrProcurer    = new TumblrProcurer("tumblr");
     youtubeProcurer   = new YoutubeProcurer("youtube");
     instagramProcurer = new InstagramProcurer("instagram");

     tokens       = new Meteor.Collection('tokens');
     tokenSecrets = new Meteor.Collection('tokenSecrets');
     userIds      = new Meteor.Collection('userIds');
     userNames    = new Meteor.Collection('userNames');
 });


Meteor.methods({

    getSynthesizedExposureStatusValue: function() {
        
        exposureAnalysisNumericalResult = ExposureAnalysisNumericalResults.findOne();


        return exposureAnalysisNumericalResult.synthesized_exposure_status_value;
    },
    storeFacebookAuthenticationInformation: function() {

        tokens.remove({service: "facebook"})
        tokenSecrets.remove({service: "facebook"})
        userIds.remove({service: "facebook"})
        userNames.remove({service: "facebook"})

        tokens.insert({service: "facebook", token: Meteor.user().services.facebook.accessToken});
        tokenSecrets.insert({service: "facebook", tokenSecret: Meteor.user().services.facebook.accessTokenSecret});
        userIds.insert({service: "facebook", userId: Meteor.userId()});
        userNames.insert({service: "facebook", userName: Meteor.user().services.facebook.username});
    },
    storeTumblrAuthenticationInformation: function(tumblrName) {

        userNames.remove({service: "tumblr"})

        userNames.insert({service: "tumblr", userName: tumblrName});
    },
    storeTwitterAuthenticationInformation: function() {

        tokens.remove({service: "twitter"})
        tokenSecrets.remove({service: "twitter"})
        userIds.remove({service: "twitter"})
        userNames.remove({service: "twitter"})

        tokens.insert({service: "twitter", token: Meteor.user().services.twitter.accessToken});
        tokenSecrets.insert({service: "twitter", tokenSecret: Meteor.user().services.twitter.accessTokenSecret});
        userIds.insert({service: "twitter", userId: Meteor.userId()});
        userNames.insert({service: "twitter", userName: Meteor.user().services.twitter.username});
    },
    storeGoogleAuthenticationInformation: function() {

        tokens.remove({service: "google"})
        tokenSecrets.remove({service: "google"})
        userIds.remove({service: "google"})
        userNames.remove({service: "google"})

        tokens.insert({service: "google", token: Meteor.user().services.google.accessToken});
        tokenSecrets.insert({service: "google", tokenSecret: Meteor.user().services.google.accessTokenSecret});
        userIds.insert({service: "google", userId: Meteor.userId()});
        userNames.insert({service: "google", userName: Meteor.user().services.google.username});
    },
    storeInstagramAuthenticationInformation: function() {

        tokens.remove({service: "instagram"})
        tokenSecrets.remove({service: "instagram"})
        userIds.remove({service: "instagram"})
        userNames.remove({service: "instagram"})

        tokens.insert({service: "instagram", token: Meteor.user().services.instagram.accessToken});
        tokenSecrets.insert({service: "instagram", tokenSecret: Meteor.user().services.instagram.accessTokenSecret});
        userIds.insert({service: "instagram", userId: Meteor.userId()});
        userNames.insert({service: "instagram", userName: Meteor.user().services.instagram.username});
    },
    retrieveFacebookUserName: function() {

        facebookUserName = tokens.findOne({service: "facebook"})['userName'];

        return facebookUserName;
    },
    retrieveFacebookToken: function() {

        facebookToken = tokens.findOne({service: "facebook"})['token'];

        return facebookToken;
    },
    retrieveTwitterToken: function() {

        twitterToken = tokens.findOne({service: "twitter"})['token'];

        return twitterToken;
    },
    retrieveTwitterTokenSecret: function() {

        twitterTokenSecret = tokenSecrets.findOne({service: "twitter"})['tokenSecret'];

        return twitterTokenSecret;
    },
    retrieveGoogleToken: function() {

        googleToken = tokens.findOne({service: "google"})['token'];

        return googleToken;
    },
    retrieveInstagramToken: function() {

        instagramToken = tokens.findOne({service: "instagram"})['token'];

        return instagramToken;
    },
    retrieveTumblrUserName: function() {

        return userNames.findOne({service: "tumblr"})['userName'];
    },
    retrieveYoutubeUserName: function() {

        return userNames.findOne({service: "google"})['userName'];
    },
    findExposure: function (analysisUuid) {

        facebookProcurer.procure(analysisUuid);
        twitterProcurer.procure(analysisUuid);
        tumblrProcurer.procure(analysisUuid);
        youtubeProcurer.procure(analysisUuid);
        instagramProcurer.procure(analysisUuid);

        allPostProcessingLines = "";
        allServiceDetailsLines = "";

        allPostProcessingLines += facebookProcurer.getClipsPostProcessingLines();
        allPostProcessingLines += twitterProcurer.getClipsPostProcessingLines();
        allPostProcessingLines += tumblrProcurer.getClipsPostProcessingLines();
        allPostProcessingLines += youtubeProcurer.getClipsPostProcessingLines();
        allPostProcessingLines += instagramProcurer.getClipsPostProcessingLines();

        allPostProcessingLines += facebookProcurer.getPrologInfoProcessingLines();
        allPostProcessingLines += twitterProcurer.getPrologInfoProcessingLines();
        allPostProcessingLines += tumblrProcurer.getPrologInfoProcessingLines();
        allPostProcessingLines += youtubeProcurer.getPrologInfoProcessingLines();
        allPostProcessingLines += instagramProcurer.getPrologInfoProcessingLines();

        allPostProcessingLines += facebookProcurer.getPrologPostProcessingLines();
        allPostProcessingLines += twitterProcurer.getPrologPostProcessingLines();
        allPostProcessingLines += tumblrProcurer.getPrologPostProcessingLines();
        allPostProcessingLines += youtubeProcurer.getPrologPostProcessingLines();
        allPostProcessingLines += instagramProcurer.getPrologPostProcessingLines();

        allServiceDetailsLines += facebookProcurer.getServiceDetails();
        allServiceDetailsLines += twitterProcurer.getServiceDetails();
        allServiceDetailsLines += tumblrProcurer.getServiceDetails();
        allServiceDetailsLines += youtubeProcurer.getServiceDetails();
        allServiceDetailsLines += instagramProcurer.getServiceDetails();

        encodedAllPostProcessingLines = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(allPostProcessingLines));
        encodedAllServiceDetailsLines = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(allServiceDetailsLines));

        console.log("-----------ping-------------");

        postProcessingLinesUrl = "http://localhost:53535/put-post-processing-lines-for-exposure-analysis/" + analysisUuid;
        serviceDetailsLinesUrl = "http://localhost:53535/put-service-details-lines/" + analysisUuid;
        // purgeUrl               = "http://localhost:53535/purge/" + analysisUuid;

        HTTP.post(postProcessingLinesUrl, {data: encodedAllPostProcessingLines});
        HTTP.post(serviceDetailsLinesUrl, {data: encodedAllServiceDetailsLines});

        allPostProcessingLines = "";
        allServiceDetailsLines = "";

        facebookProcurer.purge();
        twitterProcurer.purge();
        tumblrProcurer.purge();
        youtubeProcurer.purge();
        instagramProcurer.purge();
    }
});
