defmodule TwutterTest do
  use ExUnit.Case

  test "knows where the twitter API is hosted" do
    assert Twutter.api_root == "https://api.twitter.com/1.1/"
  end

  test "knows the home timeline url" do
    assert Twutter.home_timeline_url == "https://api.twitter.com/1.1/statuses/home_timeline.json"
  end
end
