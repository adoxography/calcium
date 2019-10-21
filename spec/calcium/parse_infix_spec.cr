require "../spec_helper"

module Calcium
  describe "#parse_infix" do
    it "parses addition" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("+"),
        NumberToken.new("2")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("+")
      ])
    end

    it "parses multiplication" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("*"),
        NumberToken.new("2")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("*")
      ])
    end

    it "parses parentheses" do
      input = [
        ParenToken.new("("),
        NumberToken.new("1"),
        OperatorToken.new("*"),
        NumberToken.new("2"),
        ParenToken.new(")")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("*")
      ])
    end

    it "parses factorial" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("!")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        OperatorToken.new("!")
      ])
    end

    it "parses unary negation" do
      input = [
        OperatorToken.new("u-"),
        NumberToken.new("5")
      ]

      parse_infix(input).should eq([
        NumberToken.new("5"),
        OperatorToken.new("u-")
      ])
    end

    it "parses unary negation of a parenthesized expression" do
      input = [
        OperatorToken.new("u-"),
        ParenToken.new("("),
        NumberToken.new("5"),
        OperatorToken.new("+"),
        NumberToken.new("2"),
        ParenToken.new(")")
      ]

      parse_infix(input).should eq([
        NumberToken.new("5"),
        NumberToken.new("2"),
        OperatorToken.new("+"),
        OperatorToken.new("u-")
      ])
    end

    it "gives unary negation higher precedence than multiplication" do
      input = [
        OperatorToken.new("u-"),
        NumberToken.new("5"),
        OperatorToken.new("*"),
        NumberToken.new("2"),
      ]

      parse_infix(input).should eq([
        NumberToken.new("5"),
        OperatorToken.new("u-"),
        NumberToken.new("2"),
        OperatorToken.new("*")
      ])
    end

    it "gives multiplication higher precedence than addition" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("+"),
        NumberToken.new("2"),
        OperatorToken.new("*"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        NumberToken.new("3"),
        OperatorToken.new("*"),
        OperatorToken.new("+")
      ])
    end

    it "gives division higher precedence than subtraction" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("-"),
        NumberToken.new("2"),
        OperatorToken.new("/"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        NumberToken.new("3"),
        OperatorToken.new("/"),
        OperatorToken.new("-")
      ])
    end

    it "gives exponentiation higher precedence than multiplication" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("*"),
        NumberToken.new("2"),
        OperatorToken.new("^"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        NumberToken.new("3"),
        OperatorToken.new("^"),
        OperatorToken.new("*")
      ])
    end

    it "gives factorial higher precedence than exponentiation" do
      input = [
        NumberToken.new("2"),
        OperatorToken.new("!"),
        OperatorToken.new("^"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("2"),
        OperatorToken.new("!"),
        NumberToken.new("3"),
        OperatorToken.new("^")
      ])
    end

    it "gives addition and subtraction equal precedence" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("+"),
        NumberToken.new("2"),
        OperatorToken.new("-"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("+"),
        NumberToken.new("3"),
        OperatorToken.new("-")
      ])
    end

    it "gives multiplication and division equal precedence" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("*"),
        NumberToken.new("2"),
        OperatorToken.new("/"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("*"),
        NumberToken.new("3"),
        OperatorToken.new("/")
      ])
    end

    it "gives factorial higher precedence than negation" do
      input = [
        OperatorToken.new("u-"),
        NumberToken.new("3"),
        OperatorToken.new("!")
      ]

      parse_infix(input).should eq([
        NumberToken.new("3"),
        OperatorToken.new("!"),
        OperatorToken.new("u-")
      ])
    end

    it "gives parenthetical expressions highest precedence" do
      input = [
        ParenToken.new("("),
        NumberToken.new("1"),
        OperatorToken.new("+"),
        NumberToken.new("2"),
        ParenToken.new(")"),
        OperatorToken.new("*"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        OperatorToken.new("+"),
        NumberToken.new("3"),
        OperatorToken.new("*")
      ])
    end

    it "treats exponentiation as right-associative" do
      input = [
        NumberToken.new("1"),
        OperatorToken.new("^"),
        NumberToken.new("2"),
        OperatorToken.new("^"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("2"),
        NumberToken.new("3"),
        OperatorToken.new("^"),
        OperatorToken.new("^")
      ])
    end

    it "parses functions" do
      input = [
        OperatorToken.new("sin"),
        NumberToken.new("1")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        OperatorToken.new("sin")
      ])
    end

    it "gives functions greater precedence than operators" do
      input = [
        ParenToken.new("("),
        OperatorToken.new("sin"),
        NumberToken.new("1"),
        ParenToken.new(")"),
        OperatorToken.new("+"),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        OperatorToken.new("sin"),
        NumberToken.new("3"),
        OperatorToken.new("+")
      ])
    end

    it "ignores commas" do
      input = [
        OperatorToken.new("max"),
        NumberToken.new("1"),
        CommaToken.new(","),
        NumberToken.new("3")
      ]

      parse_infix(input).should eq([
        NumberToken.new("1"),
        NumberToken.new("3"),
        OperatorToken.new("max")
      ])
    end

    it "raises an error when there is no closing parenthesis" do
      input = [ ParenToken.new("(") ] of Token

      expect_raises(ParseException) do
        parse_infix input
      end
    end

    it "raises an error when there is no opening parenthesis" do
      input = [ ParenToken.new(")") ] of Token

      expect_raises(ParseException) do
        parse_infix input
      end
    end
  end
end
