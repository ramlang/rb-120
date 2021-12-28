# --- The Object Model ---

# Exercise 1
# We create an object in Ruby from a class and using the #new class method. An example of this is:

# Ex. 1 Answer >> We create an object by defining a class and instantiating it by using the .new method to create an instance, also known as an object.

class Widward
  
end

player_1 = Widward.new

# Exercise 2
# A module is similar to a class but is capable of being used on multiple objects. You can use them within classes by using the `include` keyword and mixing them into a class.

# Ex. 2 Answer >> A module allows us to group reusable code into one place. We use modules in our classes by using the include method invocation, followed by the module name. Modules are also used as a namespace.

module WoingToWork
  def woing
    puts "Widward is woing to work at the Wusty Wab"
  end
end

class Widward
  include woing
end

player_1 = Widward.new
player_1.WoingToWork


# --- Classes and Objects - Part 1 ---

# Exercise 1

    class MyCar
      def initialize(year, color, model)
        @year = year
        @color = color
        @model = model
        @speed = 0
      end
        
      def speedup(speed)
        @speed += speed
      end
      
      def brake(speed)
        @speed -= speed
      end
      
      def stop
        @speed = 0
      end
      
      def get_info
        "I'm driving a #{@color} #{@year} #{@model} at #{@speed} mph."
      end
      
    end
    
    mini = MyCar.new(2020, "blue", "Mini Cooper")
    mini.speedup(20)
    puts mini.get_info
    
    mini.brake(5)
    puts mini.get_info
    
    mini.stop
    puts mini.get_info


# Ex. 1 Answer >>
  class MyCar
  
    def initialize(year, model, color)
      @year = year
      @model = model
      @color = color
      @current_speed = 0
    end
  
    def speed_up(number)
      @current_speed += number
      puts "You push the gas and accelerate #{number} mph."
    end
  
    def brake(number)
      @current_speed -= number
      puts "You push the brake and decelerate #{number} mph."
    end
  
    def current_speed
      puts "You are now going #{@current_speed} mph."
    end
  
    def shut_down
      @current_speed = 0
      puts "Let's park this bad boy!"
    end
  end
  
  lumina = MyCar.new(1997, 'chevy lumina', 'white')
  lumina.speed_up(20)
  lumina.current_speed
  lumina.speed_up(20)
  lumina.current_speed
  lumina.brake(20)
  lumina.current_speed
  lumina.brake(20)
  lumina.current_speed
  lumina.shut_down
  lumina.current_speed

# Exercise 2
    attr_accessor :color
    attr_reader :year

# Ex. 2 Answer >>
  class MyCar
    attr_accessor :color
    attr_reader :year
    # ... rest of class left out for brevity
  end
  
  lumina.color = 'black'
  puts lumina.color
  puts lumina.year
  

# Exercise 3
    def spray_paint(color)
      self.color= color
      puts "Your car is painted the color #{color}"
    end

# Ex. 3 Answer >>
  class MyCar
    attr_accessor :color
    attr_reader :year
  
    # ... rest of class left out for brevity
  
    def spray_paint(color)
      self.color = color
      puts "Your new #{color} paint job looks great!"
    end
  end
  
  lumina.spray_paint('red')   #=> "Your new red paint job looks great!"

# --- Classes and Objects - Part 2 ---

# Exercise 1

def self.gas_mileage(gallons, miles)
    miles.to_f/gallons
end

# Ex. 1 Answer >>
class MyCar

  # code omitted for brevity...

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

MyCar.gas_mileage(13, 351)  # => "27 miles per gallon of gas"

# Exercise 2

  def to_s
    "I'm driving a #{@color} #{@year} #{@model} at #{@speed} mph."
  end
  
  puts mini

# Ex. 2 Answer >>
class MyCar
  # code omitted for brevity...

  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end

my_car = MyCar.new("2010", "Ford Focus", "silver")
puts my_car  # => My car is a silver, 2010, Ford Focus.

## Note the "puts" calls "to_s" automatically.

# Exercise 3
# The error in this problem is that only the getter method was created using attr_reader. This means that only the name object can be retrieved not set to a new value. This can be fixed by using attr_writer or attr_accessor instead of attr_reader at the beginning of the class.


# --- Inheritance ---

# Exercise 1
class Vehicle
  attr_accessor :year, :color, :model
  
   def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
  end
  
  def speedup(speed)
    @speed += speed
  end
  
  def brake(speed)
    @speed -= speed
  end
  
  def self.gas_mileage(gallons, miles)
    miles.to_f/gallons
  end
  
  def get_info
    "I'm driving a #{self.color} #{self.year} #{self.model} at #{@speed} mph."
  end
end


class MyCar < Vehicle
  TYPE = "car"
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end
end

class MyTruck < Vehicle
  TYPE = "truck"
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end

end

mini = MyCar.new(2020, "blue", "Mini Cooper")
ford = MyTruck.new(2018, "black", "Ford Raptor")


# Ex. 1 Answer >>
class Vehicle
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end

# Exercise 2
class Vehicle
  attr_accessor :year, :color, :model
  @@number_of_subclasses = 0
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @@number_of_subclasses += 1
  end
  
  def self.gas_mileage(gallons, miles)
    miles.to_f/gallons
  end
  
  def self.total_number_of_subclasses
    @@number_of_subclasses
  end
  
end


class MyCar < Vehicle
  TYPE = "car"
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end

end

class MyTruck < Vehicle
  TYPE = "truck"
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end
  
end

mini = MyCar.new(2020, "blue", "Mini Cooper")
ford = MyTruck.new(2018, "black", "Ford Raptor")

puts Vehicle.total_number_of_subclasses

# Ex. 2 Answer >>
class Vehicle
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  #code omitted for brevity...
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
end


# Exercise 3
class Vehicle
  attr_accessor :year, :color, :model
  @@number_of_subclasses = 0
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @@number_of_subclasses += 1
  end
  
  def self.gas_mileage(gallons, miles)
    miles.to_f/gallons
  end
  
  def self.total_number_of_subclasses
    @@number_of_subclasses
  end
  
  def get_info
    "I'm driving a #{self.color} #{self.year} #{self.model} at #{@speed} mph."
  end
  
end

module OffRoadable
  def four_wheel_drive
    "This vehicle has 4WD"
  end
end


class MyCar < Vehicle
  TYPE = "car"
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end

end

class MyTruck < Vehicle
  TYPE = "truck"
  include OffRoadable
  
  def initialize(year, color, model)
    super(year, color, model)
    @speed = 0
  end
  
end

mini = MyCar.new(2020, "blue", "Mini Cooper")
ford = MyTruck.new(2018, "black", "Ford Raptor")

puts Vehicle.total_number_of_subclasses
puts ford.four_wheel_drive

# Ex. 3 Answer >>
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "This program has created #{@@number_of_vehicles} vehicles"
  end

  def initialize
    @@number_of_vehicles += 1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  #code omitted for brevity...
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
end


# Exercise 4
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

# Ex. 4 Answer >>
# code omitted for brevity...

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors


# Exercise 5
# See Exercise 1...

# Exercise 6

# code omitted...
  def get_age
    "This vehicle is #{age} years old"
  end

  private
  def age
    t = Time.new
    age_of_car = t.year - year
  end
  
puts mini.get_age
puts ford.get_age
puts ford.age # unable to access age method outside because it is private

# Ex. 6 Answer >>
class Vehicle
  # code omitted for brevity...
  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

# code omitted for brevity...

puts lumina.age   #=> "Your chevy lumina is 17 years old"


# Exercise 7
class Student
  attr_accessor :name
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(name)
    get_grade > name.get_grade
  end
  
  def get_grade
    grade
  end
  
  private
  attr_reader :grade
  
end

joe = Student.new("joe", 100)
bob = Student.new("bob", 80)
puts "Well done!" if joe.better_grade_than?(bob)


# Ex. 7 Answer >>
class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than?(bob)


# Exercise 8
# The problem is that the `hi` method is private so it cannot be called from outside the class
# This can be fixed by moving the `hi` method to a different position within the class
# or by making another method within the class to call the method


# Ex. 8 Answer >>
# The problem is that the method hi is a private method, therefore it is unavailable to the object. I would fix this problem by moving the hi method above the private method call in the class.

