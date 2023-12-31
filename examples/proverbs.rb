# This shows how to run the proverbs guidance program in the README on https://github.com/microsoft/guidance
require "./lib/guidance" unless defined?(Guidance)

# set the default language model used to execute guidance programs
Guidance.llm = Guidance.llms.OpenAI("text-davinci-003")

# define a guidance program that adapts a proverb
program = Guidance::Program.new(
  %Q(Tweak this proverb to apply to model instructions instead.

{{proverb}}
- {{book}} {{chapter}}:{{verse}}

UPDATED
Where there is no guidance{{gen 'rewrite' stop="\\n-"}}
- GPT {{#select 'chapter'}}9{{or}}10{{or}}11{{/select}}:{{gen 'verse'}})
)

# execute the program on a specific proverb
executed_program = program.call(
  proverb: "Where there is no guidance, a people falls,\nbut in an abundance of counselors there is safety.",
  book: "Proverbs",
  chapter: 11,
  verse: 14
)

puts executed_program
