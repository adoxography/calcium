require "./calcium/*"

module Calcium
  VERSION = {{ `shards version "#{__DIR__}"`.chomp.stringify }}

  extend self
end
