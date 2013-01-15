class Module
  def attr_checked (symbol, &code)
    var = ('@' + symbol.to_s)
    define_method(symbol) { instance_variable_get(var) }  
    define_method(symbol.to_s + "=") { |val| if yield(val) 
                                               instance_variable_set(var, val) 
                                             else 
                                               raise Excepion
                                             end}
  end
end

class Cat 
  
  attr_checked :legs do |n|
    n == 4
  end
 
  attr_checked :age do |n|
    n < 30
  end

end


garfield = Cat.new
puts garfield.age = 5   # => 5
puts garfield.age       # => 5
garfield.age = 45       # => Exception
garfield.legs = 8       # => Exception
