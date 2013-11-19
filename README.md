# Twutter

Twutter is a command line client for Twitter.  It's built in Elixir and aims for
a strict functional core, with a thin imperative shell to display the tweets.

It's being developed on an airplane with no internet access, so it should be
interesting.

## To test out the basic twitter client

Run `iex -S mix`.  Then:

```
consumer = {'key', 'secret'}
{:ok, client} = Twutter.REST.Client.start(consumer)
{:ok, token} = Twutter.REST.Client.get_request_token(client)
authorize_url = Twutter.REST.Client.authorize_url(token)
# bind the `pin` variable here...i.e. pin = '123456' - get this from the browser
:ok = Twutter.REST.Client.get_access_token(client, pin)
{:ok, response} = Twutter.REST.Client.favorites(client)
{:ok, response} = Twutter.REST.Client.home_timeline(client)
{:ok, response} = Twutter.REST.Client.mentions_timeline(client)
{:ok, response} = Twutter.REST.Client.user_timeline(client)
{:ok, response} = Twutter.REST.Client.retweets_of_me(client)
```

