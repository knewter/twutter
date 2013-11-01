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
    get_endpoint(client, Twutter.favorites_url)
  end

  def home_timeline(client) do
    get_endpoint(client, Twutter.home_timeline_url)
  end

  def mentions_timeline(client) do
    get_endpoint(client, Twutter.mentions_timeline_url)
  end

  def user_timeline(client) do
    get_endpoint(client, Twutter.user_timeline_url)
  end

  def retweets_of_me(client) do
    get_endpoint(client, Twutter.retweets_of_me_url)
  end

  defp get_endpoint(client, endpoint) do
    {:ok, _headers, json} = Twutter.OauthClient.get(client, endpoint, [])
    {:ok, JSON.decode(json)}
  end
end
