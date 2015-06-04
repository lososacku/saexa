# Copyright 2015 Ryan B. Hicks


class YoutubeProcurer extends ProcurerBase
        constructor: (serviceName) ->
                @baseUrl     = "https://www.googleapis.com/youtube/v3"
                @channelId   = ""
                @channelName = ""

                @commentCount = 0
                @videoCount   = 0
                @channelCount = 0
                
                super(serviceName)

        procure: (analysisUuid) ->

                @analysisUuid = analysisUuid
                
#                @debugOutput = true

                authorizationString = "Bearer #{Meteor.call('retrieveGoogleToken')}"

                
                @procureChannelInformation(authorizationString)
                @procureCommentInformation(authorizationString)
                @procureVideoInformation(authorizationString)
                @addServiceDetail("comment-count", @commentCount)
                @addServiceDetail("video-count", @videoCount)
                @addServiceDetail("channel-count", @channelCount)

        procureChannelInformation: (authorizationString) ->
                endpoint         = "/channels"
                part             = "snippet,contentDetails,id"
                urlWithBaseQuery = "#{@baseUrl}#{endpoint}?mine=true&part=#{part}&maxResults=50"

                processor = (channelsObject) =>
                        displayUuid  = Meteor.uuid()
                        idUuid       = Meteor.uuid()
                        @channelName = channelsObject['snippet']['title']
                        @channelId   = channelsObject['id']


                        if @channelName is not ""

                                clipsDisplayLineString      = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{displayUuid})(service-name #{@IQ}youtube#{@IQ})(account-name #{@IQ}#{@channelName}#{@IQ})(raw-url #{@IQ}https://www.youtube.com/channel/#{@sanitize(decodeURIComponent(@channelId))}#{@IQ})(raw-post #{@IQ}#{@sanitize(@channelName)}#{@IQ}))#{@OQ})"
                                clipsIdLineString           = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{idUuid})(service-name #{@IQ}youtube#{@IQ})(account-name #{@IQ}#{@channelId}#{@IQ})(raw-url #{@IQ}https://www.youtube.com/channel/#{@sanitize(decodeURIComponent(@channelId))}#{@IQ})(raw-post #{@IQ}#{@sanitize(@channelId)}#{@IQ}))#{@OQ})"
                                prologDisplayLineString     = "'(prolog . #{@OQ}add_profile_display_name(#{@IQ}youtube#{@IQ},#{@IQ}#{@sanitize(@channelName)}#{@IQ})#{@OQ})"
                                prologIdLineString          = "'(prolog . #{@OQ}add_profile_user_id(#{@IQ}youtube#{@IQ},#{@IQ}#{@sanitize(@channelId)}#{@IQ})#{@OQ})"
                                prologDisplayPostLineString = "'(prolog . #{@OQ}process_post('#{displayUuid}',#{@IQ}#{@sanitize(@channelName)}#{@IQ})#{@OQ})"
                                prologIdPostLineString      = "'(prolog . #{@OQ}process_post('#{idUuid}',#{@IQ}#{@sanitize(@channelId)}#{@IQ})#{@OQ})"

                                @addPostProcessingClipsLine(clipsDisplayLineString)
                                @addPostProcessingClipsLine(clipsIdLineString)
                                @addPostProcessingPrologProfileDisplayLine(prologDisplayLineString)
                                @addPostProcessingPrologProfileUserIdLine(prologIdLineString)
                                @addPostProcessingPrologProcessPostLine(prologDisplayPostLineString)
                                @addPostProcessingPrologProcessPostLine(prologIdPostLineString)
                        

                                #
                                @debugLog(clipsDisplayLineString)
                                @debugLog(clipsIdLineString)
                                @debugLog(prologDisplayLineString)
                                @debugLog(prologIdLineString)
                                @debugLog(prologDisplayPostLineString)
                                @debugLog(prologIdPostLineString)
                                #

                                @addServiceDetail("channel-name", @channelName)
                                @channelCount += 1
                                                
                @internalProcure(urlWithBaseQuery, urlWithBaseQuery, authorizationString, processor)
                
        procureCommentInformation: (authorizationString) ->
                endpoint         = "/commentThreads"
                part             = "snippet"
                urlWithBaseQuery = "#{@baseUrl}#{endpoint}?part=#{part}&allThreadsRelatedToChannelId=#{@channelId}&maxResults=50"


                topLevelCommentProcessor = (topLevelCommentsObject) =>
                        endpoint         = "/comments"
                        part             = "snippet"
                        parentId         = topLevelCommentsObject["snippet"]["topLevelComment"]["id"]
                        urlWithBaseQuery = "#{@baseUrl}#{endpoint}?part=#{part}&parentId=#{parentId}&textFormat=plainText&maxResults=50"
                        videoId          = topLevelCommentsObject["snippet"]["videoId"]
                        content          = topLevelCommentsObject["snippet"]["topLevelComment"]["snippet"]["textDisplay"]


                        if videoId?
                                rawUrl = "https://www.youtube.com/all_comments?v=#{videoId}"
                        else
                                rawUrl = "https://www.youtube.com/user/#{@channelName}/discussion"
                                
                        @processComment(rawUrl, content)

                        replyCommentProcessor = (replyCommentObject) =>
                                content = replyCommentObject["snippet"]["textDisplay"].replace("+" + @channelName + " ", "")


                                @processComment(rawUrl, content)
                        
                        @internalProcure(urlWithBaseQuery, urlWithBaseQuery, authorizationString, replyCommentProcessor)
                                
                @internalProcure(urlWithBaseQuery, urlWithBaseQuery, authorizationString, topLevelCommentProcessor)
                
        procureVideoInformation: (authorizationString) ->
                endpoint         = "/activities"
                part             = "snippet,contentDetails,id"
                urlWithBaseQuery = "#{@baseUrl}#{endpoint}?mine=true&part=#{part}&maxResults=50"

                processor = (activitiesObject) =>
                        if activitiesObject['snippet']['type'] == 'upload'
                                videoIdUuid                            = Meteor.uuid()
                                videoTitleUuid                         = Meteor.uuid()
                                channelName                            = activitiesObject['snippet']['channelTitle']
                                channelName                            = activitiesObject['snippet']['channelTitle']
                                videoId                                = activitiesObject['contentDetails']['upload']['videoId']
                                videoTitle                             = activitiesObject['snippet']['title']

                                clipsVideoIdLineString                 = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{videoIdUuid})(service-name #{@IQ}youtube#{@IQ})(account-name #{@IQ}#{channelName}#{@IQ})(raw-url #{@IQ}https://www.youtube.com/watch?v=#{@sanitize(decodeURIComponent(videoId))}#{@IQ})(raw-post #{@IQ}#{@sanitize(videoId)}#{@IQ}))#{@OQ})"
                                clipsVideoTitleLineString              = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{videoTitleUuid})(service-name #{@IQ}youtube#{@IQ})(account-name #{@IQ}#{channelName}#{@IQ})(raw-url #{@IQ}https://www.youtube.com/watch?v=#{@sanitize(decodeURIComponent(videoId))}#{@IQ})(raw-post #{@IQ}#{@sanitize(videoTitle)}#{@IQ}))#{@OQ})"
                                prologVideoIdLineString                = "'(prolog . #{@OQ}add_youtube_video_info(#{@IQ}youtube-video-id#{@IQ},#{@IQ}#{@sanitize(videoId)}#{@IQ})#{@OQ})"
                                prologVideoTitleLineString             = "'(prolog . #{@OQ}add_youtube_video_info(#{@IQ}youtube-video-title#{@IQ},#{@IQ}#{@sanitize(videoTitle)}#{@IQ})#{@OQ})"
                                prologVideoIdCataloguedLineString      = "'(prolog . #{@OQ}add_catalogued_constituent(#{@IQ}youtube#{@IQ},#{@IQ}youtube-video-info#{@IQ},#{@IQ}#{@sanitize(videoId)}#{@IQ})#{@OQ})"
                                prologVideoTitleCataloguedLineString   = "'(prolog . #{@OQ}add_catalogued_constituent(#{@IQ}youtube#{@IQ},#{@IQ}youtube-video-info#{@IQ},#{@IQ}#{@sanitize(videoTitle)}#{@IQ})#{@OQ})"
                                prologVideoIdPostLineString            = "'(prolog . #{@OQ}process_post('#{videoIdUuid}',#{@IQ}#{@sanitize(videoId)}#{@IQ})#{@OQ})"
                                prologVideoTileLineString              = "'(prolog . #{@OQ}process_post('#{videoTitleUuid}',#{@IQ}#{@sanitize(videoTitle)}#{@IQ})#{@OQ})"

                                @addPostProcessingClipsLine(clipsVideoIdLineString)
                                @addPostProcessingClipsLine(clipsVideoTitleLineString)
                                @addPostProcessingPrologProfileYoutubeVideoInfoLine(prologVideoIdLineString)
                                @addPostProcessingPrologProfileYoutubeVideoInfoLine(prologVideoTitleLineString)
                                @addPostProcessingPrologCatalogueLine(prologVideoIdCataloguedLineString)
                                @addPostProcessingPrologCatalogueLine(prologVideoTitleCataloguedLineString)
                                @addPostProcessingPrologProcessPostLine(prologVideoIdPostLineString)
                                @addPostProcessingPrologProcessPostLine(prologVideoTileLineString)

                                #
                                @debugLog(clipsVideoIdLineString)
                                @debugLog(clipsVideoTitleLineString)
                                @debugLog(prologVideoIdLineString)
                                @debugLog(prologVideoTitleLineString)
                                @debugLog(prologVideoIdCataloguedLineString)
                                @debugLog(prologVideoTitleCataloguedLineString)
                                @debugLog(prologVideoIdPostLineString)
                                @debugLog(prologVideoTileLineString)
                                #

                                @addServiceDetail("video-title", videoTitle)
                                @videoCount += 1

                @internalProcure(urlWithBaseQuery, urlWithBaseQuery, authorizationString, processor)

        internalProcure: (url, urlWithBaseQuery, authorizationString, processor) ->

                youtubeResponse   = HTTP.get(url, {headers:{Authorization: "#{authorizationString}"}})
                youtubeApiObjects = JSON.parse(youtubeResponse['content'])

                for youtubeApiObject in youtubeApiObjects['items']
                        processor(youtubeApiObject)

                if youtubeApiObjects['nextPageToken']? and youtubeApiObjects['nextPageToken'] is not ''
                        url = "#{urlWithBaseQuery}&pageToken=#{youtubeApiObjects['nextPageToken']}"
                                
                        @internalProcure(url, urlWithBaseQuery, authorizationString, processor)

        processComment: (rawUrl, content) ->
                uuid             = Meteor.uuid()
                clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}youtube#{@IQ})(account-name #{@IQ}#{@channelName}#{@IQ})(raw-url #{@IQ}#{@sanitize(rawUrl)}#{@IQ})(raw-post #{@IQ}#{@sanitize(content)}#{@IQ}))#{@OQ})"
                prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(content)}#{@IQ})#{@OQ})"
                                

                @addPostProcessingClipsLine(clipsLineString)
                @addPostProcessingPrologProcessPostLine(prologLineString)

                #
                @debugLog(clipsLineString)
                @debugLog(prologLineString)
                #

                @commentCount += 1
