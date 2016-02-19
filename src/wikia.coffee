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
wikia = require('./lib/wikia.js')

module.exports = (robot) ->
    robot.respond /wikia search (.+)/i, (res) ->
        query = res.match[1]
        if not query
          res.reply 'Please specify a search term'
        else
          wikia.wikiaSearch query, (err, data) ->
            if err
              robot.logger.error err
            else if not data
              res.reply 'Not found'
            else if robot.adapterName is 'telegram'
              res.send util.format('[%s](%s)', data.title, data.url.replace('\\', ''))
            else
              res.send util.format('%s : %s', data.title, data.url.replace('\\', ''))

    robot.respond /wikia summary (.+)/i, (res) ->
        query = res.match[1]
        if not query
          res.reply 'Please specify a search term'
        else
          wikia.wikiaSummary query, (err, data, url) ->
            if err
              robot.logger.error err
            else if not data
              res.reply 'Not found'
            else
              res.send util.format('%s : \r\n%s\r\n%s', data.title, data.content.text, url.replace('\\', ''))
