# Copyright 2015 Ryan B. Hicks


Template.exposureYoutubeCommentCount.helpers
        youtubeCommentCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisYoutubeCommentCount = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "youtube", key : "comment-count"})
                if exposureAnalysisYoutubeCommentCount
                        exposureAnalysisYoutubeCommentCount.value
