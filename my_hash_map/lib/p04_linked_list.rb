require 'byebug'
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
    @head = Link.new
    @tail = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == nil && @tail.prev == nil
  end

  def get(key)
    return nil if empty?
    current = @head
    until current.key == key || current == @tail
      current = current.next
    end
    current.val
  end

  def include?(key)
    !get(key).nil?
  end

  def insert(key, val)
    link = Link.new(key, val)
    if empty?
      @head.next = link
      @tail.prev = link
      link.next = @tail
      link.prev = @head
    else
      @tail.prev.next = link
      link.prev = @tail.prev
      link.next = @tail
      @tail.prev = link
    end


  end

  def remove(key)
    link = @head
    until link.key == key
      link = link.next
      return nil if link == @tail
    end
    link.prev.next = link.next
    link.next.prev = link.prev
  end

  def each
    current = @head.next
    until current == @tail
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
