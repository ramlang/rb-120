# --- Lecture: Inheritance ---

# Problem 1
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "Can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

molly = Bulldog.new
puts molly.swim


# Problem 2
class Animal
  def run
    "running!"
  end
  
  def jump
    "jumping!"
  end
end

class Dog < Animal
  def speak
    "bark!"
  end
  
  def fetch
    "fetching!"
  end
  
  def swim
    "swimming!"
  end
end

class Cat < Animal
  def speak
    "meow!"
  end
end


# Problem 3

#  Animal
#   /  \
# Cat  Dog
#       |
#      Bulldog


# Problem 4
# The method lookup path is the path Ruby takes to search for a method when it is called.
# It is important because if methods are overriden this will affect which method is called.
# First it searches the object's class, if it can't find it there is will move on to 
# a super class if any, and then Ruby's Object and Kernel classes.

# example_of_answer =>
# The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke. For example, say you have a Bulldog object called bud and you call: bud.swim. Ruby will first look for a method called swim in the Bulldog class, then traverse up the chain of super-classes; it will invoke the first method called swim and stop its traversal.

# In our simple class hierarchy, it's pretty straight forward. Things can quickly get complicated in larger libraries or frameworks. To see the method lookup path, we can use the .ancestors class method.

Bulldog.ancestors       # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]
