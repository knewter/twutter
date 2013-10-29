# ported from https://github.com/tim/erlang-oauth-examples/blob/master/src/oauth_twitter.erl
# To test it out:
#
# ```elixir
# :application.start(:crypto)
# :application.start(:asn1)
# :application.start(:public_key)
# :application.start(:ssl)
# :application.start(:inets)
# consumer = {'key', 'secret', :hmac_sha1}
# {:ok, client} = Twutter.OauthTwitter.start(consumer)
# {:ok, token} = Twutter.OauthTwitter.get_request_token(client)
# authorize_url = Twutter.OauthTwitter.authorize_url(token)
# :ok = Twutter.OauthTwitter.get_access_token(client, 'verification pin')
# {:ok, response} = Twutter.OauthTwitter.get_favorites(client)
# ```

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
    {:ok, _headers, json} = OauthClient.get(client, url, [])
    {:ok, JSON.decode(json)}
  end

  def verify_credentials(client) do
    url = 'https://api.twitter.com/1.1/account/verify_credentials.json'
    OauthClient.get(client, url, [])
  end
end
