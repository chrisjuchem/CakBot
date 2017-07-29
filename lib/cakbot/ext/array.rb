class Array
  def strip_trailing_nils
    res = []
    reverse_each do |item|
      next if item.nil? && res.empty?
      res.unshift item
    end
    res
  end
end