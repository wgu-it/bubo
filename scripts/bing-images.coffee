# Description:
#   Allows Hubot to find relevant images
#
# Configuration:
#   HUBOT_BING_IMAGES_KEY
#   HUBOT_BING_IMAGES_ADULT "Off", "Moderate", "Strict"
#
# Commands:
#   !image <query> - Searches for an image from the query and returns random
#   !image - <query> - Searches for an image from the query and returns first
#
# Author:
#   Ryan Winchester <fungku@gmail.com>

module.exports = (robot) ->

  robot.respond /(image|img)( me)?( -)? (.*)/i, (msg) ->
    msg.send JSON.stringify("```\n"+JSON.stringify(msg.message)+"\n```")
    if msg.message.room == 'random' or msg.message.room == 'bot-test' or msg.message.room == 'Shell'
      account_key = process.env.HUBOT_BING_IMAGES_KEY
      adult = process.env.HUBOT_BING_IMAGES_ADULT || "Strict"
      url = "https://api.datamarket.azure.com/Bing/Search/v1/Image"

      norandom = msg.match[3]?
      query = msg.match[4]?.trim()
      auth = new Buffer(":#{account_key}").toString('base64')
      params =
        Query: "'#{query}'"
        Adult: "'#{adult}'"
        $format: "json"
        $top: 20

      robot.http(url)
        .query(params)
        .headers(Authorization: "Basic #{auth}")
        .get() (err, res, body) ->
          if err
            msg.send "Failed to search: " + err
            return
          try
            images = JSON.parse(body).d.results
            image = if norandom then images[0] else msg.random images
            msg.send image.MediaUrl
          catch error
            msg.send error
            robot.emit 'error', error
