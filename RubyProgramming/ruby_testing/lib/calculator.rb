class Calculator
  def add(*args)
    args.sum
  end
  
  def multiply(*args)
    args.inject { |product, x| product * x }
  end
end
