# Copyright 2015 Ryan B. Hicks

class TumblrProcurer extends ProcurerBase

        constructor: (serviceName) ->

                @blogPostCount = 0
                
                super(serviceName)
                
        procure: (analysisUuid) ->

                @analysisUuid = analysisUuid

                @procureBlogPosts()
                @procureBlogInfo()

                @addServiceDetail("blog-post-count", @blogPostCount)

        procureBlogInfo: ->

                retrieveCount     = 20
                accountName       = Meteor.call("retrieveTumblrUserName")
                baseServiceUrl    = "https://api.tumblr.com/v2/blog/#{accountName}.tumblr.com/"
                baseRequestUrl    = "info"
                requestParameters = "?limit=#{retrieveCount}&filter=text&type=text&api_key=zDNn7kh3PxRrVCyZ7PRn6CLnCVguNGnVMLdNeKaYdAmXoshML8"
                url               = "#{baseServiceUrl}#{baseRequestUrl}#{requestParameters}"


                tumblrResponse = HTTP.get(url)

                contentObject = JSON.parse(tumblrResponse['content'])

                @processBlogInfo(contentObject['response']['blog'], accountName)
                
        processBlogInfo: (blogInfo, accountName, baseServiceUrl) ->

                uuid             = Meteor.uuid()
                prologLineString = "'(prolog . #{@OQ}add_profile_login_and_display_name(#{@IQ}tumblr#{@IQ},#{@IQ}#{@sanitize(blogInfo['name'])}#{@IQ},#{@IQ}#{@sanitize(blogInfo['title'])}#{@IQ})#{@OQ})"


                @addPostProcessingPrologProfileLoginDisplayLine(prologLineString)
                @addServiceDetail("blog-name", blogInfo['name'])
                @addServiceDetail("blog-title", blogInfo['title'])

                ## all architecture, analysis, and reports are post driven. i.e., any information
                ## on the 'net is thought of, and treated, being "posted". this includes service
                ## and account data even though that data is also handled separately here. in order
                ## to keep everything consistent and working there needs to be a post generated for
                ## the profile data. so do that here for each item.
                # 
                uuid             = Meteor.uuid()
                clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}tumblr#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(baseServiceUrl))}#{@IQ})(raw-post #{@IQ}#{@sanitize(blogInfo['name'])}#{@IQ}))#{@OQ})"
                prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(blogInfo['name'])}#{@IQ})#{@OQ})"
                #
                @debugLog(clipsLineString)
                @debugLog(prologLineString)
                #
                @addPostProcessingClipsLine(clipsLineString)
                @addPostProcessingPrologProcessPostLine(prologLineString)

                uuid             = Meteor.uuid()
                clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}tumblr#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(baseServiceUrl))}#{@IQ})(raw-post #{@IQ}#{@sanitize(blogInfo['title'])}#{@IQ}))#{@OQ})"
                prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(blogInfo['title'])}#{@IQ})#{@OQ})"


                @addPostProcessingClipsLine(clipsLineString)
                @addPostProcessingPrologProcessPostLine(prologLineString)

        procureBlogPosts: ->

                retrieveCount     = 20
                totalPosts        = 0
                postsRemaining    = 0
                currentPostOffset = 0
                accountName       = Meteor.call("retrieveTumblrUserName")
                baseServiceUrl    = "https://api.tumblr.com/v2/blog/#{accountName}.tumblr.com/"
                baseRequestUrl    = "posts/text"
                requestParameters = "?limit=#{retrieveCount}&filter=text&type=text&api_key=zDNn7kh3PxRrVCyZ7PRn6CLnCVguNGnVMLdNeKaYdAmXoshML8"                
                url               = "#{baseServiceUrl}#{baseRequestUrl}#{requestParameters}&offset=#{currentPostOffset}"

                tumblrResponse = HTTP.get(url)

                @processBlogPosts(tumblrResponse['data']['response']['posts'], accountName)
                
                totalPosts        =  tumblrResponse['data']['response']['total_posts']
                postsRemaining    =  totalPosts - retrieveCount
                currentPostOffset += retrieveCount

                while postsRemaining > 0

                        url = "#{baseServiceUrl}#{baseRequestUrl}#{requestParameters}&offset=#{currentPostOffset}"

                        tumblrResponse = HTTP.get(url)

                        @processBlogPosts(tumblrResponse['data']['response']['posts'], accountName)

                        postsRemaining    -= retrieveCount
                        currentPostOffset += retrieveCount

        processBlogPosts: (blogPosts, accountName) ->

                for blogPost in blogPosts
                        
                        uuid             = Meteor.uuid()
                        clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}tumblr#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(blogPost['post_url']))}#{@IQ})(raw-post #{@IQ}#{@sanitize(blogPost['body'])}#{@IQ}))#{@OQ})"
                        prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(blogPost['body'])}#{@IQ})#{@OQ})"


                        @addPostProcessingClipsLine(clipsLineString)
                        @addPostProcessingPrologProcessPostLine(prologLineString)

                        @blogPostCount += 1
                    
        
