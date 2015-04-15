# Copyright 2015 Ryan B. Hicks
#
# 

Template.exposureLaunchButton.events(
        'click #exposureButton' : ->
                analysisUuid = Session.get('analysisUuid')

                Meteor.call("findExposure", analysisUuid)
                console.log("finding exposure"))
