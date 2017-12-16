require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket = bucket(key)
    unless bucket
      return false
    end
    bucket.include?(key)
  end

  def set(key, val)
    bucket = bucket(key)
    if include?(key)
      bucket.update(key, val)
    else
      bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    if include?(key)
      bucket = bucket(key)
      bucket.get(key)
    else
      nil
    end
  end

  def delete(key)
    bucket = bucket(key)
    if bucket
      bucket.remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    elements = []
    @store.each do |bucket|
      bucket.each do |node|
        elements.push([node.key, node.val])
      end
    end

    @store = Array.new(2 * num_buckets) { LinkedList.new }
    @count = 0

    elements.each { |el| set(*el) }
  end

  def bucket(key)
    bucket = @store[key.hash % num_buckets]
    if bucket
      bucket
    else
      nil
    end
  end
end
