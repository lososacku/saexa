// Copyright 2015 Ryan B. Hicks

ExposureIncidents = new Mongo.Collection('exposure_incidents');

if (Meteor.isServer) {
    Meteor.publishComposite('exposureIncidentsPublish', {
        find: function() {
                
            return ExposureIncidents.find({});
        },
        children: [
            {
                find: function(exposureIncident) {
                    return PostedDataItems.find({exposure_incident_uuid: exposureIncident.uuid});
                }
            }
        ]
    });
}
