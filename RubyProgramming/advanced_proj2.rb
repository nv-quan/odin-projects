module Enumerable
  def my_each
    i = 0
    until i >= self.length do
      yield(self[i])
      i += 1
    end
    self
  end
  def my_each_with_index
    i = 0
    until i >= self.length do
      yield(self[i], i)
      i += 1
    end
    self
  end
  def my_select
    res = Array.new
    self.my_each do |x|
      res.push(x) if yield(x)
    end
    res
  end
  def my_all?
    self.my_each do |x|
      return false unless yield(x)
    end
    true
  end
  def my_none?
    self.my_each do |x|
      return false if yield(x)
    end
    true
  end
  def my_count
    i = 0
    self.my_each do |x|
      i += 1 if yield(x)
    end
   i
  end
  def my_map(*prc)
    res = Array.new
    if !prc.empty?
      self.my_each do |x|
        res.push(prc[0].call(x))
      end
    elsif block_given?
      self.my_each do |x|
        res.push(yield(x))
      end
    end
    res
  end
  def my_inject(*initial)
    val = initial.empty? ? self[0]: initial[0]
    self[1..-1].my_each_with_index do |x, i|
      val = yield(val, x)
    end
    val
  end
end
