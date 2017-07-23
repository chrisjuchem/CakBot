class JsonSaver
  def self.register_save_on_exit(bot)
    at_exit do
      bot.save_to_file
    end
  end
end
