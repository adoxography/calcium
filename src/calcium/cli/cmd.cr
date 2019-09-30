require "../../calcium"

module Calcium::Cli
  extend self

  def run(args = ARGV)
    result = Calcium.calculate args.shift
    puts Calcium.format(result)
  rescue e : DivisionByZeroError | NegativeFactorialError
    puts "undefined"
  rescue e : Calcium::CalciumException
    puts e.message
  end
end
