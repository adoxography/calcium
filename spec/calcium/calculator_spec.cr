require "../spec_helper"

module Calcium
  describe "#calculate" do
    it "adds numbers" do
      calculate("1+2").should eq(3)
    end

    it "subtracts numbers" do
      calculate("1-2").should eq(-1)
    end

    it "multiplies numbers" do
      calculate("1*2").should eq(2)
    end

    it "divides numbers" do
      calculate("1/2").should eq(0.5)
    end

    it "raises numbers to powers" do
      calculate("3^2").should eq(9)
    end

    it "calculates factorial" do
      calculate("5!").should eq(120)
    end

    it "negates numbers" do
      calculate("-5").should eq(-5)
    end

    it "negates expressions" do
      calculate("-(2+4)").should eq(-6)
    end

    it "handles complex expressions" do
      calculate("9 ^ 0 + 2! * 3 / (5 - 3)").should eq(4)
    end

    it "raises an exception when dividing by 0" do
      expect_raises(DivisionByZeroError) do
        calculate("2/0")
      end
    end

    it "raises an exception when taking the factorial of a negative number" do
      expect_raises(NegativeFactorialError) do
        calculate("(-1)!")
      end
    end

    it "rasises an exception when taking the factorial of a fractional number" do
      expect_raises(NonIntegerFactorialError) do
        calculate("0.5!")
      end
    end
  end
end
