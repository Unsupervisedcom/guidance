require "test_helper"
require "guidance"

class ProgramTest < Minitest::Test
  def test_python_library_loads
    Guidance::Program.new
  end
end
