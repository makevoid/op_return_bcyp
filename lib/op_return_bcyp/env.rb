# TODO:
# require 'pathname'
# # raise Pathname.new($0).inspect
# lib_file = "lib/op_return_bcyp.rb"
# path = File.expand_path "."
# # File.expand_path("lib/op_return_bcyp.rb")
#
# arg0 = File.expand_path $0
#
# if Pathname.new(arg0) == (lib_path = Pathname.new path)
#   require 'bundler/setup'
#   Bundler.require :default
# end

require 'bundler/setup'
Bundler.require :default

# raise [arg0, lib_path].inspect

require_relative 'vendor/caching'
# usage: extend Caching; #...; cache(:key) {; # method; }

module OpReturnBcyp
  HE = HTMLEntities.new

  require_relative 'utils'
end

require_relative 'tx_fetcher'
