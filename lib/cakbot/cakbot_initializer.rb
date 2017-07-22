require 'json'
require 'discordrb'

class CakBotInitializer
  def self.setup(bot)
    bot.command :memes do
      ":regional_indicator_m: :regional_indicator_e: :regional_indicator_m: :regional_indicator_e: :regional_indicator_s:"
    end
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
    bot.command :pjson, max_args: 1 do |_event, *args|
      if args[0] == "-r" || args[0] == "readable"
        print bot.commands.to_json + "\n"
      else
        p bot.commands[:memes].mymethod#.to_json
      end
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
      # This is a check that only allows a user with a specific ID to execute this command. Otherwise, everyone would be
      # able to shut your bot down whenever they wanted.

      bot.send_message(event.channel.id, "GoodBye")
      exit
    end

  end

  def self.setup_json(bot)
    command_json = "{\"help\":{\"name\":\"help\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":\"Shows a list of all the commands available or displays help for a specific command.\",\"usage\":\"help [command name]\",\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}},\"memes\":{\"name\":\"memes\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":null,\"usage\":null,\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":-1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}},\"bold\":{\"name\":\"bold\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":null,\"usage\":null,\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":-1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}},\"italic\":{\"name\":\"italic\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":null,\"usage\":null,\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":-1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}},\"invite\":{\"name\":\"invite\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":null,\"usage\":null,\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":-1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}},\"pjson\":{\"name\":\"pjson\",\"attributes\":{\"permission_level\":0,\"permission_message\":\"You don't have permission to execute command %name%!\",\"required_permissions\":[],\"required_roles\":[],\"channels\":null,\"chain_usable\":true,\"help_available\":true,\"description\":null,\"usage\":null,\"arg_types\":null,\"parameters\":null,\"min_args\":0,\"max_args\":1,\"rate_limit_message\":null,\"bucket\":null},\"block\":{}}}"

    bot.load_commands(JSON.parse command_json, symbolize_names: true)
  end

  def self.settings
    {
        token: ENV['TOKEN'],
        client_id: ENV['CLIENT_ID'],

        prefix: '!' #to parser block?
    }
  end

  def self.boot
    bot = CakBot::CakBot.new settings
    setup(bot)
    bot.run
  end
end