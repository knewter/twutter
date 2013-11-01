defmodule TwutterTest do
  use ExUnit.Case

  test "knows where the twitter API is hosted" do
    assert Twutter.api_root == "https://api.twitter.com/"
  end

  test "knows the current version of the api" do
    assert Twutter.versioned_api_root == "https://api.twitter.com/1.1/"
  end

  test "knows the request_token_url" do
    assert Twutter.request_token_url == "https://api.twitter.com/oauth/request_token"
  end

  test "knows the authorize_url" do
    assert Twutter.authorize_url == "https://api.twitter.com/oauth/authorize"
  end

  test "knows the access_token_url" do
    assert Twutter.access_token_url == "https://api.twitter.com/oauth/access_token"
  end

  test "knows the favorites_url" do
    assert Twutter.favorites_url == "https://api.twitter.com/1.1/favorites/list.json"
  end

  test "knows the home timeline url" do
    assert Twutter.home_timeline_url == "https://api.twitter.com/1.1/statuses/home_timeline.json"
  end

  test "knows the mentions timeline url" do
    assert Twutter.mentions_timeline_url == "https://api.twitter.com/1.1/statuses/mentions_timeline.json"
  end

  test "knows the retweets of me url" do
    assert Twutter.retweets_of_me_url == "https://api.twitter.com/1.1/statuses/retweets_of_me.json"
  end

  test "knows the user timeline url" do
    assert Twutter.user_timeline_url == "https://api.twitter.com/1.1/statuses/user_timeline.json"
  end
end
