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

  robot.hear /([a-zA-Z]{1,3})(?:\s|-)?([0-9]{1,4})/gi, (res) ->
    courses = for course in res.match
      course = course.replace(/[^a-zA-Z0-9]+/, "").toUpperCase()
      if course_list[course]?
        "#{course}: " + course_list["#{course}"].name
    courses = courses.filter (c) -> c?
    if courses.length > 0
      res.send courses.join("\n")

  robot.respond /describe ([a-zA-Z]{1,3})(?:\s|-)?([0-9]{1,4})/i, (res) ->
    course = "#{res.match[1]}#{res.match[2]}".replace(/[^a-zA-Z0-9]+/, "").toUpperCase()
    if course_list[course]?
      res.send course_list[course].desc
