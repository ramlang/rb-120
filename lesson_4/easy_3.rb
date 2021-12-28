# *** Question 1 ***
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:
# case 1:
hello = Hello.new
hello.hi

# my_answer =>
# "Hello"

# case 2:
hello = Hello.new
hello.bye

# my_answer =>
# "Goodbye"

# correct_answer =>
# Error undefined method

# case 3:
hello = Hello.new
hello.greet

# my_answer =>
# Error

# case 4:
hello = Hello.new
hello.greet("Goodbye")

# my_answer =>
# "Goodbye"

# case 5:
Hello.hi

# my_answer =>
# Error


# *** Question 2 ***
# If we call Hello.hi we get an error message. How would you fix this?
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# my_answer =>
# Change the method name to def self.hi; greet("Hello"); end

# correct_answer =>
class Hello
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

# Note that we cannot simply call greet in the self.hi method definition because the Greeting class itself only defines greet on its instances, rather than on the Greeting class itself.


# *** Question 3 ***
# Given the class below, how do we create two different instances of this class with separate names and ages?
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# my_answer =>
genji = AngryCat.new(4, "Genji")
leia = AngryCat.new(3, "Leia")


# *** Question 4 ***
# Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"
class Cat
  def initialize(type)
    @type = type
  end
end
# How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

# my_answer =>
def to_s
  "I am a #{@type} cat"
end

# correct_answer =>
class Cat
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end


# *** Question 5 ***
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer
tv.model

Television.manufacturer
Television.model

# my_answer =>
# tv.manufacturer => Error
# tv.model => output
# Television.manufacturer => output
# Television.model => Error

# example_of_answer =>
# tv.manufacturer would get an error: undefined method manufacturer for #<Television:XXXX>; this is because tv is an instance of the class Television and manufacturer is a class method, meaning it can only be called on the class itself

# if you tried to call Television.model, the error be NoMethodError: undefined method 'model' for Television:Class; this is because this method only exists on an instance of the class Television in this case tv.


# *** Question 6 ***
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
# In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

# my_answer =>
  def make_one_year_older
    age += 1
  end
  
# correct_answer =>
# self in this case is referencing the setter method provided by attr_accessor - this means that we could replace self with @. 
  def make_one_year_older
    @age += 1
  end
  
  
# *** Question 7 ***
# What is used in this class but doesn't add any value?
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# my_answer =>
# return statement
# @brightness & @color

# correc_answer =>
# return
# these methods do add potential value, as they give us the option to alter brightness and color outside the Light class.