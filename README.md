# calcium
[![Build Status](https://travis-ci.org/adoxography/calcium.svg?branch=master)](https://travis-ci.org/adoxography/calcium)

`calcium` implements a basic command line calculator.

## Installation

1. Ensure that [crystal](https://crystal-lang.org/reference/installation/) is installed on your system.
2. Clone the repository.
3. To compile the binary, run `make` from the project root. It will be compiled to `bin/calcium`.

## Usage

The `calcium` executable accepts a single equation (as a string) as an argument.

### Without precompiling

`crystal src/cli.cr '1+1'`

### With precompiling

`bin/calcium '1+1'`

## Capabilities

- Basic arithmetic operators (`+`, `-`, `*`, `/`)
- Complex expressions (Parentheses, order of operations)
- Unary negation
- Factorial (`!`)
- Exponentiation (`^`)
- Functions (`sin`, `cos`, `tan`, `abs`, `min`, `max`)

## Testing
`crystal spec` tests the crystal library. `spec/test.sh all` tests the command line interface.

## Contributors

- [adoxography](https://github.com/adoxography) - creator and maintainer
