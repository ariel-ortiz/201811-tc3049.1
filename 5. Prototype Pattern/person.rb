# 1. What is the Prototype Pattern?
#
# The prototype design pattern enables you to create
# new instances by copying existing instances to avoid
# the overhead involved in creating objects that can
# consume more resources.
#
# 2. How can we apply this pattern to the class Person?

class Person

  attr_reader :name, :favorite_things

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

  # Our new version of clone makes sure that nested
  # referenced objects are also cloned.
  def clone
    new_clone = super
    new_clone.name = @name.clone
    new_clone.favorite_things = @favorite_things.clone
    new_clone
  end

  # Don't violate encapsulation:
  # You can only modify these attributes from
  # within this class.
  protected
  attr_writer :name, :favorite_things
end

p1 = Person.new('Donald')
p1 << 'Cheeseburger'
p1 << 'Pretty girls'
p1 << 'Non fake news'

p p1.to_enum.to_a
p2 = p1.clone
p p2.to_enum.to_a
p2 << 'Ivanka'
p p1.to_enum.to_a
p p2.to_enum.to_a

# There is still some sharing issues one level deeper!
p1.favorite_things[0][0] = 's'
p p2.to_enum.to_a
