# Copyright 2015 Ryan B. Hicks


Template.exposureInstagramCommentCount.helpers
        instagramCommentCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisInstagramCommentCount = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "instagram", key : "comment-count"})
                if exposureAnalysisInstagramCommentCount
                        exposureAnalysisInstagramCommentCount.value
