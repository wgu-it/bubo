# Description:
#   Listen for triggers and give the response
#
# Configuration
#   HUBOT_TRIGGER_CHAR - The character you want to use to identify a trigger.
#                        Defaults to !
#
# Commands:
#   !<trigger>
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

TRIGGER = process.env.HUBOT_TRIGGER_CHAR || '!'

triggers = {
  "hello": "Hi there!",
  "goodbye": "See ya!",
  "no": "Noooo! https://www.youtube.com/watch?v=umDr0mPuyQc",
  "nope": "https://media.giphy.com/media/6h4z4b3v6XWxO/giphy.gif",
}

module.exports = (robot) ->

  robot.hear ///^#{TRIGGER}(.+)$///gi, (res) ->
    match = res.match[0].replace(///^#{TRIGGER}///, "")
    if triggers[match]?
      res.send triggers[match]
