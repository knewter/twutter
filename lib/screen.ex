defmodule Twutter.Screen do
  defrecord ScreenData, lines: []

  def num_lines, do: 30

  def init do
    # A tuple, the first element is the lines
    lines = Enum.map(1..num_lines, fn(_) -> Twutter.Line.LineData.new end)
    ScreenData.new lines: lines
  end

  def load_tweets(screen_data, tweet_content) do
    new_lines = Enum.map(Enum.with_index(screen_data.lines), fn({line, index}) ->
      tweet = Enum.at(tweet_content, index)
      line.update(content: Twutter.Tweet.pretty_print(tweet))
    end)
    screen_data.update(lines: new_lines)
  end

  def output(screen_data) do
    output_lines = Enum.map(screen_data.lines, fn(line) -> line.content end)
    Enum.join(output_lines, "\n")
  end
end
