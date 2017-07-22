# Eval bots are useful for developers because they give you a way to execute code directly from your Discord channel,
# e.g. to quickly check something, demonstrate something to other, or something else entirely. Special care must be
# taken since anyone with access to the command can execute arbitrary code on your system which may potentially be
# malicious.

require 'discordrb'
require 'dotenv'

Dotenv.load

bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID'], prefix: '!'

bot.command(:eval, help_available: false) do |event, *code|
  break unless event.user.id == 66237334693085184 # Replace number with your ID

  begin
    eval code.join(' ')
  rescue
    'An error occurred 😞'
  end
end

bot.run
