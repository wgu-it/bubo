# Description:
#   Send slack posts to mysql database
#
# Notes:
#   Very preliminary implementation of a bot used to cache slack history to a database
#   to skirt the 10,000 message storage limit of a free slack
#
# Dependencies:
#   "mysql"     : "https://github.com/felixge/node-mysql"
#   "validator" : "https://github.com/chriso/validator.js"
#
# Configuration:
#   Please set up the following environment variables in order to connect to your database
#
#   HUBOT_MYSQL_HOST
#   HUBOT_MYSQL_DATABASE
#   HUBOT_MYSQL_USER
#   HUBOT_MYSQL_PASS

mysql = require 'mysql'
validator = require 'validator'
bot_test_room = 'G4FL9V07P'

module.exports = (robot) ->

  get_message_id = (response) ->
    "#{response.message.id}"
    console.log response.message

  get_username = (response) ->
    "#{response.message.user.name}"

  # helper method to get channel of originating message
  get_channel = (response) ->
    "#{response.message.room}"

  robot.catchAll (response) ->
    msg = response.message.text
    query = validator.blacklist(msg, [';'])

    unless process.env.HUBOT_MYSQL_HOST?
      console.log "Missing host environment variable"
      return

    unless process.env.HUBOT_MYSQL_DATABASE?
      console.log "Missing database environment variable"
      return

    unless process.env.HUBOT_MYSQL_USER?
      console.log "Missing user environment variable"
      return

    unless process.env.HUBOT_MYSQL_PASS?
      console.log "Missing password environment variable"
      return

    @client = mysql.createConnection
      host:  "#{process.env.HUBOT_MYSQL_HOST}"
      database: "#{process.env.HUBOT_MYSQL_DATABASE}"
      user: "#{process.env.HUBOT_MYSQL_USER}"
      password: "#{process.env.HUBOT_MYSQL_PASS}"
    @client.on 'error', (err) ->
      robot.emit 'error', err, msg
    @client.query "INSERT INTO messages VALUES(\'#{get_message_id(response)}\', \'#{query}\', \'#{get_username(response)}\', \'#{get_channel(response)}\', DEFAULT, DEFAULT);", (err, results) =>
      if err
        if get_channel(response) == bot_test_room
          response.send "error #{get_username(response)}"
          response.send JSON.stringify(err)
          # robot.adapter.client.chat.postMessage('bot-test', JSON.stringify(err), {unfurl_links: false})
          # robot.adapter.client.chat.postMessage(bot_test_room, "error #{get_username(response)}", {unfurl_links: false})
          # robot.adapter.client.chat.postMessage(bot_test_room, JSON.stringify(err), {unfurl_links: false})
        return
      @client.destroy()

