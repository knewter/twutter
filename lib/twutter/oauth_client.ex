# Ported from https://github.com/tim/erlang-oauth-examples/blob/master/src/oauth_client.erl
defmodule Twutter.OauthClient do
  use GenServer.Behaviour

  ### API functions
  def start(consumer) do
    :gen_server.start(__MODULE__, consumer, [])
  end

  def start(server_name, consumer) do
    :gen_server.start(server_name, __MODULE__, consumer, [])
  end

  def start_link(consumer) do
    :gen_server.start_link(__MODULE__, consumer, [])
  end

  def start_link(server_name, consumer) do
    :gen_server.start_link(server_name, __MODULE__, consumer, [])
  end

  def get_request_token(client, url) do
    get_request_token(client, url, [], :header)
  end

  def get_request_token(client, url, params) do
    :gen_server.call(client, {:get_request_token, url, params, :header})
  end

  def get_request_token(client, url, params, params_method) do
    :gen_server.call(client, {:get_request_token, url, params, params_method})
  end

  def get_access_token(client, url) do
    get_access_token(client, url, [], :header)
  end

  def get_access_token(client, url, params) do
    :gen_server.call(client, {:get_access_token, url, params, :header})
  end

  def get_access_token(client, url, params, params_method) do
    :gen_server.call(client, {:get_access_token, url, params, params_method})
  end

  def get(client, url) do
    get(client, url, [], :header)
  end

  def get(client, url, params) do
    :gen_server.call(client, {:get, url, params, :header})
  end

  def get(client, url, params, params_method) do
    :gen_server.call(client, {:get, url, params, params_method})
  end

  def access_token_params(client) do
    :gen_server.call(client, {:access_token_params})
  end

  def deauthorize(client) do
    :get_server.cast(client, :deauthorize)
  end

  def stop(client) do
    :get_server.cast(client, :stop)
  end

  ### Helper functions
  def oauth_get(:header, url, params, consumer, token, token_secret) do
    signed = :oauth.sign('GET', String.to_char_list!(url), params, consumer, token, token_secret)
    {authorization_params, query_params} = Enum.partition(signed, fn({k, _}) -> :lists.prefix('oauth_', k) end)
    request = {:oauth.uri(String.to_char_list!(url), query_params), [:oauth.header(authorization_params)]}
    :httpc.request(:get, request, [{:autoredirect, false}], [])
  end
  def oauth_get(:querystring, url, params, consumer, token, token_secret) do
    :oauth.get(String.to_char_list!(url), params, consumer, token, token_secret)
  end

  ### GenServer callbacks
  def init(consumer) do
    {:ok, {consumer}}
  end

  def handle_call({:get_request_token, url, params, params_method}, _from, state={consumer}) do
    case oauth_get(params_method, url, params, consumer, '', '') do
      {:ok, response={{_, 200, _}, _, _}} ->
        rparams = :oauth.params_decode(response)
        {:reply, {:ok, :oauth.token(rparams)}, {consumer, rparams}}
      {:ok, response} ->
        {:reply, response, state}
      error ->
        {:reply, error, state}
    end
  end
  def handle_call({:get_access_token, url, params, params_method}, _from, state={consumer, rparams}) do
    case oauth_get(params_method, url, params, consumer, :oauth.token(rparams), :oauth.token_secret(rparams)) do
      {:ok, response={{_, 200, _}, _, _}} ->
        aparams = :oauth.params_decode(response)
        {:reply, :ok, {consumer, rparams, aparams}}
      {:ok, response} -> {:reply, response, state}
      error -> {:reply, error, state}
    end
  end
  def handle_call({:get, url, params, params_method}, _from, state={consumer, _rparams, aparams}) do
    case oauth_get(params_method, url, params, consumer, :oauth.token(aparams), :oauth.token_secret(aparams)) do
      {:ok, {{_, 200, _}, headers, body}} ->
        case :proplists.get_value('content-type', headers) do
          :undefined ->
            {:reply, {:ok, headers, body}, state}
          content_type ->
            media_type = hd(:string.tokens(content_type, ';'))
            case :lists.suffix('/xml', media_type) or :lists.suffix('+xml', media_type) do
              true ->
                {xml, []} = :xmerl_scan.string(body)
                {:reply, {:ok, headers, xml}, state}
              false ->
                {:reply, {:ok, headers, body}, state}
            end
        end
      {:ok, response} -> {:reply, response, state}
      error -> {:reply, error, state}
    end
  end
  def handle_call({:access_token_params}, _from, state={_consumer, _rparams, aparams}) do
    {:reply, aparams, state}
  end

  def handle_cast(:deauthorize, {consumer, _rparams}) do
    {:noreply, {consumer}}
  end
  def handle_cast(:deauthorize, {consumer, _rparams, _aparams}) do
    {:noreply, {consumer}}
  end
  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end
end
