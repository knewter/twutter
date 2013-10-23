defmodule ScreenTest do
  use ExUnit.Case
  alias Twutter.Screen, as: Screen
  alias Twutter.Tweet, as: Tweet

  test "has 30 lines" do
    screen = Screen.init
    assert 30 == Enum.count(screen.lines)
  end

  test "can load data into its lines" do
    screen = Screen.init
    tweet_content = [Tweet.init("This is a tweet", "knewter", :erlang.now())]
    screen = Screen.load_tweets(screen, tweet_content)
    assert "This is a tweet", Enum.at(screen.lines, 0).content
  end

  test "can output itself as a string" do
    screen = Screen.init
    tweet_content = [
      Tweet.init("This is a tweet", "knewter", :erlang.now()),
      Tweet.init("This is a second tweet", "knewter", :erlang.now())
    ]
    screen = Screen.load_tweets(screen, tweet_content)
    expected_output = """
            knewter > This is a tweet
            knewter > This is a second tweet
    """
    trailing_lines = Enum.map(1..27, fn(x) -> "\n" end)
    expected_output = Enum.join([expected_output, trailing_lines])
    assert expected_output == Screen.output(screen)
  end
end
