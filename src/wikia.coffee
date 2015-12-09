# Description:
#   Wikia Public API
#
# Dependencies:
#   None
#
# Configuration:
#   WIKI_DOMAIN : wikia domain to search {ex: www, warframe, naruto, elderscrolls}
#
# Commands:
#   hubot wikia search <query> - Returns the first 5 Wikipedia articles matching the search <query>
#   hubot wikia summary <article> - Returns a one-line description about <article>
#
# Author:
#   aliasfalse

WIKI_DOMAIN = "warframe"
WIKI_API_URL = "https://"+ WIKI_DOMAIN +".wikia.com/api/v1/"
WIKI_EN_URL = "https://"+ WIKI_DOMAIN +".wikia.com/wiki/"

module.exports = (robot) ->
    robot.respond /wikia search (.+)/i, id: "wikipedia.search", (msg) ->
        params =
            action: 'opensearch'
            format: 'json'
            limit: 5
            search: msg.match[1]

        wikiRequest msg, params, (object) ->
            if object[1].length is 0
                msg.reply "No articles were found using search query: \"#{msg.match[1]}\". Try a different query."
                return

            for article in object[1]
                msg.send "#{article}: #{createURL(article)}"

    robot.respond /wikia summary (.+)/i, id: "wikipedia.summary", (msg) ->
        params =
            action: 'query'
            exintro: true
            explaintext: true
            format: 'json'
            prop: 'extracts'
            titles: msg.match[1]

        wikiRequest msg, params, (object) ->
            for id, article of object.query.pages
                if id is -1
                    msg.reply "The article you have entered (\"#{msg.match[1]}\") does not exist. Try a different article."
                    return

                if article.extract is ""
                    summary = "No summary available"
                else
                    summary = article.extract.split(". ")[0..1].join ". "

                msg.send "#{article.title}: #{summary}."
                msg.reply "Original article: #{createURL(article.title)}"
                return

createURL = (title) ->
    "#{WIKIA_EN_URL}/#{encodeURIComponent(title)}"

wikiRequest = (msg, params = {}, handler) ->
    msg.http(WIKIA_API_URL)
        .query(params)
        .get() (err, res, body) ->
            if err
                msg.reply "An error occurred while attempting to process your request: #{err}"
                return robot.logger.error err

            handler JSON.parse(body)