require "pycall"
require_relative "guidance/version"

# Guidance in python is a module that is then also defined as a class.
# The result is that the PyCall version is neither a class nor a module.
# Therefore we can't trivially open it. Instead, we define the functionality
# that we want in modules and then include them in the PyCall version.
PythonGuidance = PyCall.import_module("guidance")
Kernel.const_set :PythonGuidance, PythonGuidance
PythonJson = PyCall.import_module("json")
Kernel.const_set :PythonJson, PythonJson

# Remember to load these AFTER defining PythonGuidance
require_relative "guidance/program"
require_relative "guidance/llms"
require_relative "guidance/serializer"

module Guidance
  autoload :Program, "guidance/program"
  autoload :Version, "guidance/version"
  autoload :LLMs, "guidance/llms"
  autoload :Serializer, "guidance/serializer"

  def self.llm=(llm)
    Thread.current[:guidance_llm] = llm
    PythonGuidance.llm = llm
  end

  def self.llm
    Thread.current[:guidance_llm]
  end

  def self.llms = @llms ||= LLMs.new

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
