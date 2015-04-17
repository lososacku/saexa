# Copyright 2015 Ryan B. Hicks


Template.exposureTumblrBlogPostCount.helpers
        tumblrBlogPostCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisTumblrBlogPostCounts = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "tumblr", key : "blog-post-count"})
                if exposureAnalysisTumblrBlogPostCounts
                        exposureAnalysisTumblrBlogPostCounts.value
