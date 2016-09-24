class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    @store[@count] = val
    @count += 1
  end

  def unshift(val)
    new_array = StaticArray.new(@count + 2)
    new_array[0] = val
    i = 0
    while i < @count
      new_array[i + 1] = @store[i]
      i += 1
    end
    @store = new_array
  end

  def pop
    return nil if @count == 0
    val = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    val
  end

  def shift
    return nil if @count == 0
    new_array =  StaticArray.new(@count + 1)
  end

  def first
  end

  def last
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
