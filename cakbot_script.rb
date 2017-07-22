$:.unshift File.dirname(__FILE__)+"/lib/cakbot"
$:.unshift File.dirname(__FILE__)+"/discordrb-cakbot/lib"

require 'dotenv'
require 'cakbot'

Dotenv.load
bot = CakBot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID'], prefix: '!'
bot.run
