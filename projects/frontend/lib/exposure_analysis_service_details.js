// Copyright 2015 Ryan B. Hicks

ExposureAnalysisServiceDetails = new Mongo.Collection('exposure_analysis_service_details');



if (Meteor.isClient) {
    Meteor.subscribe('exposure_analysis_service_details_publish');
}

if (Meteor.isServer) {
    Meteor.publish('exposure_analysis_service_details_publish', function() {
        return ExposureAnalysisServiceDetails.find();
    });
}


