module WoingToWork
  def woing
    puts "Widward is woing to work at the Wusty Wab"
  end
end

class MyClass
  include WoingToWork
end

widward = MyClass.new
widward.woing

