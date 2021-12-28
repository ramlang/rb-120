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
puts joe.grade
  