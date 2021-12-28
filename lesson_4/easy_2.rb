# *** Question 1 ***
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:
oracle = Oracle.new
oracle.predict_the_future

# my_answer =>
# Return a string "You will...[random message]"


# *** Question 2 ***
e have an Oracle class and a RoadTrip class that inherits from the Oracle class.

Copy Code
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:
trip = RoadTrip.new
trip.predict_the_future

# my_answer =>
# returns "You will [random message from Roadtrip.choices]"


# *** Question 3 ***
# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# my_answer =>
# You can find where Ruby will look for a method by using a method lookup chain; to find an object's ancestors you can call #ancestors on the object; the lookup chain for Orange is Orange > Taste > Object > Kernel > BasicObject and it's the samr for HotSauce

# correct_answer =>
# **can only call ancestors on a class; cannot call on an instance of the class
# The list of ancestor classes is also called a lookup chain, because Ruby will look for a method starting in the first class in the chain and eventually lookup BasicObject if the method is found nowhere in the lookup chain.

# If the method appears nowhere in the chain then Ruby will raise a NoMethodError which will tell you a matching method can not be found anywhere in the chain.

# Keep in mind this is a class method and it will not work if you call this method on an instance of a class (unless of course that instance has a method called ancestors).


# *** Question 4 ***
# What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# my_answer =>
# you can add an attr_accessor method and remove the type and type=(t) methods

# correct_answer =>
# there is still something we can improve... inside the describe_type method, we are referencing the @type variable with the @ symbol, but this is not needed. As there is a method in the class which replaces the need to access the instance variable directly we can change the describe_type method to be:

def describe_type
  puts "I am a #{type} type of Bees Wax"
end


# *** Question 5 ***
# There are a number of variables listed below. What are the different types and how do you know which is which?
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

# my_answer =>
# The first is a local variable, the second is a instance variable (prepended @) and the last one is a class variable (prepended @@)


# *** Question 6 ***
# Which one of these is a class method (if any) and how do you know? How would you call a class method?
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# my_answer =>
# class methods have self prepended to the method name. In this case self.manufacturer is a class method. This method can be called by...
Television.manufacturer


# *** Question 7 ***
# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

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
# the @@cats_count variable is a class variable that is incremented each time a new instance of the class is instaniated. In order to test this theory I would create a new Cat object and then call Cat.cats_count

# correct_answer =>
# To test your theory you could print the value of the @@cats_count variable to the screen after it has been incremented, like this:
def initialize(type)
  @type = type
  @age  = 0
  @@cats_count += 1
  puts @@cats_count
end


# *** Question 8 ***
# What can we add to the Bingo class to allow it to inherit the play method from the Game class?
class Game
  def play
    "Start the game!"
  end
end

class Bingo
  def rules_of_play
    #rules of play
  end
end

# my_answer =>
# we can add "< Game" to the end of the "class Bingo" line; this will allow Bingo to inheirt the play method from the Game class


# *** Question 9 ***
# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# my_answer =>
# if we added a play method to the Bingo class then when the play method is called on a Bingo object the method inside the Bingo class would execute instead of the one in the super class Game


# *** Question 10 ***
# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# my_answer =>
# the code is organized in a more readable format
# easier to extract nouns and verbs from real world problems
# in some cases it reduces complexity of the program

# correct_answer =>
# Because there are so many benefits to using OOP we will just summarize some of the major ones:

# Creating objects allows programmers to think more abstractly about the code they are writing.
# Objects are represented by nouns so are easier to conceptualize.
# It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
# It allows us to easily give functionality to different parts of an application without duplication.
# We can build applications faster as we can reuse pre-written code.
# As the software becomes more complex this complexity can be more easily managed.