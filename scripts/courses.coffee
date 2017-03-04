# Description:
#   Listen for course numbers and give the course name
#
# Commands:
#   none
#
# Author:
#   Ryan Winchester <code@ryanwinchester.ca>

course_list = require('../support/courses')

module.exports = (robot) ->

  robot.hear /C(?:\s|-)?([0-9]{3})(?:[^0-9]|$)/gi, (res) ->
    courses = for course in res.match
      course = "C" + course.replace(/[^0-9]+/, "").replace(/\s/, "")
      if course_list[course]?
        "#{course}: " + course_list["#{course}"].name
    courses = courses.filter (c) -> c?
    if courses.length > 0
      res.send courses.join("\n")

  robot.respond /describe C(?:\s|-)?([0-9]{3})(?:[^0-9]|$)/i, (res) ->
    course = "C#{res.match[1]}"
    if course_list[course]?
      res.send course_list[course].desc
