class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hashes = self.map { |el| el.hash }
    hash = 0
    hashes.each_with_index { |el, i| hash += el * i }
    hash % 10**9
  end
end

class String
  def hash
    hashes_array = chars.map { |el| el.ord.hash }
    hashes_array.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort
    hashes_array = []
    keys.each do |k|
      hashes_array.push([k, self[k]].hash)
    end
    hashes_array.hash
  end
end
