# Description:
#   Respond in a funny way to different commands.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <command>
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

responses = require('../support/responses')

module.exports = (robot) ->

  robot.respond /(.*)/, (msg) ->
    if msg.message.room == 'C0Z77BT4M' or msg.message.room == 'C0Z77BT8V' or msg.message.room == 'Shell'
      command = msg.match[1].replace ///#{robot.name}\s?///, ""
      if responses[command]?
        msg.send responses[command]
