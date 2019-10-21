# calcium/parsing.cr
#
# Handles parsing of tokens

module Calcium
  # Converts an array of tokens from infix to postfix
  #
  # @param Array(Calcium::Token) tokens
  # @return Array(Calcium::Token)
  def parse_infix(tokens : Array(Token)) : Array(Token)
    ShuntingYard.new.parse(tokens)
  end

  # Implementation of the Shunting-yard algorithm
  # (https://en.wikipedia.org/wiki/Shunting-yard_algorithm)
  #
  # Converts an array of Calcium::Token from infix to postfix.
  private class ShuntingYard
    def initialize
      @output = [] of Token
      @ops = [] of SyntaxToken
    end

    # Runs the algorithm
    #
    # @param Array(Calcium::Token) tokens
    # @return Array(Calcium::Token)
    def parse(tokens : Array(Token)) : Array(Token)
      @output = [] of Token
      @ops = [] of SyntaxToken

      tokens.each { |token| handle_token(token) }

      until @ops.empty?
        op = @ops.pop
        raise ParseException.new("Unmatched '('") if op.is_a? ParenToken
        @output.push op
      end

      @output
    end

    # Determines what should happen to a single token
    #
    # @param Calcium::Token token
    # @return Void
    private def handle_token(token : Token) : Void
      @output.push token if token.is_a? NumberToken

      if token.is_a? OperatorToken
        if token.function?
          @ops.push token
        elsif token.unary?
          token.prefix? ? @ops.push(token.as(OperatorToken)) : @output.push(token)
        else
          handle_binary_operator(token)
        end
      elsif token.is_a? ParenToken
        @ops.push token.as(ParenToken) if token.left?
        handle_right_paren if token.right?
      end
    end

    # Determines what should happen to a binary operator
    #
    # @param OperatorToken token
    # @return Void
    private def handle_binary_operator(token : OperatorToken) : Void
      while !@ops.empty? \
          && !@ops.last.is_a? ParenToken \
          && (@ops.last.precedence > token.precedence \
              || (@ops.last.precedence == token.precedence \
                  && @ops.last.as(OperatorToken).left_associative?))
        @output.push @ops.pop
      end

      @ops.push token
    end

    # Determines what should happen to a paren token
    #
    # @return Void
    private def handle_right_paren : Void
      until @ops.empty? || @ops.last.is_a? ParenToken
        @output.push @ops.pop
      end

      raise ParseException.new("Unmatched '('") if @ops.empty?
      @ops.pop
    end
  end
end
