# This bot shows off PM functionality by sending a PM every time the bot is mentioned.

require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Bot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID']

# The `mention` event is called if the bot is *directly mentioned*, i.e. not using a role mention or @everyone/@here.
bot.mention do |event|
  # The `pm` method is used to send a private message (also called a DM or direct message) to the user who sent the
  # initial message.
  event.user.pm('You have mentioned me!')
end

bot.run
