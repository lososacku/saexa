# Copyright 2015 Ryan B. Hicks


Template.exposureFacebookMessageCount.helpers
        facebookMessageCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisFacebookMessageCount = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "facebook", key : "message-count"})
                if exposureAnalysisFacebookMessageCount
                        exposureAnalysisFacebookMessageCount.value
