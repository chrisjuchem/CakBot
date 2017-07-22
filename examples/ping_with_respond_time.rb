# This example is nearly the same as the normal ping example, but rather than simply responding with "Pong!", it also
# responds with the time it took to send the message.

require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Bot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID']

bot.message(content: 'Ping!') do |event|
  # The `respond` method returns a `Message` object, which is stored in a variable `m`. The `edit` method is then called
  # to edit the message with the time difference between when the event was received and after the message was sent.
  m = event.respond('Pong!')
  m.edit "Pong! Time taken: #{Time.now - event.timestamp} seconds."
end

bot.run