require "pycall"
require_relative "guidance/version"
require_relative "guidance/program"

# Guidance in python is a module that is then also defined as a class.
# The result is that the PyCall version is neither a class nor a module.
# Therefore we can't trivially open it. Instead, we define the functionality
# that we want in modules and then include them in the PyCall version.
gd = PyCall.import_module("guidance")

# Object.send :remove_const, :Guidance
PythonGuidance = gd

module Guidance
  autoload :Program, "guidance/program"
  autoload :Version, "guidance/version"

  def self.llm=(llm)
    @llm = llm
    PythonGuidance.llm = llm
  end

  def self.llm = @llm

  def self.llms = PythonGuidance.llms

  def self.call(*args, **kwargs)
    Program.new(*args, **kwargs)
  end

  def self.raise_if_python_exception(python_exception)
    return unless python_exception
    raise PyCall::PyError.new(
      python_exception.__class__.__name__,
      python_exception.to_s,
      python_exception.__traceback__
    )
  end
end

