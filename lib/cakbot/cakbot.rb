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
    File.open('aliases.json', 'w') do |f|
      f.puts aliases.to_json
    end
    puts "Bot information saved to file!"
  end

  def copy_to_backup_file
    File.open('commands.backup', 'w') do |b|
      File.open('commands.json', 'r') do |j|
        b.puts j.read
      end
    end
    File.open('aliases.backup', 'w') do |b|
      File.open('aliases.json', 'r') do |j|
        b.puts j.read
      end
    end
    puts "Backup copied!"
  end
end
