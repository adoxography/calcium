module Calcium
  def calculate(input)
    infix_tokens = Calcium.tokenize input
    postfix_tokens = Calcium.parse_infix infix_tokens
    Calcium.calculate_postfix postfix_tokens
  end

  def calculate_postfix(tokens : Array(Token))
    stack = [] of NumberToken

    tokens.each do |token|
      if token.is_a? OperatorToken
        num_args = token.num_args
        if stack.size < num_args
          raise CalculateException.new("Unexpected operator #{token}")
        end

        stack.push token.call(stack.pop num_args)
      elsif token.is_a? NumberToken
        stack.push token
      end
    end

    stack.pop.to_f
  end
end
