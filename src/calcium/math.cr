struct Float
  def factorial
    self == 0 ? 1 : self * (self - 1).factorial
  end
end

class NegativeFactorialError < Exception
  def initialize(message = "Factorial of a negative number")
    super(message)
  end
end

class NonIntegerFactorialError < Exception
  def initialize(message = "Factorial of a non-integer number")
    super(message)
  end
end

def add(args)
  raise ArgumentError.new if args.size != 2
  args[0] + args[1]
end

def subtract(args)
  raise ArgumentError.new if args.size != 2
  args[0] - args[1]
end

def multiply(args)
  raise ArgumentError.new if args.size != 2
  args[0] * args[1]
end

def divide(args)
  raise ArgumentError.new if args.size != 2
  raise DivisionByZeroError.new if args[1] == 0
  args[0] / args[1]
end

def power(args)
  raise ArgumentError.new if args.size != 2
  args[0] ** args[1]
end

def factorial(args)
  raise ArgumentError.new if args.size != 1
  raise NegativeFactorialError.new if args[0] < 0
  raise NonIntegerFactorialError.new if (args[0] % 1).abs > 0.00000001
  args[0].factorial
end

def negate(args)
  raise ArgumentError.new if args.size != 1
  args[0] * -1
end
