# 1. What is the Prototype Pattern.
# 2. How can we apply this pattern to the class Person.

class Person
  
  def initialize(name)
    @name = name
    @favorite_things = []
  end
  
  def <<(thing)
    @favorite_things << thing
  end
  
  def each(&block)
    @favorite_things.each(&block)
  end
  
end

p1 = Person.new('Donald')
p1 << 'Cheeseburger'
p1 << 'Pretty girls'
p1 << 'Non fake news'

p1.each {|x| p x}
