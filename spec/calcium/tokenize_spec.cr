require "../spec_helper"

module Calcium
  describe "#tokenize" do
    it "parses numbers" do
      tokenize("5").should eq([ NumberToken.new("5") ])
    end

    it "doesn't parse invalid expressions" do
      expect_raises(TokenizeException) do
        tokenize("$+5")
      end
    end

    it "parses numbers with multiple digits" do
      tokenize("10").should eq([ NumberToken.new("10") ])
    end

    it "parses negative numbers" do
      tokenize("-5").should eq([
        OperatorToken.new("u-"),
        NumberToken.new("5")
      ])
    end

    it "parses floats" do
      tokenize("3.14").should eq([ NumberToken.new("3.14") ])
    end

    it "parses operators" do
      tokenize("+-*/^!").should eq([
        OperatorToken.new("+"),
        OperatorToken.new("-"),
        OperatorToken.new("*"),
        OperatorToken.new("/"),
        OperatorToken.new("^"),
        OperatorToken.new("!")
      ])
    end

    it "parses negatives with subtraction correctly" do
      tokenize("-5--5").should eq([
        OperatorToken.new("u-"),
        NumberToken.new("5"),
        OperatorToken.new("-"),
        OperatorToken.new("u-"),
        NumberToken.new("5")
      ])
    end

    it "parses negatives with functions correctly" do
      tokenize("abs -1").should eq([
        OperatorToken.new("abs"),
        OperatorToken.new("u-"),
        NumberToken.new("1")
      ])
    end

    it "parses subtraction correctly" do
      tokenize("5-5").should eq([
        NumberToken.new("5"),
        OperatorToken.new("-"),
        NumberToken.new("5")
      ])
    end

    it "parses parentheses" do
      tokenize("()").should eq([
        ParenToken.new("("),
        ParenToken.new(")")
      ])
    end

    it "parses functions" do
      tokenize("sin").should eq([ OperatorToken.new("sin") ])
    end

    it "doesn't parse unknown functions" do
      expect_raises(TokenizeException) do
        tokenize("foo")
      end
    end

    it "parses commas" do
      tokenize(",").should eq([ CommaToken.new(",") ])
    end

    it "parses negation of complex expressions" do
      tokenize("-(3)").should eq([
        OperatorToken.new("u-"),
        ParenToken.new("("),
        NumberToken.new("3"),
        ParenToken.new(")")
      ])
    end
  end
end
