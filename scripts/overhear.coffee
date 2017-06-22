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

module.exports = (robot) ->

  robot.hear /┻━┻/, (msg) ->
    msg.send '┬──┬◡ﾉ(° -°ﾉ)'
