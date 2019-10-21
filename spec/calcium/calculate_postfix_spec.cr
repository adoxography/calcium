require "../spec_helper"

module Calcium
  describe "#calculate_postfix" do
    it "adds numbers" do
      input = [
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("+")
      ]

      calculate_postfix(input).should eq(3)
    end

    it "subtracts numbers" do
      input = [
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("-")
      ]

      calculate_postfix(input).should eq(-1)
    end

    it "negates numbers" do
      input = [
        NumberToken.new("3"),
        OperatorToken.new("u-")
      ]

      calculate_postfix(input).should eq(-3)
    end

    it "multiplies numbers" do
      input = [
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("*")
      ]

      calculate_postfix(input).should eq(2)
    end

    it "divides whole numbers" do
      input = [
        NumberToken.new("8"),
        NumberToken.new("2"),
        OperatorToken.new("/")
      ]

      calculate_postfix(input).should eq(4)
    end

    it "divides fractional numbers" do
      input = [
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("/")
      ]

      calculate_postfix(input).should eq(0.5)
    end

    it "raises an error when dividing by zero" do
      input = [
        NumberToken.new("1"),
        NumberToken.new("0"),
        OperatorToken.new("/")
      ]

      expect_raises(DivisionByZeroError) do
        calculate_postfix(input)
      end
    end

    it "raises numbers to powers" do
      input = [
        NumberToken.new("2"),
        NumberToken.new("3"),
        OperatorToken.new("^")
      ]

      calculate_postfix(input).should eq(8)
    end

    it "takes the factorial of numbers" do
      input = [
        NumberToken.new("4"),
        OperatorToken.new("!")
      ]

      calculate_postfix(input).should eq(24)
    end

    it "finds the sine of a number" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("sin")
      ]

      calculate_postfix(input).should eq(0.8414709848078965)
    end

    it "finds the cosine of a number" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("cos")
      ]

      calculate_postfix(input).should eq(0.5403023058681398)
    end

    it "finds the tangent of a number" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("tan")
      ]

      calculate_postfix(input).round(15).should eq(1.557407724654902)
    end

    it "finds the absolute value of a number" do
      input = [
        NumberToken.new("-1"),
        OperatorToken.new("abs")
      ]

      calculate_postfix(input).should eq(1)
    end

    it "finds the max of two numbers" do
      input = [
        NumberToken.new("2"),
        NumberToken.new("1"),
        OperatorToken.new("max")
      ]

      calculate_postfix(input).should eq(2)
    end

    it "finds the min of two numbers" do
      input = [
        NumberToken.new("2"),
        NumberToken.new("1"),
        OperatorToken.new("min")
      ]

      calculate_postfix(input).should eq(1)
    end

    it "raises an error when taking the factorial of a negative" do
      input = [
        NumberToken.new("-3"),
        OperatorToken.new("!")
      ]

      expect_raises(NegativeFactorialError) do
        calculate_postfix(input)
      end
    end

    it "raises an error when taking the factorial of a non-integer" do
      input = [
        NumberToken.new("3.5"),
        OperatorToken.new("!")
      ]

      expect_raises(NonIntegerFactorialError) do
        calculate_postfix(input)
      end
    end

    it "handles complex expressions" do
      input = [
        NumberToken.new("2"),
        NumberToken.new("2"),
        OperatorToken.new("^"),
        NumberToken.new("1"),
        NumberToken.new("3"),
        OperatorToken.new("-"),
        OperatorToken.new("/"),
        NumberToken.new("2"),
        OperatorToken.new("*")
      ]

      calculate_postfix(input).should eq(-4)
    end

    it "raises an error if there are no arguments for an operator" do
      input = [
        OperatorToken.new("*")
      ]

      expect_raises(CalculateException) do
        calculate_postfix(input)
      end
    end

    it "raises an error if the arguments are the wrong type" do
      input = [
        NumberToken.new("2"),
        NumberToken.new("2"),
        OperatorToken.new("^"),
        OperatorToken.new("*")
      ]

      expect_raises(CalculateException) do
        calculate_postfix(input)
      end
    end
  end
end
