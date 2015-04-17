# Copyright 2015 Ryan B. Hicks


Template.exposureYoutubeChannelCount.helpers
        youtubeChannelCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisYoutubeChannelCount = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "youtube", key : "channel-count"})
                if exposureAnalysisYoutubeChannelCount
                        exposureAnalysisYoutubeChannelCount.value
