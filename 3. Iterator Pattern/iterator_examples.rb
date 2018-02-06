class MyIteratorExample
  def each
    n = 1
    while n < 1_000
      yield n
      n *= 2
    end
  end
end

# Conventional use of 'each' method.
it = MyIteratorExample.new
#it.each {|x| puts x }

# Using Enumerator
enum = it.to_enum {10}
puts enum.next
puts enum.next
puts enum.next
enum.rewind
puts enum.next
p enum.size

puts '--------------------'
enum.rewind
begin
  loop do
    p enum.next
  end
rescue StopIteration

end

puts '--------------------'
enum.each do |x|
  p x
end


# Using Enumerator to produce a generator
def pow10(max)
  Enumerator.new do |yielder|
    i = 1
    while i <= max
      yielder << i
      i *= 10
    end
  end
end

enum = pow10(10_000)
p enum.next
p enum.next
p enum.next

enum.each {|x| p x}