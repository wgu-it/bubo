# Description:
#   Listen for triggers and give the response
#
# Configuration
#   HUBOT_TRIGGER_CHAR - The character you want to use to identify a trigger.
#                        Defaults to !
#
# Commands:
#   !<trigger>
#   bubo list triggers
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

trigger_char = process.env.HUBOT_TRIGGER_CHAR || '!'
triggers = require('../support/triggers')

module.exports = (robot) ->

  robot.respond /list triggers/, (msg) ->
    msg.send ("#{trigger_char}#{key}" for own key of triggers).join(", ")

  robot.hear ///^#{trigger_char}(.+)$///gi, (msg) ->
    if msg.message.room == 'C0Z77BT4M' or msg.message.room == 'C0Z77BT8V' or msg.message.room == 'Shell'
      match = msg.match[0].replace(///^#{trigger_char}///, "")
      if triggers[match]?
        msg.send triggers[match]
