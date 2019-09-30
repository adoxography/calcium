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
    }
  }
end
