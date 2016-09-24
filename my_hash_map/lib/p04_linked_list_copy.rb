class Link
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
end

class LinkedList
  include Enumerable
  def initialize
    @store = []
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @store[0]
  end

  def last
    @store[-1]
  end

  def empty?
    @store.empty?
  end

  def get(key)
    @store.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    @store.any? { |node| node.key == key }
  end

  def insert(key, val)
    link = Link.new(key, val)
    unless empty?
      link.prev = @store[-1]
      @store[-1].next = link
    end
    @store << link
  end

  def remove(key)
    @store.each_with_index do |el, i|
      if el.key == key
        @store[i-1].next = @store[i + 1]
        @store[i + 1].prev = @store[i - 1]
        @store.delete(el)
      end
    end
  end

  def each
    @store.each do |el|
      yield(el)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
