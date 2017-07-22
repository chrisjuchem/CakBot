require 'discordrb'
require_relative 'CakBotInitializer'


class CakBot < Discordrb::Commands::CommandBot
  def initialize (attributes = {})
    super attributes
    CakBotInitializer.setup(self)
    #CakBotInitializer.setup_json(self)

  end

  def load_commands(command_container)
    @commands = command_container
  end

end
