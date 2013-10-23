defmodule LineTest do
  alias Twutter.Line, as: Line
  use ExUnit.Case

  test "can have content loaded into it" do
    line = Line.init
    assert "" == line.content
    line = Line.load(line, "This is some content")
    assert "This is some content" == line.content
  end
end
