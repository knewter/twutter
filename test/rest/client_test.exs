defmodule Twutter.REST.ClientTest do
  use ExUnit.Case

  setup do
    auth = Twutter.Authentication.new(
      consumer_key: "1",
      consumer_secret: "2",
      access_token: "3",
      access_token_secret: "4"
    )
    {:ok, client} = Twutter.REST.Client.start_link(auth)
    {:ok, client: client}
  end

  test "can configure a consumer_key", meta do
    assert Twutter.REST.Client.consumer_key(meta[:client]) == "1"
  end

  test "can configure a consumer_secret", meta do
    assert Twutter.REST.Client.consumer_secret(meta[:client]) == "2"
  end

  test "can configure an access_token", meta do
    assert Twutter.REST.Client.access_token(meta[:client]) == "3"
  end

  test "can configure an access_token_secret", meta do
    assert Twutter.REST.Client.access_token_secret(meta[:client]) == "4"
  end
end
