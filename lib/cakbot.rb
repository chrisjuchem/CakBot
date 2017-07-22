require 'discordrb'
require 'dotenv'
require_relative 'cakbot/CakBot'

Dotenv.load
bot = CakBot.new token: ENV['TOKEN'], client_id: ENV['CLIENT_ID'], prefix: '!'
bot.run