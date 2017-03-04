# Description:
#   Listen for course numbers and give the course name
#
# Commands:
#   none
#
# Author:
#   Ryan Winchester <fungku@gmail.com>

module.exports = (robot) ->

  robot.hear /C\s?[0-9]+/i, (res) ->
    res.send "Translate #{res.match[0]} to course name"
