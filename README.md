# Twutter

Twutter is a command line client for Twitter.  It's built in Elixir and aims for
a strict functional core, with a thin imperative shell to display the tweets.

It's being developed on an airplane with no internet access, so it should be
interesting.

## To test out the basic twitter client
```
consumer = {'key', 'secret'}
:application.start(:crypto)
:application.start(:asn1)
:application.start(:public_key)
:application.start(:ssl)
:application.start(:inets)
{:ok, client} = Twutter.REST.Client.start(consumer)
{:ok, token} = Twutter.REST.Client.get_request_token(client)
authorize_url = Twutter.REST.Client.authorize_url(token)
:ok = Twutter.REST.Client.get_access_token(client, 'verification pin')
{:ok, response} = Twutter.REST.Client.favorites(client)
```

