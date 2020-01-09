require './lib/calculator'
RSpec.describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calculator = Calculator.new
      expect(calculator.add(5,2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2,5,6)).to eql(13)
    end
  end

  describe "#multiply" do
    it "returns the product of multiple numbers" do
      calculator = Calculator.new
      expect(calculator.multiply(2,3,4)).to eql(24)
    end
  end

  describe "#substract" do
    it "returns the difference of two numbers" do
      calculator = Calculator.new
      expect(calculator.subtract(5,2)).to eql(3)
    end
  end
end
