# Description:
#   Wikia Public API
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_WIKIA_DOMAIN : wikia domain to search {ex: www, warframe, naruto, elderscrolls}
#
# Commands:
#   hubot wikia <query> - Returns the first 5 Wikipedia articles matching the search <query>
#
# Author:
#   aliasfalse
wikia = null
request = require('request')
md = require('node-md-config')
util = require('util')
domain = process.env.HUBOT_WIKIA_DOMAIN || 'www';
WIKIA_URL = "http://#{domain}.wikia.com/api/v1/";
SEARCH = 'Search/List';

wikiaSearch = (query, callback) ->
  formData = 
    query: query
    limit: 1
  url = WIKIA_URL + SEARCH
  request.post WIKIA_URL + SEARCH, { form: formData }, (err, response, body) ->
    if err
      callback err, null
    else if response.statusCode == 404
      callback null, null
    else if response.statusCode != 200
      error = undefined
      error = new Error("#{url} returned HTTP status #{response.statusCode}")
      callback error, null
    else
      data = undefined
      try
        data = JSON.parse(body)
      catch e
        data = null
      if !data
        error = undefined
        error = new Error("Invalid JSON from #{url}")
        callback error, null
      else
        callback null, data.items[0]
    return
  return

module.exports = (robot) ->
    robot.respond /wikia?(.+)/i, id:'hubot-wikia.article', (res) ->
      type = res.match[1]
      if not type
        res.reply "#{md.codeMulti}Please specify a search term#{md.blockEnd}"
      else
        #default case
        query = type.match(/(.+)/)[1]
        wikiaSearch query, (err, data) ->
          if err
            robot.logger.error err
          else if not data
            res.reply "#{md.codeMulti}Not found#{md.blockEnd}"
          else res.send util.format("#{md.codeMulti}#{md.linkBegin}#{data.title}#{md.linkMid}%s#{md.linkEnd}#{md.blockEnd}", data.url.replace('\\', ''));
