# Description
#   Find a relevant XKCD for a phrase
#
# Configuration:
#   None
#
# Commands:
#   hubot relevant xkcd <phrase>
#
#
# Notes:
#   None
#
# Author:
#   Kelvin Zhang <me@iamkelv.in>

module.exports = (robot) ->
  robot.respond /xkcd\s+(.+)/i, (msg) ->
    phrase = msg.match[1]

    # Get a relevant XKCD by phrase
    msg.http("https://relevantxkcd.appspot.com/process?action=xkcd&query=#{phrase}")
    .get() (err, res, body) ->
      if res.statusCode != 200
        msg.send 'An error has occurred. Is https://relevantxkcd.appspot.com/ up?'
      else
        # Extract appropriate data from response
        responseData = body.split('\n')
        percentageCertainty = responseData[0]
        comicNumber = parseInt(responseData[2].replace /\s+$/g, "", 10)

        # Get the comic details from XKCD
        msg.http("https://xkcd.com/#{comicNumber}/info.0.json")
        .get() (err, res, body) ->
          if res.statusCode isnt 200
            msg.send "Comic #{comicNumber} not found. Got #{res.statusCode}."
          else
            object = JSON.parse(body)
            msg.send object.title, object.img, object.alt
