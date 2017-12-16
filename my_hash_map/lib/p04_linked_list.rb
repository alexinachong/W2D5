class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @HEAD = Node.new(:HEAD, nil)
    @TAIL = Node.new(:TAIL, nil)
    @HEAD.next = @TAIL
    @TAIL.prev = @HEAD
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @HEAD.next
  end

  def last
    @TAIL.prev
  end

  def empty?
    #p @HEAD.next == @TAIL
    @HEAD.next == @TAIL
  end

  def get(key)
    node = fetch_node_by_key(key)
    if node
      node.val
    else
      nil
    end
  end

  def fetch_node_by_key(key)
    current_node = @HEAD
    until current_node.key == key || current_node == @TAIL
      current_node = current_node.next
    end
    if current_node == @TAIL
      nil
    else
      current_node
    end
  end

  def include?(key)
    node = fetch_node_by_key(key)
    node != nil
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last
    @TAIL.prev = new_node
    new_node.next = @TAIL
  end

  def update(key, val)
    node = fetch_node_by_key(key)
    if node
      node.val = val
    end
  end

  def remove(key)
    node = fetch_node_by_key(key)
    next_node = node.next
    prior_node = node.prev
    next_node.prev = prior_node
    prior_node.next = next_node
    node.next = nil
    node.prev = nil
  end

  def each
    current_node = @HEAD

    until current_node.next == @TAIL
      # Unhappy about this
      yield current_node.next
      current_node = current_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
