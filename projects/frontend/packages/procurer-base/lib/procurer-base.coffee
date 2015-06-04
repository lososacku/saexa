# Copyright 2015 Ryan B. Hicks

# functions common to all procurers

class ProcurerBase

        constructor: (serviceName) ->
            @analysisUuid = ""
            @serviceName  = serviceName

            @postProcessingClipsLines                  = ""
            @postProcessingPrologFacebookLines         = ""
            @postProcessingPrologCatalogueLines        = ""
            @postProcessingPrologLoginDisplayLines     = ""
            @postProcessingPrologDisplayLines          = ""
            @postProcessingPrologUserIdLines           = ""
            @postProcessingPrologYoutubeVideoInfoLines = ""
            @postProcessingPrologProcessPostLines      = ""

            @serviceDetailsList = ""

            @OQ = ">{OQ}<"
            @IQ = ">{IQ}<"

            @debugOutput = false

        addPostProcessingClipsLine: (postProcessingClipsLine) ->
                @postProcessingClipsLines += postProcessingClipsLine + "\n"

        addPostProcessingPrologFacebookLine: (postProcessingPrologFacebookLine) ->
                @postProcessingPrologFacebookLines += postProcessingPrologFacebookLine + "\n"

        addPostProcessingPrologCatalogueLine: (postProcessingPrologCatalogueLine) ->
                @postProcessingPrologCatalogueLines += postProcessingPrologCatalogueLine + "\n"

        addPostProcessingPrologProfileLoginDisplayLine: (postProcessingPrologLoginDisplayLine) ->
                @postProcessingPrologLoginDisplayLines += postProcessingPrologLoginDisplayLine + "\n"

        addPostProcessingPrologProfileDisplayLine: (postProcessingPrologDisplayLine) ->
                @postProcessingPrologDisplayLines += postProcessingPrologDisplayLine + "\n"

        addPostProcessingPrologProfileUserIdLine: (postProcessingPrologUserIdLine) ->
                @postProcessingPrologUserIdLines += postProcessingPrologUserIdLine + "\n"

        addPostProcessingPrologProfileYoutubeVideoInfoLine: (postProcessingPrologYoutubeVideoInfoLine) ->
                @postProcessingPrologYoutubeVideoInfoLines += postProcessingPrologYoutubeVideoInfoLine + "\n"

        addPostProcessingPrologProcessPostLine: (postProcessingPrologProcessPostLine) ->
                @postProcessingPrologProcessPostLines += postProcessingPrologProcessPostLine + "\n"
                
        addServiceDetail: (key, value) ->
                @serviceDetailsList += "(\"#{key}\" \"#{value}\")" unless value is ""

        getClipsPostProcessingLines: ->
                @postProcessingClipsLines
                
        getPrologInfoProcessingLines: ->
                @postProcessingPrologFacebookLines         +
                @postProcessingPrologCatalogueLines        +
                @postProcessingPrologLoginDisplayLines     +
                @postProcessingPrologDisplayLines          +
                @postProcessingPrologUserIdLines           +
                @postProcessingPrologYoutubeVideoInfoLines

        getPrologPostProcessingLines: ->
                @postProcessingPrologProcessPostLines

        getServiceDetails: ->
                serviceDetails = "'(\"#{@serviceName}\" \"#{@analysisUuid}\" #{@serviceDetailsList})\n"
                serviceDetails
                
        sanitize: (postString) ->
                unless typeof postString is 'string'
                        postString = postString.toString()
                postString = postString.replace(/"/g, "-----doublequote-----")
                postString = postString.replace(/'/g, "-----singlequote-----")
                postString = postString.replace(/\,/g, "-----comma-----")
                postString = postString.replace(/\n/g, "-----newline-----")
                postString = postString.replace(/’/g, "-----right-single-quote-----")
                postString = postString.replace("\ufeff", "")
                
                postString

        debugLog: (logEntry) ->
                if @debugOutput
                        console.log(logEntry)

        purge: ->
                @postProcessingClipsLines                  = ""
                @postProcessingPrologFacebookLines         = ""
                @postProcessingPrologCatalogueLines        = ""
                @postProcessingPrologLoginDisplayLines     = ""
                @postProcessingPrologDisplayLines          = ""
                @postProcessingPrologUserIdLines           = ""
                @postProcessingPrologYoutubeVideoInfoLines = ""
                @postProcessingPrologProcessPostLines      = ""
                
                @serviceDetails = ""
