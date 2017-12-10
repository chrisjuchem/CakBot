class Discordrb::Commands::CommandBot
  def extract_flags(args)
    flags = []
    while args[0] && args[0].start_with?('-')
      flags << args.delete_at(0)[1..-1]
    end
    flags
  end

  def execution_options(command, passed_flags)
    passed_flags &= command.attributes[:permitted_flags]               #must be permitted for this command
    flags = @attributes[:enabled_flags] &                              #must be enabled for the bot
        (command.attributes[:implicit_flags] | passed_flags)

    options = {}
    flags.each { |f| options[f.to_sym] = true }              # likely need to be reworked as more are added
    options
  end
end