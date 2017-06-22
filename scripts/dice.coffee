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

  die = Math.floor(Math.random() * 6) + 1
  secondDie = Math.floor(Math.random() * 6) + 1
  
  robot.hear /bubo roll the dice/, (msg) ->
    msg.send "I rolled the dice and came up with a #{die} and a #{secondDie} for a total of #{die + secondDie}!"
