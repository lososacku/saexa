# Copyright 2015 Ryan B. Hicks

class TwitterProcurer extends ProcurerBase

        constructor: (serviceName) ->
                @retrieveCount   = 200
                @baseUrl         = 'https://api.twitter.com/1.1/'
                @endpoint        = 'statuses/user_timeline.json'
                @queryStringBase = "?count=#{@retrieveCount}&include_rts=1"

                @tweetCount = 0

                super(serviceName)
        
        # 'decrementHugeNumberBy1' ported to CoffeeScript from here:
        # http://stackoverflow.com/questions/9717488/using-since-id-and-max-id-in-twitter-api/14328420#14328420
        decrementHugeNumberBy1: (numberString) ->

                allButLast = numberString.substr(0, numberString.length - 1)
                lastNumber = numberString.substr(numberString.length - 1)

                if lastNumber == "0"
                        return @decrementHugeNumberBy1(allButLast) + "9"
                else
                        finalResult = allButLast + (parseInt(lastNumber, 10) - 1).toString()
                        return @trimLeft(finalResult, "0")

        # 'trimLeft' ported to CoffeeScript from here:
        # http://stackoverflow.com/questions/9717488/using-since-id-and-max-id-in-twitter-api/14328420#14328420
        trimLeft: (s, c) ->
        
                i = 0
                while i < s.length && s[i] == c
                        i++

                return s.substring(i)

        procure: (analysisUuid) ->

                @analysisUuid = analysisUuid
                
#                @debugOutput = true
                
                # oauth handling ported from TwitterApi atomosphere package
                twitterUserConfig = Accounts.loginServiceConfiguration.findOne({service: 'twitter'})
                twitterOauthUrls  = { requestToken: "https://api.twitter.com/oauth/request_token", authorize: "https://api.twitter.com/oauth/authorize", accessToken: "https://api.twitter.com/oauth/access_token", authenticate: "https://api.twitter.com/oauth/authenticate" }
                oauthBinding      = new OAuth1Binding(twitterUserConfig, twitterOauthUrls)

                oauthBinding.accessToken       = Meteor.call("retrieveTwitterToken")
                oauthBinding.accessTokenSecret = Meteor.call("retrieveTwitterTokenSecret")

                url                = "#{@baseUrl}#{@endpoint}#{@queryStringBase}"
                maxTweetsRemaining = 3200  # the maximum number of tweets retrievable as per API
                userTimeline       = oauthBinding.call('GET', url)
                contentObject      = JSON.parse(userTimeline['content'])
                statusesCount      = contentObject[0]['user']['statuses_count']
                accountName        = contentObject[0]['user']['name']
                tweetsRemaining    = if statusesCount > 3200 then maxTweetsRemaining else statusesCount

                @processUserTimeline(userTimeline, accountName)
                
                tweetsRemaining -= @retrieveCount
                
                while tweetsRemaining > 0

                        idStr        = userTimeline['data'][userTimeline['data'].length - 1]['id_str']
                        maxIdStr     = @decrementHugeNumberBy1(idStr)
                        nextCallUrl  = "#{url}&max_id=#{maxIdStr}"

                        userTimeline = oauthBinding.call('GET', nextCallUrl)

                        @processUserinfo(accountName)
                        @processUserTimeline(userTimeline, accountName)
                          
                        tweetsRemaining -= @retrieveCount

                @addServiceDetail("tweet-count", @tweetCount)

        processUserinfo: (accountName) ->
                uuid                    = Meteor.uuid()
                clipsDisplayLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}twitter#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}https://twitter.com/#{@sanitize(decodeURIComponent(accountName))}#{@IQ})(raw-post #{@IQ}#{@sanitize(accountName)}#{@IQ}))#{@OQ})"
                prologDisplayLineString = "'(prolog . #{@OQ}add_profile_display_name(#{@IQ}twitter#{@IQ},#{@IQ}#{@sanitize(accountName)}#{@IQ})#{@OQ})"

                @addPostProcessingClipsLine(clipsDisplayLineString)
                @addPostProcessingPrologProfileDisplayLine(prologDisplayLineString)
                @addServiceDetail("account-name", accountName)
        
        processUserTimeline: (userTimeline, accountName) ->
                for tweet in userTimeline['data']                        
                        uuid             = Meteor.uuid()
                        clipsLineString  = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}twitter#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}https://twitter.com/#{@sanitize(decodeURIComponent(accountName))}/status/#{@sanitize(decodeURIComponent(tweet['id_str']))}#{@IQ})(raw-post #{@IQ}#{@sanitize(tweet['text'])}#{@IQ}))#{@OQ})"
                        prologLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(tweet['text'])}#{@IQ})#{@OQ})"
                        #
                        @debugLog(clipsLineString)
                        @debugLog(prologLineString)
                        #
                        @addPostProcessingClipsLine(clipsLineString)
                        @addPostProcessingPrologProcessPostLine(prologLineString)

                        @tweetCount += 1


