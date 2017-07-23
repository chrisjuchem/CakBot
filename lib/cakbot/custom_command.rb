class CustomCommand < Discordrb::Commands::Command
  def to_json(*args)
    json_hash = {
      command: @command
    }
    attributes.each do |attr, val|
      json_hash[attr] = val
    end
    json_hash.to_json(*args)
  end
end
