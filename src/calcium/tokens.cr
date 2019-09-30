module Calcium
  def tokenize(string)
    number_pattern = NumberToken::PATTERN
    paren_pattern = ParenToken::PATTERN
    op_pattern = OperatorToken::PATTERN
    err_pattern = /\S+/

    all_pattern = [
      number_pattern,
      op_pattern,
      paren_pattern,
      err_pattern
    ].join("|")

    string = preprocess string
    matches = string.scan /#{all_pattern}/

    matches.map do |match|
      if match[0] =~ /^#{number_pattern}$/
        NumberToken.new(match[0])
      elsif match[0] =~ /^(?:#{op_pattern})$/
        OperatorToken.new(match[0])
      elsif match[0] =~ /^(?:#{paren_pattern})$/
        ParenToken.new(match[0])
      else
        raise TokenizeException.new("Unknown token #{match[0]}")
      end
    end
  end

  private def preprocess(string)
    string.gsub /(?<=^|[+\-*\/^!(])-(?=[\d(])/, "u-"
  end

  abstract class Token
    getter :value

    @value : String

    def initialize(value)
      @value = value.to_s
    end

    def ==(other : String)
      @value == other
    end

    def ==(other : Token)
      @value == other.value
    end

    def to_s(io)
      io << @value
    end
  end

  class NumberToken < Token
    PATTERN = /\d+(?:\.\d+)?/

    def to_f
      @value.to_f
    end
  end

  abstract class SyntaxToken < Token
    abstract def precedence
  end

  class OperatorToken < SyntaxToken
    PATTERN = /#{OPERATORS.keys.map { |key| Regex.escape key.to_s }.join("|")}/

    def data
      OPERATORS[@value]
    end

    def right_associative?
      data[:associativity] == :right
    end

    def left_associative?
      !right_associative?
    end

    def unary?
      data[:num_args] == 1
    end

    def prefix?
      data[:prefix]
    end

    def precedence
      data[:precedence]
    end

    def call(args)
      NumberToken.new(func.call(args.map(&.to_f)))
    end

    private def func
      data[:func]
    end
  end

  class ParenToken < SyntaxToken
    PATTERN = /[()]/

    def left?
      @value == "("
    end

    def right?
      @value == ")"
    end

    def precedence
      0
    end
  end
end
