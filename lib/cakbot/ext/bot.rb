class Discordrb::Bot
  def choose_random(msg)
    choices = msg.split(';')
    choices[rand(choices.size)]
  end
end