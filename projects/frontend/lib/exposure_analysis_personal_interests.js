// Copyright 2015 Ryan B. Hicks

ExposureAnalysisPersonalInterests = new Mongo.Collection('exposure_analysis_personal_interests');



TabularTablesPersonalInterests = {};

Meteor.isClient && Template.registerHelper('TabularTablesPersonalInterests', TabularTablesPersonalInterests);

TabularTablesPersonalInterests.PersonalInterests = new Tabular.Table({
    
    name:"PersonalInterestsList",
    collection:ExposureAnalysisPersonalInterests,
    columns: [
        {data: "value", title: "Personal Interests"}
    ]

});


