# Description:
#   When a new user joins the Slack channel, this script executes and provides the new user with welcome materials.
#
# Trigger:
#   <someNewUser> joined #general

welcome_materials = require('../support/welcome')

response = welcome_materials.welcome_message +
"\n\n This is a shared Google Drive that contains resources for several of the courses. (Be sure to login with your WGU gmail account!): "+ welcome_materials.google_drive +
"\n Here is a list of student discounts that you can take advantage of: "+ welcome_materials.student_discounts +
"\n We have created several communities for each major. Be sure to join the community for your major! This is where you will find the most applicable information. " + welcome_materials.majors_list +
"\n You'll notice that we use a lot of abbreviations around here. Here is a quick guide that will help you make sense of our crazy language: " + welcome_materials.guide_to_common_abbreviations+
"\n\n Feel free to reach out if you have any questions, and again, welcome! :smile:";

module.exports = (robot) ->
  robot.hear /(joined #general$)/gi, (msg) ->
    robot.respond
    if msg.message.room == 'C0Z77BT4M' or msg.message.room == 'C0Z77BT8V' or msg.message.room == 'Shell'
      msg.send(response)
