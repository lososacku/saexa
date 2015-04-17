# Copyright 2015 Ryan B. Hicks


Template.exposureFacebookMessageCount.helpers
        facebookMessageCount: ->
                exposureAnalysisFacebookMessageCounts = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : "6b040e80-de5f-4bb9-b807-2f1f1cf17b91", service_name : "facebook", key : "message-count"})
                if exposureAnalysisFacebookMessageCounts
                        exposureAnalysisFacebookMessageCounts.value
