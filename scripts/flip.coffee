# Description:
#   flip a coin
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   bubo flip
#
# Author:
#   Liam Besaw <liam.besaw@gmail.com>

module.exports = (robot) ->

  robot.respond /flip/i, (msg) ->
    headsOrTails = Math.floor(Math.random() * 100) + 1
    msg.send "I flipped a coin for #{msg.message.user.name} and it landed  #{if headsOrTails < 51 then "*tails*" else "*heads*"}!"
