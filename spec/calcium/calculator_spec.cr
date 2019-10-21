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

    it "calculates sine" do
      calculate("sin 1").should eq(0.8414709848078965)
    end

    it "calculates cosine" do
      calculate("cos 1").should eq(0.5403023058681398)
    end

    it "calculates tangent" do
      calculate("tan 1").round(15).should eq(1.557407724654902)
    end

    it "calculates absolute value" do
      calculate("abs -1").should eq(1)
    end

    it "calculates max" do
      calculate("max 2, 1").should eq(2)
    end

    it "calculates min" do
      calculate("min 2, 1").should eq(1)
    end

    it "handles functions with parentheses" do
      calculate("sin(2+2)").should eq(-0.7568024953079282)
    end

    it "handles functions next to operators" do
      calculate("sin 1 + 1").should eq(1.8414709848078965)
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

    it "handles complex function expressions" do
      calculate("sin(max(2, 3)/3*4)").should eq(-0.7568024953079282)
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
