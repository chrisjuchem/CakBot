class String
  def call(event, *args)
    gsub(/\$(\d+)\$/) { args[$+.to_i - 1] }
      #.gsub(/\$*\$/) { args[-1] }
  end
end
