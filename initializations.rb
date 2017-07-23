$:.unshift File.dirname(__FILE__)+"/lib/cakbot"
$:.unshift File.dirname(__FILE__)+"/discordrb-cakbot/lib"

require 'dotenv'
require 'json'

require 'discordrb'
require 'custom_command'

require 'json_saver'

require 'cakbot_initializer'
require 'cakbot'

require 'ext/string'
require 'ext/command'


Dotenv.load