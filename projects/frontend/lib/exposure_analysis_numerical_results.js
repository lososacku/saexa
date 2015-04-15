// Copyright 2015 Ryan B. Hicks

ExposureAnalysisNumericalResults = new Mongo.Collection('exposure_analysis_numerical_results');

if (Meteor.isServer) {
    Meteor.publish('exposure_analysis_numerical_results', function() {
        return ExposureAnalysisNumericalResults.find({});
    });
}

