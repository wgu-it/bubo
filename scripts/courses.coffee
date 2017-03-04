# Description:
#   Listen for course numbers and give the course name
#
# Commands:
#   none
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

module.exports = (robot) ->

  robot.hear /C(?:\s|-)?([0-9]{3})(?:[^0-9]|$)/gi, (res) ->
    # TODO: Translate all matches
    courses = for course, i in res.match
      course = course.replace(/[^0-9]+/, "")
      "TODO: Translate course ##{course} to course name, if exists."
    res.send courses.join "\n"
