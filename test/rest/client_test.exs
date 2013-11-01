defmodule Twutter.REST.ClientTest do
  use ExUnit.Case

  setup do
    auth = Twutter.Authentication.new(
      consumer_key: "1",
      consumer_secret: "2"
    )
    {:ok, client} = Twutter.REST.Client.start_link(auth)
    {:ok, client: client}
  end

end
