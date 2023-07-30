# #require_relative "guidance/version"
# require "pycall/import"
# include PyCall::Import

# PyCall.sys.path << ENV["PYTHONPATH"] if ENV["PYTHONPATH"]
# gd = pyfrom "guidance", import: :Guidance
# #gd::VERSION = Guidance::VERSION
# Object.send :remove_const, :Guidance

# #Guidance = gd
# class Guidance
#   autoload :VERSION, "guidance/version"
#   # autoload :Program, "guidance/program"
# end

# guidance = Guidance

require_relative "guidance/version"
require "pycall"

# Guidance in python is a module that is then also defined as a class.
# The result is that the PyCall version is neither a class nor a module.
# Therefore we can't trivially open it. Instead, we define the functionality
# that we want in modules and then include them in the PyCall version.
gd = PyCall.import_module("guidance")

Object.send :remove_const, :Guidance
Guidance = gd

# def Guidance(str)
#   Guidance.call str
# end
