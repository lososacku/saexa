exposureAnalysisNumericalResultsSub = Meteor.subscribe('exposure_analysis_numerical_results')

Template.exposureGauge.created = ->
#      analysisUuid = Meteor.uuid()
        analysisUuid = "f593a6f6-60d0-4b28-b70a-779ffed9aa4d"
        Session.set('analysisUuid', analysisUuid)


Template.exposureGauge.rendered = ->
        gauge = new JustGage
                id: "gauge"
                value: 0
                min: 0
                max: 100
                title: "How Exposed You Are"
                label: ""
                levelColorsGradient: false 

        Tracker.autorun((->
                analysisUuid                            = Session.get('analysisUuid')
                currentExposureAnalysisNumericalResults = ExposureAnalysisNumericalResults.findOne({exposure_analysis_uuid: analysisUuid})


                if exposureAnalysisNumericalResultsSub.ready() and currentExposureAnalysisNumericalResults
                    synthesizedExposureStatusValue = Math.round(100 * currentExposureAnalysisNumericalResults.synthesized_exposure_status_value)
                    gauge.refresh(synthesizedExposureStatusValue)
            ).bind(this))


