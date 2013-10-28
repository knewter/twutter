defmodule Twutter.REST.Client do
  use GenServer.Behaviour

  ### Public API
  def start_link(auth) do
    :gen_server.start_link(__MODULE__, auth, [])
  end

  def consumer_key(client) do
    :gen_server.call client, :consumer_key
  end

  ### GenServer API
  def init(auth) do
    {:ok, auth}
  end

  def handle_call(:consumer_key, _from, auth) do
    {:reply, auth.consumer_key, auth}
  end
end
