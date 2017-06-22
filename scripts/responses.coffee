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

  robot.respond /(.*)/, (res) ->
    if res.message.room == 'C0Z77BT4M' or res.message.room == 'C0Z77BT8V' or res.message.room == 'Shell'
      command = res.match[1].replace ///#{robot.name}\s?///, ""
      if responses[command]?
        res.send responses[command]
