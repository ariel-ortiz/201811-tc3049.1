#--------------------------------------------------------------------
# Adapts an Enumerator to work like the original ArrayIterator.
class EnumeratorAdapter
  
  def initialize(enum)
    @enum = enum
  end
  
  def has_next?
    begin
      @enum.peek
      true
    rescue StopIteration
      false
    end
  end
  
  def item
    return nil if !has_next?
    @enum.peek
  end
  
  def next_item
    return nil if !has_next?
    @enum.next
  end
end

#--------------------------------------------------------------------
# Using external iterators to implement merge sort.
# Taken from [OLSEN] p. 132.
def merge(array1, array2)
  merged = []

  iterator1 = EnumeratorAdapter.new(array1.to_enum)
  iterator2 = EnumeratorAdapter.new(array2.to_enum)

  while (iterator1.has_next? and iterator2.has_next?)
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  # Pick up the leftovers from array1
  while (iterator1.has_next?)
    merged << iterator1.next_item
  end

  # Pick up the leftovers from array2
  while (iterator2.has_next?)
    merged << iterator2.next_item
  end

  merged
end

a = [3, 4, 5, 6, 7, 7, 10]
b = [1, 2, 3, 5, 7, 20, 30]
c = merge(a, b)
p c