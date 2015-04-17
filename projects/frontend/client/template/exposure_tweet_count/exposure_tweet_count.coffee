# Copyright 2015 Ryan B. Hicks


Template.exposureTweetCount.helpers
        tweetCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisTweetCounts = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "twitter", key : "tweet-count"})
                if exposureAnalysisTweetCounts
                        exposureAnalysisTweetCounts.value
