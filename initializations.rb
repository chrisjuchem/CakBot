$:.unshift File.dirname(__FILE__)+"/lib/cakbot"
$:.unshift File.dirname(__FILE__)+"/discordrb-cakbot/lib"

require 'dotenv'
require 'json'

require 'discordrb'
require 'ext/discordrb/command'
require 'ext/discordrb/custom_command'
require 'ext/discordrb/bot'
require 'ext/discordrb/command_bot'

require 'json_saver'

require 'cakbot_initializer'
require 'cakbot'

require 'ext/string'
require 'ext/array'


Dotenv.load
