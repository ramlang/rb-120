# *** Question 1 ***
# Alyssa has been assigned a task of modifying a class that was initially created to keep track of secret information. The new requirement calls for adding logging, when clients of the class attempt to access the secret data. Here is the class in its current form:

# class SecretFile
#   attr_reader :data

#   def initialize(secret_data)
#     @data = secret_data
#   end
# end
# She needs to modify it so that any access to data must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. The logging class has been supplied to Alyssa and looks like the following:

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

# Hint: Assume that you can modify the initialize method in SecretFile to have an instance of SecurityLogger be passed in as an additional argument. It may be helpful to review the lecture on collaborator objects for this practice problem.

# my_answer =>
class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

class SecretFile
  attr_reader :data

  def initialize(secret_data, records)
    @data = secret_data
    @records = records.create_log_entry
  end
end

# correct_answer =>
class SecretFile
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end

  def data
    @logger.create_log_entry  # <= need to only log when data is accessed
    @data
  end
end


# *** Question 2 ***
# Modify the class definitions and move code into a Module, as necessary, to share code among the Catamaran and the wheeled vehicles.

# my_answer =>
module Drivable 
  def tire_pressure(tire_index)
    self.tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    self.tires[tire_index] = pressure
  end
end

class Vehicle
  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < Vehicle
  include Drivable
  
  def initialize(tire_array)
    # 4 tires are various tire pressures
    super(50, 25.0)
    @tires = [30,30,32,32]
  end
end

class Motorcycle < Vehicle
  include Drivable
  
  def initialize(tire_array)
    # 2 tires are various tire pressures
    super(80, 8.0)
    @tires = [20,20]
  end
end

class Catamaran < Vehicle
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    # ... code omitted ...
  end
end

# correct_answer =>
module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    fuel_capacity * fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable
  
  attr_accessor :speed, :heading
  
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
  
end

class Auto < WheeledVehicle
  def initialize
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    super([20,20], 80, 8.0)
  end
end

class Catamaran < Vehicle
  include Moveable
  
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    # ...
  end
end


# *** Question 3 ***
# Building on the prior vehicles question, we now must also track a basic motorboat. A motorboat has a single propeller and hull, but otherwise behaves similar to a catamaran. Therefore, creators of Motorboat instances don't need to specify number of hulls or propellers. How would you modify the vehicles code to incorporate a new Motorboat class?

# my_answer =>
class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

# correct_answer =>
class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
end

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    # set up 1 hull and 1 propeller
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft
end


# *** Question 4 ***
# The designers of the vehicle management system now want to make an adjustment for how the range of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel.

# Alter the code related to vehicles so that the range for autos and motorcycles is still calculated as before, but for catamarans and motorboats, the range method will return an additional 10km.

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    fuel_capacity * fuel_efficiency
  end
end

class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end
  
  def range # <= override range method in Moveable
    fuel_capacity * fuel_efficiency + 10
  end
end

# correct_answer =>
class Seacraft

  # ... existing Seacraft code omitted ...

  # the following is added to the existing Seacraft definition
  def range
    super + 10
  end
end