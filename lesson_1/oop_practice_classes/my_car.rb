class Vehicle
  attr_accessor :year, :color, :model
  @@number_of_subclasses = 0
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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
  
  def get_age
    "This vehicle is #{age} years old"
  end
  
  private
  def age
    t = Time.new
    age_of_car = t.year - year
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
  end

end

class MyTruck < Vehicle
  TYPE = "truck"
  include OffRoadable
  
  def initialize(year, color, model)
    super(year, color, model)
  end
  
end

mini = MyCar.new(2020, "blue", "Mini Cooper")
ford = MyTruck.new(2018, "black", "Ford Raptor")

puts Vehicle.total_number_of_subclasses
puts ford.four_wheel_drive
puts mini.get_age

puts ford.get_age
puts ford.age # unable to access age method 