        


Template.exposureIncident.helpers

        postedDataItems: (uuid) ->
                PostedDataItems.find({exposure_incident_uuid: uuid})
