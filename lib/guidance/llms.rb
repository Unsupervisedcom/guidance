require "pycall"
require "delegate"
# Wraps the list of LLMs in Guidance so that they can be instantiated cleanly
# and listed
module Guidance
  class LLMs < SimpleDelegator
    LLM_LIST = []
    inspect = PyCall.import_module("inspect")
    inspect.getmembers(PythonGuidance.llms).each do |name, llm|
      if inspect.isclass(llm)
        LLM_LIST << llm
        define_method(name) do |*args, **kwargs|
          llm.new(*args, **kwargs)
        rescue PyCall::PyError => e
          # This error is usually because someone called the LLM with .new like normal
          # Ruby instead of the syntax in Python like Guidance.llms.OpenAI(args).
          # In this case, we return the LLM class so that .new will work.
          llm
        end
      end
    end

    def initialize
      super(LLM_LIST)
    end

    # IMPT: This is a delegator so all the methods of the LLM_LIST pass through
  end
end