// Copyright 2015 Ryan B. Hicks

ExposureAnalysisNames = new Mongo.Collection('exposure_analysis_names');



TabularTablesNames = {};

Meteor.isClient && Template.registerHelper('TabularTablesNames', TabularTablesNames);

TabularTablesNames.Names = new Tabular.Table({
    
    name:"NamesList",
    collection:ExposureAnalysisNames,
    columns: [
        {data: "value", title: "Names"}
    ]

});
