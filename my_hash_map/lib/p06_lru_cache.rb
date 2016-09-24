require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(key)
      @map.get(key)
    else
      calc!(key)
    end


  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count == @max
    val = @prc.call(key)
    @store.insert(key, val)
    @map.set(key, @store.last)
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.insert(link, @map.get(link) )
    @store.remove(link)
    @map.set(link, @store.last)
  end

  def eject!
    k = @store.first.key
    @store.remove(k)
    @map.delete(k)

  end
end
