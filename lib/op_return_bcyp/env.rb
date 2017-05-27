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

module OpReturnBcyp
  HE = HTMLEntities.new

  # usage: extend Caching; #...; cache(:key) {; # method; } 
  require_relative 'vendor/caching'

  require_relative 'utils'
  include Utils
end
