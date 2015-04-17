# Copyright 2015 Ryan B. Hicks


Template.exposureTumblrBlogPostCount.helpers
        tumblrBlogPostCount: ->
                analysisUuid = Session.get("analysisUuid")
                exposureAnalysisTumblrBlogPostCount = ExposureAnalysisServiceDetails.findOne({exposure_analysis_uuid : analysisUuid, service_name : "tumblr", key : "blog-post-count"})
                if exposureAnalysisTumblrBlogPostCount
                        exposureAnalysisTumblrBlogPostCount.value
