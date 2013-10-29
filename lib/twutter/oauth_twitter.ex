# ported from https://github.com/tim/erlang-oauth-examples/blob/master/src/oauth_twitter.erl
# To test it out:
#
# iex(1)> :application.start(:crypto)
# iex(3)> :application.start(:asn1)
# iex(4)> :application.start(:public_key)
# iex(5)> :application.start(:ssl)
# iex(6)> :application.start(:inets)
# iex(7)> consumer = {'key', 'secret', :hmac_sha1}
# iex(8)> {:ok, client} = Twutter.OauthTwitter.start(consumer)
# iex(9)> {:ok, token} = Twutter.OauthTwitter.get_request_token(client)
# iex(10)> authorize_url = Twutter.OauthTwitter.authorize_url(token)
# iex(11)> :ok = Twutter.OauthTwitter.get_access_token(client, 'verification pin')
# iex(12)> {:ok, headers, json} = Twutter.OauthTwitter.get_favorites(client)

defmodule Twutter.OauthTwitter do
  alias Twutter.OauthClient, as: OauthClient
  def start(consumer) do
    OauthClient.start(consumer)
  end

  def get_request_token(client) do
    url = 'https://api.twitter.com/oauth/request_token'
    OauthClient.get_request_token(client, url)
  end

  def authorize_url(token) do
    :oauth.uri('https://twitter.com/oauth/authorize', [{'oauth_token', token}])
  end

  def get_access_token(client, verifier) do
    url = 'https://twitter.com/oauth/access_token'
    OauthClient.get_access_token(client, url, [{'oauth_verifier', verifier}])
  end

  def get_favorites(client) do
    url = 'https://api.twitter.com/1.1/favorites/list.json'
    OauthClient.get(client, url, [])
  end

  def verify_credentials(client) do
    url = 'https://api.twitter.com/1.1/account/verify_credentials.json'
    OauthClient.get(client, url, [])
  end
end
