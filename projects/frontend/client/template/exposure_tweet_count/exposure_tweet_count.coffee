# Copyright 2015 Ryan B. Hicks


Template.exposureTweetCount.helpers
        tweetCount: ->
                exposureAnalysisTweetCounts = ExposureAnalysisTweetCounts.findOne({exposure_analysis_uuid : "6b040e80-de5f-4bb9-b807-2f1f1cf17b91"})
                if exposureAnalysisTweetCounts
                        exposureAnalysisTweetCounts.value
