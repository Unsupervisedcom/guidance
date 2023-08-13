# Note: There is a workaround in line 29. Details in Guidance issue at
# https://github.com/microsoft/guidance/issues/278

# Ruby version of https://github.com/microsoft/guidance/blob/main/notebooks/chat.ipynb
require "./lib/guidance" unless defined?(Guidance)

Guidance.llm = Guidance.llms.OpenAI("gpt-4")

role_simulator = Guidance::Program.new(%Q(
{{#system~}}
You are a helpful assistant
{{~/system}}
                                           
{{#user~}}
You will answer the user as {{role}} in the following conversation. At every step, I will provide you with the user input, as well as a comment reminding you of your instructions. Never talk about the fact that you are an AI, even if the user asks you. Always answer as {{role}}.
{{#if first_question}}You can also start the conversation.{{/if}}
{{~/user}}
                                           
{{~! The assistant either starts the conversation or not, depending on if this is the first or second agent }}
{{#assistant~}}
Ok, I will follow these instructions.
{{#if first_question}}Let me start the conversation now:
{{role}}: {{first_question}}{{/if}}
{{~/assistant}}

{{~! Then the conversation unrolls }}
{{~#geneach 'conversation' stop=False}}
{{#user~}}
User: {{set 'this.input' (await 'input') hidden=False}}
Comment: Remember, answer as a {{role}}. Start your utterance with {{role}}:
{{~/user}}

{{#assistant~}}
{{gen 'this.response' temperature=0 max_tokens=300}}
{{~/assistant}}
{{~/geneach}}
))

republican = role_simulator.call(role: 'Republican', await_missing: true)
democrat = role_simulator.call(role: 'Democrat', await_missing: true)

first_question = "What do you think is the best way to stop inflation?"
republican.call!(input: first_question, first_question: nil)
democrat.call!(input: republican["conversation"][-2]["response"].gsub('Republican: ', ""), first_question: first_question)
2.times do
  republican.call!(input: democrat["conversation"][-2]["response"].gsub('Democrat: ', ''))
  democrat.call!(input: republican["conversation"][-2]["response"].gsub('Republican: ', ''))
  # This is an extra demo section to demonstrate serializing and deserializing programs as it is an important
  # part of the flow that Guidance itself never really shows
  stored_republican = Guidance::Serializer.serialize republican
  republican = Guidance::Serializer.deserialize stored_republican
end
puts('Democrat: ' + first_question)
democrat['conversation'][0..-2].map do |x|
  puts("Republican: #{x['input']}")
  puts ""
  puts(x['response'])
end
