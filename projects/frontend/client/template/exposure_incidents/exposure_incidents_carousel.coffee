exposureIncidents = ->
        analysisUuid            = Session.get('analysisUuid')
        exposureIncidentsCursor = ExposureIncidents.find({exposure_analysis_uuid: analysisUuid})

        exposureIncidentsArray = []



        exposureIncidentsCursor.forEach ((exposureIncident) ->
                title           = exposureIncident["title"]
                titleText       = IncidentTitles[title]
                descriptionText = IncidentDescriptions[title]
                type            = exposureIncident["type"]
                typeText        = IncidentTypes[type]

                
                exposureIncidentsArray.push({title: titleText, type: typeText, uuid: exposureIncident["uuid"], description: descriptionText}))

        return exposureIncidentsArray

Template.exposureIncidentsCarousel.helpers
        exposureIncidents:exposureIncidents
                

exposureIncidentsSubscribe = Meteor.subscribe('exposureIncidentsPublish')

Template.exposureIncidentsCarousel.rendered = ->

        $(".owl-carousel").owlCarousel()
        
        Tracker.autorun(((computation) ->
                
                if exposureIncidentsSubscribe.ready()
                        $(".owl-carousel").owlCarousel()

                        incidents = exposureIncidents()
                        counter   = 0

                        incidents.forEach((incident) ->
                                incident["counter"] =  counter
                                counter             += 1

                                $(".owl-carousel").data("owl-carousel").addItem(Blaze.toHTMLWithData(Template.exposureIncident, incident))
                        )
                ).bind(this))
