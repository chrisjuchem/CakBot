class CakBotInitializer
  def self.setup(bot)
    # bot.custom_command :memes, {},
    #   ":regional_indicator_m: :regional_indicator_e: :regional_indicator_m: :regional_indicator_e: :regional_indicator_s:"
    bot.command :bold do |_event, *args|
      "**#{args.join(' ')}**"
    end
    bot.command :italic do |_event, *args|
      "*#{args.join(' ')}*"
    end
    bot.command :invite do
      "Invite me to another server: #{bot.invite_url}"
    end
    bot.command :shrug do
      "¯\\_(ツ)_/¯"
    end
    bot.command :backup do
      bot.save_to_file
      "Done!"
    end
    # bot.command :reload do
    #   stop
    #   boot
    #   "Done!"
    # end
    bot.command :command, min_args: 1 do |_event, *args|
      p bot.commands[args[0].to_sym]
      "Done!"
    end
    bot.command(:off, help_available: false) do |event|
      bot.send_message(event.channel.id, "GoodBye")
      exit
    end

  end

  def self.setup_json(bot)
    file = File.open('commands.json', 'r')
    command_json = file.read
    file.close

    JSON.parse(command_json, symbolize_names: true).each do |name, attrs|
      next unless attrs
      command = attrs.delete(:command)
      bot.custom_command name, attrs, command
    end
  end

  def self.settings
    {
      token: ENV['TOKEN'],
      client_id: ENV['CLIENT_ID'],

      prefix: '!' #to parser block?
    }
  end

  # def self.boot
  #   bot = CakBot::CakBot.new settings
  #   setup(bot)
  #   bot.run
  # end
end
