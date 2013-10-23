defmodule Twutter.Line do
  defrecord LineData, content: ""

  def init() do
    LineData.new
  end

  def load(line_data, content) do
    line_data.update(content: content)
  end
end
