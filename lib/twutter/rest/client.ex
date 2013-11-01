# ported from https://github.com/tim/erlang-oauth-examples/blob/master/src/oauth_twitter.erl

defmodule Twutter.REST.Client do
  def start({consumer_key, consumer_secret}) do
    Twutter.OauthClient.start({consumer_key, consumer_secret, :hmac_sha1})
  end

  def get_request_token(client) do
    Twutter.OauthClient.get_request_token(client, Twutter.request_token_url)
  end

  def authorize_url(token) do
    :oauth.uri(String.to_char_list!(Twutter.authorize_url), [{'oauth_token', token}])
  end

  def get_access_token(client, verifier) do
    Twutter.OauthClient.get_access_token(client, Twutter.access_token_url, [{'oauth_verifier', verifier}])
  end

  def favorites(client) do
    {:ok, _headers, json} = Twutter.OauthClient.get(client, Twutter.favorites_url, [])
    {:ok, JSON.decode(json)}
  end
end
