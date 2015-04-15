# Copyright 2015 Ryan B. Hicks

Template.exposurePersonalInterests.helpers
        selector: ->
                {exposure_analysis_uuid: Session.get('analysisUuid'), key: {$in: ["Musician/band",
                                                                                  "Camera/photo",
                                                                                  "Company",
                                                                                  "Product/service",
                                                                                  "Public figure",
                                                                                  "Education",
                                                                                  "Public places",
                                                                                  "Attractions/things to do",
                                                                                  "School sports team",
                                                                                  "Sport"]}}


