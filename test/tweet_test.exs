defmodule TweetTest do
  alias Twutter.Tweet, as: Tweet
  use ExUnit.Case

  test "it has content, an author, and a timestamp" do
    date = :erlang.now()
    tweet = Tweet.init("Some content", "knewter", date)
    assert "Some content" == tweet.content
    assert "knewter" == tweet.author
    assert date == tweet.timestamp
  end

  test "it outputs its content formatted nicely" do
    date = :erlang.now()
    tweet = Tweet.init("Some content", "knewter", date)
    assert "        knewter > Some content" == Tweet.pretty_print(tweet)
  end
end
