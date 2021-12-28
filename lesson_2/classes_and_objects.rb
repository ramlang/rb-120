# Lecture: Classes and Objects

# Problem 1
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end


# Problem 2
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(first_name= '', last_name= '')
    @first_name = first_name
    @last_name = last_name
  end
  
  def name
    @first_name + ' ' + @last_name
  end
end

# answer =>
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parts = full_name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end
# end


# Problem 3
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

   def name= (full_name= @first_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
  
    def name
    "#{first_name} #{last_name}".strip
  end
end

# answer =>
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parse_full_name(full_name)
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     parse_full_name(full_name)
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.size > 1 ? parts.last : ''
#   end
# end


# Problem 4
bob.name == rob.name


# Problem 5
# The output would be not 'Robert Smith' but the place in memory
# This can be fixed by using "#{bob.name}" instead of just #{bob}"

# If we add a #to_s method to the Person class then the output will work
# This is because puts calls the #to_s method and out created method that
# returns name will override Ruby's #to_s method



