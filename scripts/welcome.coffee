# Description:
#   When a new user joins the Slack channel, this script executes and provides the new user with welcome materials.
#
# Trigger:
#   <someNewUser> joined #general

welcome_materials = {
  google_drive: "https://drive.google.com/folderview?id=0B1S7OJNChk1-cWhwNWZTb2JNY1E",
  student_discounts: "https://docs.google.com/document/d/1cU-6kOuv-wGVaDbfY-H369gF0noasYc-p-bNnltKpD4/edit?usp=sharing",
  guide_to_common_abbreviations: "https://wguit.slack.com/files/weisegamer/F34HD93NW/_guide_to_common_abbreviations__.txt",
  majors_list: "#bs-biz-itmanagement, #bs-cybersecurity, #bs-softwaredev, #bs-dmda, #bs-healthinformatics, #bs-it, #bs-itsec, #bs-marketingmgmt, #bs-netadmin, and #ms-graduateprograms.",
}

greeting = """
Hello and welcome to the WGUit Slack Group! Here are a few resources to help you get settled:

This is a shared Google Drive that contains resources for several of the courses. (Be sure to login with your WGU gmail account!): #{welcome_materials.google_drive}
Here is a list of student discounts that you can take advantage of: #{welcome_materials.student_discounts}
We have created several communities for each major. Be sure to join the community for your major! This is where you will find the most applicable information. #{welcome_materials.majors_list}
You'll notice that we use a lot of abbreviations around here. Here is a quick guide that will help you make sense of our crazy language: #{welcome_materials.guide_to_common_abbreviations}

Feel free to reach out if you have any questions, and again, welcome! :smile:
"""

module.exports = (robot) ->

  # robot.listen(
  #   (msg) -> msg.type is "team_join"
  #   (response) ->
  #     response.reply greeting
  # )

  robot.enter (res) ->
    if res.message.room == 'C0Z77BT8V'
      robot.messageRoom "@#{res.message.user}", greeting
    if res.message.room == 'C0Z77BT4M'
      robot.messageRoom "@#{res.message.user}", greeting

  robot.respond /greet ([^\s]+)/, (msg) ->
    msg.send "#{msg.match[1]}!\n#{greeting}"
