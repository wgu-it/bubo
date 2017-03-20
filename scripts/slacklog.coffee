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

channels =
  G4FL9V07P: 'bot-test'

module.exports = (robot) ->

  robot.catchAll (response) ->
    message =
      id: response.message.id,
      username: response.message.user.name,
      channel: response.message.room,
      text: response.message.text

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

    query = 'INSERT INTO messages VALUES(?, ?, ?, ?, DEFAULT, DEFAULT);'
    values = [message.id, message.text, message.username, message.channel]

    @client.query query, values, (err, results) ->
      if err
        console.log err
        if get_channel(response) == bot_test_room
          response.send JSON.stringify(err)
          response.send """
            username: #{get_username(response)},
            message_id: #{get_message_id(response)},
            channel: #{get_channel(response)}
          """
      @client.destroy()

