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


bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

puts bob