class CakBotInitializer
  def self.setup(bot)
    # bot.custom_command :memes, {},
    #   ":regional_indicator_m: :regional_indicator_e: :regional_indicator_m: :regional_indicator_e: :regional_indicator_s:"
    # bot.custom_command :roll, {},
    #                    "1;2;3;4;5;6"
    # bot.command :bold do |_event, *args|
    #   "**#{args.join(' ')}**"
    # end
    # bot.command :italic do |_event, *args|
    #   "*#{args.join(' ')}*"
    # end
    bot.command :shrug do
      "¯\\_(ツ)_/¯"
    end
    bot.command :invite, description: "Get the invite URL to invite CakBot to another server." do
      "Invite me to another server: #{bot.invite_url}"
    end
    bot.command :backup, help_available: false do
      bot.save_to_file
      "Done!"
    end
    bot.command :off, help_available: false do |event|
      bot.send_message(event.channel.id, "GoodBye")
      exit
    end

    bot.command :alias, min_args: 2, max_args: 2,
                arg_types: [Symbol, Symbol],
                description: "Give another name to a command.",
                usage: "`!%command% <old command> <new command>`" do |event, old, new|
      next "Command `!#{new}` already exists!" if bot.commands[new]
      next "Alias `!#{new}` already exists!" if bot.aliases[new]

      if bot.commands[old]
        bot.alias old, new
      elsif bot.aliases && base = bot.aliases[old]
        bot.alias base, new
      else
        next "Command `!#{old}` does not exist!"
      end
      "`!#{old}` can now also be called with `!#{new}`."
    end

    bot.command :addcommand, min_args: 2, arg_types: [Symbol],
                description: "Create a custom command.",
                usage: "`!%command% <name> $... $?... \"<response>\"` \n" <<
                       "`$` specifies a required argument, and `$?` an optional one.\n" <<
                       "Reference arguments with `$1$`, `$2$`, ...\n" <<
                       "Responses separated by a semicolon will be chosen at random."do |_event, *args|

      name = args.delete_at(0)
      next "Error: That command already exists!" if bot.commands[name] || bot.aliases[name]

      command = args.delete_at(-1)
      implicit_flags = []
      permitted_flags = []
      min_args = 0
      max_args = 0

      parsing_flags = true
      # parsing_args = false
      args.each_with_index do |arg, i|

        # unless parsing_args || parsing_flags
        #   next "Invalid command syntax."
        # end


        if parsing_flags
          if arg.start_with? '--'
            implicit_flags << arg.delete('--')
          elsif arg.start_with? '-'
            permitted_flags << arg.delete('-')
          else
            parsing_flags = false
            #parsing_args = true
          end
        end

        # TODO: types
        # TODO: *
        unless parsing_flags # if parsing_args
          next "Error: Invalid command syntax." unless arg.start_with? '$'
          # add tyoe to array, then strip at end ::::: IntegerFloatTimebool, symbol rational range, emoji, user
          if arg.end_with? '?'
            max_args = min_args if max_args == 0
            max_args += 1
          else
            next "Error: Optional arguments cannot be before required ones." unless max_args == 0
            min_args += 1
          end
        end
      end
      max_args = min_args if max_args.zero?

      next "Cannot include the same flag as both implicit and optional" if (implicit_flags & permitted_flags).size > 0

      opts = {}
      opts[:max_args] = max_args unless max_args.zero?
      opts[:min_args] = min_args # unless max_args.zero?
      opts[:implicit_flags] = implicit_flags
      opts[:permitted_flags] = permitted_flags
      bot.custom_command name, opts, command

      #-v here
      "Command `!#{name}` created!"
    end

    bot.command :deletecommand, arg_types: [Symbol],
                min_args: 1, max_args: 1,
                description: "Delete a command. Base commands are only deleted until bot restart.",
                usage: "`!%command% <command name>`" do |event, arg|
      next "Fuck off Nick" if event.author.username == "zovt"

      deleted = bot.aliases.delete(arg)
      next "Alias !`#{arg}` for !`#{deleted}` deleted!" if deleted
      deleted = bot.commands.delete(arg)
      next "Command !`#{arg}` not found!" unless deleted
      bot.aliases.delete_if do |k, v|
        delete = v == arg
        event << "Alias !`#{k}` for !`#{v}` deleted!" if delete
        delete
      end
      "Command !`#{arg}` deleted!"
    end

    bot.command :featurerequest,
                description: "Request a new feature for CakBot.",
                usage: "`!%command% <your request>`\n" <<
                    "These requests are logged to a file on Chris' computer where he will be able to read your suggestions later.\n" <<
                    "Any and all serious requests are welcomed, from minor text tweaks to complex features." do |event, *args|
      File.open 'requests.txt', 'a' do |f|
        f.write "At #{Time.now}, #{event.author.username} requested:\n    "
        f.write args.join(" ")
        f.write "\n\n"
      end
      "Request saved."
    end

    bot.command :bugreport,
                description: "Report a bug you've dicovered with CakBot.",
                usage: "`!%command% <your desciption of the bug>`\n" <<
                    "These reports are logged to a file on Chris' computer where he will be able to read your reports later.\n" <<
                    "Please describe the unexpected behavior in as much detail as possible, including the commands entered and the output." do |event, *args|
      File.open 'bugs.txt', 'a' do |f|
        f.write "At #{Time.now}, #{event.author.username} reported:\n    "
        f.write args.join(" ")
        f.write "\n\n"
      end
      "Report saved."
    end

    bot.command :aliases, max_args: 1, arg_types: [Symbol],
                desciption: "See a list of all command aliases",
                usage: "`!%command% [base command]`" do |event, *args|
      event << "Aliases:"
      if args[0]
        a = (bot.aliases.select{ |k, v| v == args[0] && bot.commands[v].attributes[:help_available] })
               p a
        a.keys.join(", ")
      else

        bot.aliases.each do |k, v|
          event << "`#{k}` for `#{v}`" if bot.commands[v].attributes[:help_available]
        end

        next
      end
    end

    # bot.command :user, description: "Get the current user. Use `[!user] in another command to sub in the user's name." do |event|
    #   event.author.username
    # end

    #bot.command :is_alias
  end

  def self.setup_json(bot)
    file = File.open('commands.json', 'r')
    command_json = file.read.force_encoding("UTF-8")
    file.close
    file = File.open('aliases.json', 'r')
    alias_json = file.read.force_encoding("UTF-8")
    file.close

    JSON.parse(command_json, symbolize_names: true).each do |name, attrs|
      next unless attrs
      command = attrs.delete(:command)
      bot.custom_command name, attrs, command
    end
    JSON.parse(alias_json, symbolize_names: true).each do |name, command|
      bot.alias command.to_sym, name
    end
  end

  def self.settings
    {
      token: ENV['TOKEN'],
      client_id: ENV['CLIENT_ID'],

      prefix: '!', #to parser block?
      command_doesnt_exist_message: "The command `!%command%` doesn't exist!",

      advanced_functionality: true,

      enabled_flags: ["tts"]
    }
  end

  # def self.boot
  #   bot = CakBot::CakBot.new settings
  #   setup(bot)
  #   bot.run
  # end
end
