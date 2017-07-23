class CakBot < Discordrb::Commands::CommandBot
  def initialize (attributes = {})
    super attributes
    CakBotInitializer.setup(self)
    CakBotInitializer.setup_json(self)
    #aliases
    JsonSaver.register_save_on_exit(self)
  end

  def save_to_file
    File.open('commands.json', 'w') do |f|
      f.puts commands.to_json
    end
    puts "Bot information saved to file!"
  end
end
