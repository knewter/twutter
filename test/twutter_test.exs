defmodule TwutterTest do
  use ExUnit.Case

  test "knows where the twitter API is hosted" do
    assert Twutter.api_root == "https://api.twitter.com/1.1/"
  end

  test "knows the home timeline url" do
    assert Twutter.home_timeline_url == "https://api.twitter.com/1.1/statuses/home_timeline.json"
  end

  test "can configure a consumer_key" do
    auth = Twutter.Authentication.new(
      consumer_key: "1",
      consumer_secret: "2",
      access_token: "3",
      access_token_secret: "4"
    )
    {:ok, client} = Twutter.REST.Client.start_link(auth)
    assert Twutter.REST.Client.consumer_key(client) == "1"
  end

  test "can configure a consumer_secret" do
  end

  test "can configure an access_token" do
  end

  test "can configure an access_token_secret" do
  end
end
