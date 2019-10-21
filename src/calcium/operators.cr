module Calcium
  OPERATORS = {
    "+": {
      func: ->add(Array(Float64)),
      precedence: 1,
      num_args: 2,
      associativity: :left,
      prefix: false
    },

    "-": {
      func: ->subtract(Array(Float64)),
      precedence: 1,
      num_args: 2,
      associativity: :left,
      prefix: false
    },

    "*": {
      func: ->multiply(Array(Float64)),
      precedence: 2,
      num_args: 2,
      associativity: :left,
      prefix: false
    },

    "/": {
      func: ->divide(Array(Float64)),
      precedence: 2,
      num_args: 2,
      associativity: :left,
      prefix: false
    },

    "^": {
      func: ->power(Array(Float64)),
      precedence: 3,
      num_args: 2,
      associativity: :right,
      prefix: false
    },

    "!": {
      func: ->factorial(Array(Float64)),
      precedence: 5,
      num_args: 1,
      associativity: :left,
      prefix: false
    },

    "u-": {
      func: ->negate(Array(Float64)),
      precedence: 4,
      num_args: 1,
      associativity: :right,
      prefix: true
    },

    "sin": {
      func: ->(args: Array(Float64)) { Math.sin(args[0]) },
      precedence: 100,
      num_args: 1,
      associativity: :left,
      prefix: false
    },

    "cos": {
      func: ->(args: Array(Float64)) { Math.cos(args[0]) },
      precedence: 100,
      num_args: 1,
      associativity: :left,
      prefix: false
    },

    "tan": {
      func: ->(args: Array(Float64)) { Math.tan(args[0]) },
      precedence: 100,
      num_args: 1,
      associativity: :left,
      prefix: false
    },

    "abs": {
      func: ->(args: Array(Float64)) { args[0].abs },
      precedence: 100,
      num_args: 1,
      associativity: :left,
      prefix: false
    },

    "max": {
      func: ->(args: Array(Float64)) { args.max },
      precedence: 100,
      num_args: 2,
      associativity: :left,
      prefix: false
    },

    "min": {
      func: ->(args: Array(Float64)) { args.min },
      precedence: 100,
      num_args: 2,
      associativity: :left,
      prefix: false
    }
  }
end
