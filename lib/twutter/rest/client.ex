defmodule Twutter.REST.Client do
  use GenServer.Behaviour

  ### Public API
  def start_link(auth) do
    :gen_server.start_link(__MODULE__, auth, [])
  end

  def consumer_key(client) do
    :gen_server.call client, :consumer_key
  end

  def consumer_secret(client) do
    :gen_server.call client, :consumer_secret
  end

  def access_token(client) do
    :gen_server.call client, :access_token
  end

  def access_token_secret(client) do
    :gen_server.call client, :access_token_secret
  end

  ### GenServer API
  def init(auth) do
    {:ok, auth}
  end

  def handle_call(:consumer_key, _from, auth) do
    {:reply, auth.consumer_key, auth}
  end
  def handle_call(:consumer_secret, _from, auth) do
    {:reply, auth.consumer_secret, auth}
  end
  def handle_call(:access_token, _from, auth) do
    {:reply, auth.access_token, auth}
  end
  def handle_call(:access_token_secret, _from, auth) do
    {:reply, auth.access_token_secret, auth}
  end
end
