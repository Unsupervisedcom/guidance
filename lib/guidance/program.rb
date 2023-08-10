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

    def [](*args) = @python_guidance_program[*args]

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

    def serialize = Guidance.serialize(self)

    alias :run :call
    alias :run! :call!
  end
end
