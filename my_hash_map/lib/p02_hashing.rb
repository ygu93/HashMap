class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.map do |el|
      el == [] ? 1 : el.ord.to_s
    end.join.to_i
  end
end

class String
  def hash
    self.chars.map {|el| el.ord.to_s}.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort.map(&:to_s).hash
    values = self.values.sort.hash
    keys + values
  end
end
