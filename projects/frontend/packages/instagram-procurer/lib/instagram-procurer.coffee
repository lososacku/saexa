# Copyright 2015 Ryan B. Hicks


class InstagramProcurer extends ProcurerBase

        constructor: (serviceName) ->

                @commentCount = 0
                
                super(serviceName)
        
        procure: (analysisUuid) ->

                @analysisUuid = analysisUuid

#                @debugOutput = true
                
                @procureProfileInformation()
                @procureRecentMedia()
                @procureLikedMedia()
                @addServiceDetail("comment-count", @commentCount)

        procureProfileInformation: ->
                displayUuid       = Meteor.uuid()
                idUuid            = Meteor.uuid()
                bioUuid           = Meteor.uuid()
                fullNameUuid      = Meteor.uuid()
                url               = "https://api.instagram.com/v1/users/self/?access_token=#{Meteor.call('retrieveInstagramToken')}"
                instagramResponse = HTTP.get(url)
                userObject        = JSON.parse(instagramResponse['content'])
                userName          = userObject['data']['username']
                userId            = userObject['data']['id']
                bio               = userObject['data']['bio']
                fullName          = userObject['data']['full_name']

                clipsDisplayLineString       = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{displayUuid})(service-name #{@IQ}instagram#{@IQ})(account-name #{@IQ}#{userName}#{@IQ})(raw-url #{@IQ}http://instagram.com/#{@sanitize(decodeURIComponent(userName))}#{@IQ})(raw-post #{@IQ}#{@sanitize(userName)}#{@IQ}))#{@OQ})"
                clipsIdLineString            = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{idUuid})(service-name #{@IQ}instagram#{@IQ})(account-name #{@IQ}#{userId}#{@IQ})(raw-url #{@IQ}http://instagram.com/#{@sanitize(decodeURIComponent(userName))}#{@IQ})(raw-post #{@IQ}#{@sanitize(userId)}#{@IQ}))#{@OQ})"
                prologDisplayLineString      = "'(prolog . #{@OQ}add_profile_display_name(#{@IQ}instagram#{@IQ},#{@IQ}#{@sanitize(userName)}#{@IQ})#{@OQ})"
                prologIdLineString           = "'(prolog . #{@OQ}add_profile_user_id(#{@IQ}instagram#{@IQ},#{@IQ}#{@sanitize(userId)}#{@IQ})#{@OQ})"
                prologDisplayPostLineString  = "'(prolog . #{@OQ}process_post('#{displayUuid}',#{@IQ}#{@sanitize(userName)}#{@IQ})#{@OQ})"
                prologIdPostLineString       = "'(prolog . #{@OQ}process_post('#{idUuid}',#{@IQ}#{@sanitize(userId)}#{@IQ})#{@OQ})"

                clipsBioLineString           = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{bioUuid})(service-name #{@IQ}instagram#{@IQ})(account-name #{@IQ}#{userName}#{@IQ})(raw-url #{@IQ}http://instagram.com/#{@sanitize(decodeURIComponent(userName))}#{@IQ})(raw-post #{@IQ}#{@sanitize(bio)}#{@IQ}))#{@OQ})"
                clipsFullNameLineString      = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{fullNameUuid})(service-name #{@IQ}instagram#{@IQ})(account-name #{@IQ}#{userName}#{@IQ})(raw-url #{@IQ}http://instagram.com/#{@sanitize(decodeURIComponent(userName))}#{@IQ})(raw-post #{@IQ}#{@sanitize(fullName)}#{@IQ}))#{@OQ})"
                prologBioPostLineString      = "'(prolog . #{@OQ}process_post('#{bioUuid}',#{@IQ}#{@sanitize(bio)}#{@IQ})#{@OQ})"
                prologFullNamePostLineString = "'(prolog . #{@OQ}process_post('#{idUuid}',#{@IQ}#{@sanitize(fullName)}#{@IQ})#{@OQ})"

                @addPostProcessingClipsLine(clipsDisplayLineString)
                @addPostProcessingClipsLine(clipsIdLineString)
                @addPostProcessingPrologProfileDisplayLine(prologDisplayLineString)
                @addPostProcessingPrologProfileUserIdLine(prologIdLineString)
                @addPostProcessingPrologProcessPostLine(prologDisplayPostLineString)
                @addPostProcessingPrologProcessPostLine(prologIdPostLineString)
                @addPostProcessingClipsLine(clipsBioLineString)
                @addPostProcessingClipsLine(clipsFullNameLineString)
                @addPostProcessingPrologProcessPostLine(prologBioPostLineString)
                @addPostProcessingPrologProcessPostLine(prologFullNamePostLineString)

                #
                @debugLog(clipsDisplayLineString)
                @debugLog(clipsIdLineString)
                @debugLog(prologDisplayLineString)
                @debugLog(prologIdLineString)
                @debugLog(prologDisplayPostLineString)
                @debugLog(prologIdPostLineString)
                @debugLog(clipsBioLineString)
                @debugLog(clipsFullNameLineString)
                @debugLog(prologBioPostLineString)
                @debugLog(prologFullNamePostLineString)
                #

                @addServiceDetail("user-name", userName)
                @addServiceDetail("full-name", fullName)
                @addServiceDetail("bio", bio)
                
        procureRecentMedia: ->
                @procureMedia("https://api.instagram.com/v1/users/self/media/recent/?access_token=#{Meteor.call('retrieveInstagramToken')}")

        procureLikedMedia: ->
                @procureMedia("https://api.instagram.com/v1/users/self/media/liked/?access_token=#{Meteor.call('retrieveInstagramToken')}")

        procureMedia: (url) ->                
                userNameUrl               = "https://api.instagram.com/v1/users/self/?access_token=#{Meteor.call('retrieveInstagramToken')}"
                userNameInstagramResponse = HTTP.get(userNameUrl)
                userNameObject            = JSON.parse(userNameInstagramResponse['content'])
                userName                  = userNameObject['data']['username']

                processor = (recentMediaObject) =>
                        for comment in recentMediaObject['comments']['data']
                                if comment['from']['username'] == userName
                                        uuid             = Meteor.uuid()
                                        clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}instagram#{@IQ})(account-name #{@IQ}#{userName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(recentMediaObject['link']))}#{@IQ})(raw-post #{@IQ}#{@sanitize(comment['text'])}#{@IQ}))#{@OQ})"
                                        prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(comment['text'])}#{@IQ})#{@OQ})"

                                        @addPostProcessingClipsLine(clipsLineString)
                                        @addPostProcessingPrologProcessPostLine(prologLineString)

                                        #
                                        @debugLog(clipsLineString)
                                        @debugLog(prologLineString)
                                        #

                                        @commentCount += 0
                                        
                @internalProcure(url, processor)

        internalProcure: (url, processor) ->

                instagramResponse = HTTP.get(url)
                feedObjects       = JSON.parse(instagramResponse['content'])
                

                for feedObject in feedObjects['data']
                        processor(feedObject)

                if feedObjects['pagination']['next_url']?
                        url = feedObjects['pagination']['next_url']
                        @internalProcure(url, processor)
