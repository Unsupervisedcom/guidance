# Wraps https://github.com/microsoft/guidance/blob/main/guidance/_program.py
module Guidance
  class Program
    attr_reader :python_guidance_program
    def initialize(template, python_guidance_program: nil, **kwargs)
      @python_guidance_program = python_guidance_program
      @python_guidance_program ||= PythonGuidance.call(
        template,
        **{
          streaming: false,
          async_mode: false,
          silent: true,
          log: true,
          llm: Guidance.llm
        }.merge(kwargs)
      )
    end

    def [](key) = variables[key]
    
    def []=(key, value)
      @python_guidance_program.variables[key] = value
    end

    def call(wrap_result: true, **kwargs)
      result = python_guidance_program.call(**kwargs).tap do |result|
        # Guidance hides exceptions in an _exception attribute so we pull that
        # out and raise it if it exists.
        Guidance.raise_if_python_exception(result._exception)
      end
      result = Program.new(nil, python_guidance_program: result) if wrap_result
      result
    end

    def call!(**kwargs)
      @python_guidance_program = call(wrap_result: false, **kwargs)
      self
    end

    def prompt = python_guidance_program.to_s

    # This returns the variables as a hash. Note that they are frozen.
    # You can set individual values directly on Progam via []= but not
    # via permuting the returned results in the hash
    def variables
      # We go through JSON to ensure we get Ruby types
      variables = JSON.parse(variables_json)
      deep_freeze variables
    end

    alias :run :call
    alias :run! :call!

    private
    def deep_freeze(obj)
      return obj if obj.respond_to? :__pyptr__ # Don't freeze PyCall objects
      if obj.is_a?(Hash)
        obj.each_value { |v| deep_freeze(v) }
      elsif obj.is_a?(Enumerable) && !obj.is_a?(String)
        obj.each { |v| deep_freeze(v) }
      end
      obj.freeze
    end

    # LLM does not serialize so we return it separately
    def variables_json
      variables = @python_guidance_program.variables
      variables.pop("llm")
      variables.pop("@raw_prefix")
      PythonJson.dumps variables
    end
  end
end
