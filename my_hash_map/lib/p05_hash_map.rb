require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    if include?(key)
      linked_list = @store[key.hash % num_buckets]
      linked_list.each do |node|
        if node.key == key
          node.val = val
        end
      end
    else
      @store[key.hash % num_buckets].insert(key, val)
    end
    @count += 1
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    @store[key.hash % num_buckets].remove(key)
    @count -= 1
  end

  def each
    @store.each do |linked_list|
      unless linked_list.empty?
        linked_list.each do |node|
          yield(node.key, node.val)
        end
      end
    end
  end

  # uncomment when you have Enumerable included
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
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    self.each do |key, val|
      new_store[key.hash % (num_buckets * 2)].insert(key, val)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
