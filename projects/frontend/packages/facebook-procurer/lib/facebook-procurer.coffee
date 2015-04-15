# Copyright 2015 Ryan B. Hicks

## taken and modified from the Facebook Collections Atomosphere package
##


################################################################################
#############################external api#######################################
################################################################################

class FacebookProcurer extends ProcurerBase

        constructor: (serviceName) ->
                @messageCount  = 0
                @categoryCount = 0
                @nameCount     = 0
                super(serviceName)

        procure: (analysisUuid) ->

                @analysisUuid = analysisUuid

#                @debugOutput = true
                
                @procureFacebookUserInformation()
                @procureFacebookContents()
                @addServiceDetail("message-count", @messageCount)
                @addServiceDetail("category-count", @categoryCount)
                @addServiceDetail("name-count", @nameCount)

        procureFacebookContents: ->

                contentEndpoints = [
                        '/statuses',
                        '/interests',
                        '/likes',
                        '/activities',
                        '/music',
                        '/books',
                        '/movies',
                        '/games',
                        '/events',
#                        '/tagged_places',
                        '/posts',
                        '/groups',
                        '/family'
                ]

                for contentEndpoint in contentEndpoints

                        contents = @getGraphContent(contentEndpoint, 'me').find()

                        # TODO
                        # add handling for likes and comments later (needs CLIPS integration)
                        contents.forEach((content) =>

                                uuid        = Meteor.uuid()
                                accountName = Meteor.call('retrieveFacebookUserName')
                                link        = if content['link']? then content['link'] else "https://www.facebook.com/home.php"


                                if      content['message']?
                                        clipsLineString             = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}facebook#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(link))}#{@IQ})(raw-post #{@IQ}#{@sanitize(content['message'])}#{@IQ}))#{@OQ})"
                                        prologProcessPostLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(content['message'])}#{@IQ})#{@OQ})"

                                        @addPostProcessingClipsLine(clipsLineString)
                                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                                        #
                                        @debugLog(clipsLineString)
                                        @debugLog(prologProcessPostLineString)
                                        #

                                        @messageCount += 1

                                else if content['category']?
                                        clipsLineString             = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}facebook#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(link))}#{@IQ})(raw-post #{@IQ}#{@sanitize(content['name'])}#{@IQ}))#{@OQ})"
                                        prologCataloguedLineString  = "'(prolog . #{@OQ}add_catalogued_constituent(#{@IQ}facebook#{@IQ},#{@IQ}#{content['category']}#{@IQ},#{@IQ}#{@sanitize(content['name'])}#{@IQ})#{@OQ})"
                                        prologProcessPostLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(content['name'])}#{@IQ})#{@OQ})"

                                        @addPostProcessingClipsLine(clipsLineString)
                                        @addPostProcessingPrologCatalogueLine(prologCataloguedLineString)
                                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                                        #
                                        @debugLog(clipsLineString)
                                        @debugLog(prologCataloguedLineString)
                                        @debugLog(prologProcessPostLineString)
                                        #

                                        @categoryCount += 1
                                        @addServiceDetail("category", content['category'])
                                        @addServiceDetail(content['category'], content['name'])

                                # are there really cases where 'name' exists but 'category' dosen't?
                                else if content['name']?
                                        clipsLineString             = "'(clips . #{@OQ}(make-instance of POSTED-DATA-ITEM(uuid #{uuid})(service-name #{@IQ}facebook#{@IQ})(account-name #{@IQ}#{accountName}#{@IQ})(raw-url #{@IQ}#{@sanitize(decodeURIComponent(link))}#{@IQ})(raw-post #{@IQ}#{@sanitize(content['name'])}#{@IQ}))#{@OQ})"
                                        prologProcessPostLineString = "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(content['name'])}#{@IQ})#{@OQ})"

                                        @addPostProcessingClipsLine(clipsLineString)
                                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                                        #
                                        @debugLog(clipsLineString)
                                        @debugLog(prologProcessPostLineString)
                                        #

                                        @nameCount += 1
                                        @addServiceDetail("name", content['name'])
                        )                                                
                
        procureFacebookUserInformation: ->
            
            userInformation  = @getUserInformation('me').findOne()
            clipsString      = "'(clips . #{@OQ}(make-instance of FACEBOOK-USER"


            if userInformation.hasOwnProperty('id')
                uuid                        = Meteor.uuid()
                clipsString                 += "(user-id #{@IQ}#{userInformation['id']}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_user_id(#{@IQ}#{@sanitize(userInformation['id'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['id'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("id", userInformation['id'])

            if userInformation.hasOwnProperty('name')
                uuid                        = Meteor.uuid()
                clipsString                 += "(name-string #{@IQ}#{userInformation['name']}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_name_string(#{@IQ}#{@sanitize(userInformation['name'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['name'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("name-string", userInformation['name'])

            if userInformation.hasOwnProperty('first_name')
                uuid                        = Meteor.uuid()
                clipsString                 += "(first-name #{@IQ}#{userInformation['first_name']}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_first_name(#{@IQ}#{@sanitize(userInformation['first_name'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['first_name'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("first-name", userInformation['first_name'])

            if userInformation.hasOwnProperty('middle_name')
                uuid                        = Meteor.uuid()
                clipsString                 += "(middle-name #{@IQ}#{userInformation['middle_name']}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_middle_name(#{@IQ}#{@sanitize(userInformation['middle_name'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['middle_name'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("middle-name", userInformation['middle_name'])

            if userInformation.hasOwnProperty('last_name')
                uuid                        = Meteor.uuid()
                clipsString                 += "(last-name #{@IQ}#{userInformation['last_name']}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_last_name(#{@IQ}#{@sanitize(userInformation['last_name'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['last_name'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("last-name", userInformation['last_name'])

            if userInformation.hasOwnProperty('link')
                uuid                        = Meteor.uuid()
                clipsString                 += "(profile-url #{@IQ}#{@sanitize(userInformation['link'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_profile_url(#{@IQ}#{@sanitize(userInformation['link'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['link'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #
                
                @addServiceDetail("profile-url", userInformation['link'])

            if userInformation.hasOwnProperty('username')
                uuid                        = Meteor.uuid()
                clipsString                 += "(user-name #{@IQ}#{@sanitize(userInformation['username'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_user_name(#{@IQ}#{@sanitize(userInformation['username'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['username'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("username", userInformation['username'])

            if userInformation.hasOwnProperty('birthday')
                uuid                        = Meteor.uuid()
                clipsString                 += "(birthday-string #{@IQ}#{@sanitize(userInformation['birthday'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_birthday_string(#{@IQ}#{@sanitize(userInformation['birthday'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['birthday'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("birthday", userInformation['birthday'])

            if userInformation.hasOwnProperty('email')
                uuid                        = Meteor.uuid()
                clipsString                 += "(email-address #{@IQ}#{@sanitize(userInformation['email'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_email_address(#{@IQ}#{@sanitize(userInformation['email'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['email'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("email", userInformation['email'])

            if userInformation.hasOwnProperty('gender')
                uuid                        = Meteor.uuid()
                clipsString                 += "(gender #{@IQ}#{@sanitize(userInformation['gender'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_gender(#{@IQ}#{@sanitize(userInformation['gender'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['gender'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("gender", userInformation['gender'])

            if userInformation.hasOwnProperty('relationship_status')
                uuid                        = Meteor.uuid()
                clipsString                 += "(relationship-status #{@IQ}#{@sanitize(userInformation['relationship_status'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_relationship_status(#{@IQ}#{@sanitize(userInformation['relationship_status'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['relationship_status'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("relationship_status", userInformation['relationship_status'])

            if userInformation.hasOwnProperty('locale')
                uuid                        = Meteor.uuid()
                clipsString                 += "(locale #{@IQ}#{@sanitize(userInformation['locale'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_locale(#{@IQ}#{@sanitize(userInformation['locale'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['locale'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("locale", userInformation['locale'])

            if userInformation.hasOwnProperty('timezone')
                uuid                        = Meteor.uuid()
                clipsString                 += "(timezone #{@IQ}#{@sanitize(userInformation['timezone'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_timezone(#{@IQ}#{@sanitize(userInformation['timezone'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['timezone'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #
                
                @addServiceDetail("timezone", userInformation['timezone'])

            if userInformation.hasOwnProperty('hometown')
                uuid                        = Meteor.uuid()
                clipsString                 += "(hometown #{@IQ}#{@sanitize(userInformation['hometown']['name'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_hometown(#{@IQ}#{@sanitize(userInformation['hometown']['name'])}#{@IQ},#{@IQ}#{@sanitize(userInformation['hometown']['id'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['hometown'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("hometown", userInformation['hometown']['name'])

            if userInformation.hasOwnProperty('location')
                uuid                        = Meteor.uuid()
                clipsString                 += "(location #{@IQ}#{@sanitize(userInformation['location']['name'])}#{@IQ})"
                prologFacebookLineString    =  "'(prolog . #{@OQ}add_facebook_location(#{@IQ}#{@sanitize(userInformation['location']['name'])}#{@IQ},#{@IQ}#{@sanitize(userInformation['location']['id'])}#{@IQ})#{@OQ})"
                prologProcessPostLineString =  "'(prolog . #{@OQ}process_post('#{uuid}',#{@IQ}#{@sanitize(userInformation['location'])}#{@IQ})#{@OQ})"
                @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                @addPostProcessingPrologProcessPostLine(prologProcessPostLineString)

                #
                @debugLog(prologFacebookLineString)
                @debugLog(prologProcessPostLineString)
                #

                @addServiceDetail("location", userInformation['location']['name'])

            if userInformation.hasOwnProperty('education')
                    
                for item in userInformation['education']

                    if item['type'] == 'High School'

                        prologLineString = ""

                        uuid0                        = Meteor.uuid()
                        uuid1                        = Meteor.uuid()
                        clipsString                  += "(high-school #{@IQ}#{@sanitize(item['school']['name'])}#{@IQ})"
                        prologFacebookLineString     =  "'(prolog . #{@OQ}add_facebook_highschool(#{@IQ}#{item['school']['name']}#{@IQ},#{@IQ}#{item['school']['id']}#{@IQ})#{@OQ})"
                        prologProcessPostLineString0 =  "'(prolog . #{@OQ}process_post('#{uuid0}',#{@IQ}#{@sanitize(item['school']['name'])}#{@IQ})#{@OQ})"
                        prologProcessPostLineString1 =  "'(prolog . #{@OQ}process_post('#{uuid1}',#{@IQ}#{@sanitize(item['school']['id'])}#{@IQ})#{@OQ})"
                        @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString0)
                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString1)

                        #
                        @debugLog(prologFacebookLineString)
                        @debugLog(prologProcessPostLineString0)
                        @debugLog(prologProcessPostLineString1)
                        #
                        
                        @addServiceDetail("high-school", item['school']['name'])

                        prologLineString = ""

                        uuid0                        = Meteor.uuid()
                        uuid1                        = Meteor.uuid()
                        clipsString                  += "(high-school-class #{@IQ}#{@sanitize(item['year']['name'])}#{@IQ})"
                        prologFacebookLineString     =  "'(prolog . #{@OQ}add_facebook_highschool_class(#{@IQ}#{item['year']['name']}#{@IQ},#{@IQ}#{item['year']['id']}#{@IQ})#{@OQ})"
                        prologProcessPostLineString0 =  "'(prolog . #{@OQ}process_post('#{uuid0}',#{@IQ}#{@sanitize(item['school']['name'])}#{@IQ})#{@OQ})"
                        prologProcessPostLineString1 =  "'(prolog . #{@OQ}process_post('#{uuid1}',#{@IQ}#{@sanitize(item['school']['id'])}#{@IQ})#{@OQ})"
                        @addPostProcessingPrologFacebookLine(prologFacebookLineString)
                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString0)
                        @addPostProcessingPrologProcessPostLine(prologProcessPostLineString1)

                        #
                        @debugLog(prologFacebookLineString)
                        @debugLog(prologProcessPostLineString0)
                        @debugLog(prologProcessPostLineString1)
                        #

                        @addServiceDetail("high-school-class", item['year']['name'])

                    ## else do something else in the future...right now just high school

            clipsString += ")#{@OQ})"

            @addPostProcessingClipsLine(clipsString)

################################################################################
#############################internal api#######################################
################################################################################
    
        _syncGet: (query, collection, count, retries, maxItems) ->
                
                response = HTTP.get(query)

                if response

                        if typeof response.data.data == 'undefined'

                                collection.insert(response.data)
                        else
                                items  = response.data.data
                                paging = response.data.paging


                                for doc in items
                                        collection.insert(doc)                        

                                count += items.length
                                
                                if count<maxItems && paging && paging.next
                                        retries = 0
                                        @_syncGet(paging.next, collection, count, retries, maxItems)

                else if (retries<3)
                        
                        retries+=1
                        
                        console.log("FB: ",error)
                        
                        @_syncGet(query, collection, count, retries, maxItems)
                else
                        
                        console.log("FB: Max tries exceeded")

    ## Manually call the Facebook Graph with correct domain and access_token
    ## Throw an error if the user is not authenticated, or doesn't have a facebook username
    ## @query: A path on the facebook graph "/posts?fields=id,source"
    ## @callback: A function to be called like callback(error,response)
        _get: (query, collection, count, retries, maxItems) ->
                
                domain = "https://graph.facebook.com/"
                user   = Meteor.user()

                
                # if !user
                #         throw "User is not logged in"
                        
                # else if !user.services.facebook
                #         throw "User does not have a Facebook account"

                # else if !user.services.facebook.accessToken
                        
                #         throw "User does not have an accessToken"


                ## Add the domain to the request 
                if query.indexOf(domain)==-1

                        query = domain + query.trim("/")

                ## Add accessToken to request
                if query.indexOf("?")>-1
                        
                        #query = query + "&access_token="+user.services.facebook.accessToken
                        query = query + "&access_token="+Meteor.call("retrieveFacebookToken")
              
                else
                        
                        #query = query + "?access_token="+user.services.facebook.accessToken
                        query = query + "?access_token="+Meteor.call("retrieveFacebookToken")
                        

                @_syncGet(query, collection, count, retries, maxItems)

    ## Return a Meteor.Collection object that will be filled with the results of @query
    ## Request @query repetitively until there a @maxItems in the collection 
    ## @query: A path on the facebook graph like "/posts?fields=id,source"
        _getCollection: (query,maxItems) ->

                collection = new Meteor.Collection(null)
                retries    = 0
                count      = 0

    
                @_get(query, collection, count, retries, maxItems)

                collection

    ## Wrapper for @_getCollection that handles default values
    ## @path: A path on the facebook graph like "/me/posts/"
    ## @fields(optional): A list of fields to be requested
    ## @maxItems(optional): The maximum number of posts to be added to the collection
        getCollection: (path,fields,maxItems) ->

                if _.isNumber(fields)
                    
                        maxItems = fields
                        fields   = []
                else
                        maxItems = maxItems || 500
                        fields   = fields || []

                limit = Math.max(Math.ceil(maxItems/5),25)
                query = path + "?fields="+fields.join(",") + "&limit="+limit
                @_getCollection(query,maxItems)

        ## generalized interface based on the originals below
        getGraphContent: (graph, user, fields, maxItems) -> @getCollection(user+graph,fields,maxItems)

    ## Return an empty collection that will be filled with Facebook posts
    ## @username: The page to request post from, can be 'me'
    ## @fields: A list of fields to be requested
    ## @maxItems: The maximum number of posts to be added to the collection
        getUserInformation: (user,fields,maxItems) -> @getCollection(user,fields,maxItems)

    ## Return an empty collection that will be filled with Facebook posts
    ## @username: The page to request post from, can be 'me'
    ## @fields: A list of fields to be requested
    ## @maxItems: The maximum number of posts to be added to the collection
        getPosts: (user,fields,maxItems) -> @getCollection(user+"/posts",fields,maxItems)

    ## Return an empty collection that will be filled with Facebook friends
    ## @username: The user to list post from. Can be 'me'
    ## @fields: A list of fields to be requested
    ## @maxItems: The maximum number of posts to be added to the collection
        getFriends: (user,fields,maxItems) -> @getCollection(user+"/friends",fields,maxItems)

    ## Return an empty collection that will be filled with Facebook photos
    ## @username: The user to list post from. Can be 'me'
    ## @fields: A list of fields to be requested
    ## @maxItems: The maximum number of posts to be added to the collection
        getPhotos: (user,fields,maxItems) -> @getCollection(user+"/photos",fields,maxItems)
