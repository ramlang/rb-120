# *** Question 1 ***
# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

# true
# "hello"
# [1, 2, 3, "happy days"]
# 142

# my_answer =>
# all of them are objects and you can find out what class the objects belong to by calling the #class method
p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class


# *** Question 2 ***
# If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# my_answer =>
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed # => use the include keyword and module name
  
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed # => use the include keyword and module name
  
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

car = Car.new.go_fast
truck = Truck.new.go_fast


# *** Question 3 ***
# When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

small_car = Car.new
small_car.go_fast # => I am a Car and going super fast!

# my_answer =>
# This is done by the object calling the #go_fast method having the #class method called on it during string interpolation. The `self.class` expression returns the name of the class of the object, in this case the Car or Truck objects. Notice that the word Car is capitalized as well.

# correct_answer =>
# 1. self refers to the object itself, in this case either a Car or Truck object
# 2. We ask self to tell us its class with .class
# 3. We don't need to use to_s here because it is inside of a string and is interpolated which means it will take care of the to_s for us.


# *** Question 4 ***
# If we have a class AngryCat how do we create a new instance of this class?

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# my_answer =>
# We create a new instance by using the following syntax...
genji = AngryCat.new


# *** Question 5 ***
# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# my_answer =>
# The Pizza class has an instance variable and we can tell by the @ prepended to @name that it is an instance variable

# correct_answer =>
# we can ask each of these objects if they have instance variables.
hot_pizza.instance_variables
# => [:@name]
orange.instance_variables
# => []
# if we call the instance_variables method on the instance of the class we will be informed if the object has any instance variables and what they are.


# *** Question 6 ***
# What could we add to the class below to access the instance variable @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

# my_answer =>
# we can add a getter method or use attr_reader or attr_accessor to create these methods for us

# correct_answer =>
# Technically we don't need to add anything at all. We are able to access instance variables directly from the object by calling instance_variable_get on the instance.
big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")
# => 5000

# better to add a method to this object that returns the instance variable...
  def get_volume
    @volume
  end
  

# *** Question 7 ***
# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

# The default return is the object_id or where it is stored in memeory; we should be able to check the Ruby docs to be sure
# From documentation:
# to_s → stringclick to toggle source
# Returns a string representing obj. The default to_s prints the object's class and an encoding of the object id. As a special case, the top-level object that is the initial execution context of Ruby programs returns “main''.


# *** Question 8 ***
# What does self refer to here?
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# my_answer =>
# self refers to the instance of the class or the object; and because #age is being called on the instance, the age of the object will be returned and then incremented by 1

# correct_answer =>
# Firstly it is important to note that make_one_year_older is an instance method and can only be called on instances of the class Cat. Keeping this in mind the use of self here is referencing the instance (object) that called the method - the calling object.


# *** Question 9 ***
# In the name of the cats_count method we have used self. What does self refer to in this context?
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# my_answer =>
# in this context self is referring to the class and cats_count is a class method that can only be called on the Cat class


# *** Question 10 ***
# If we have the class below, what would you need to call to create a new instance of this class.
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# my_answer =>
paperbag = Bag.new(brown, paper)
