require "json"

# See https://github.com/microsoft/guidance/issues/63 on the state of serialization in Guidance
module Guidance
  module Serializer
    PROMPT_KEY = "prompt_text".freeze
    ARGUMENTS_KEY = "arguments".freeze

    SERIALIZERS = {
      hash: proc { |hash_of_state| hash_of_state },
      json: proc { |hash_of_state| JSON.generate(hash_of_state) }
    }.freeze

    DESERIALIZERS = {
      hash: proc { |hash_of_state| hash_of_state },
      json: proc { |json_string| JSON.parse json_string }
    }.freeze

    # Returns a serialized version of the program in the format requested
    # IMPT: We don't capture the LLM itself as it does not serialize and is hard to introspect
    def self.serialize(program, format: :json)
      serializer = SERIALIZERS[format.to_sym]
      raise ArgumentError, "Allowed formats are: #{SERIALIZERS.keys.join ", "}" unless serializer
      
      hash_of_state = {
        ARGUMENTS_KEY => program.variables.to_h,
        PROMPT_KEY => program.prompt
      }
      serializer.call hash_of_state
    end

    def self.deserialize(serialized_form, format: :json, argument_overrides: {})
      deserializer = DESERIALIZERS[format.to_sym]
      raise ArgumentError, "Allowed formats are: #{DESERIALIZERS.keys.join ', '}" unless deserializer

      hash_of_state = deserializer.call serialized_form
      Program.new(hash_of_state[PROMPT_KEY], **hash_of_state[ARGUMENTS_KEY].merge(argument_overrides))
    end
  end
end
