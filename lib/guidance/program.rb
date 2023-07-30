# Wraps https://github.com/microsoft/guidance/blob/main/guidance/_program.py
module Guidance
  class Program
    attr_reader :python_guidance_program
    def initialize(template, **kwargs)
      @python_guidance_program = PythonGuidance.call(
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

    def call(**kwargs)
      @python_guidance_program.call(**kwargs).tap do |result|
        # Guidance hides exceptions in an _exception attribute so we pull that
        # out and raise it if it exists.
        Guidance.raise_if_python_exception(result._exception)
      end
    end

    alias :run :call
  end
end
