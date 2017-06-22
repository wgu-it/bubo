# Description:
#   Roll the dice
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   bubo roll the dice
#
# Author:
#   Liam Besaw <liam.besaw@gmail.com>

module.exports = (robot) ->

  robot.respond /roll the dice/i, (msg) ->
    first = Math.floor(Math.random() * 6) + 1
    second = Math.floor(Math.random() * 6) + 1
    msg.send "I rolled the dice for #{res.message.user} and came up with a #{first} and a #{second} for a total of #{first + second}!"
