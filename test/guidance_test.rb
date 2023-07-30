require "test_helper"

class GuidanceTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GuidanceLib::VERSION
  end

  def test_can_initialize_guidance_lib
    Guidance.llm = Guidance.llms.OpenAI("text-davinci-003")
  end
end
