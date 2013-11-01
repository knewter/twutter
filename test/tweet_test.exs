defmodule TweetTest do
  alias Twutter.Tweet, as: Tweet
  use ExUnit.Case

  test "it has content, an author, and a timestamp" do
    date = :erlang.now()
    tweet = Tweet.init("Some content", "knewter", date)
    assert "Some content" == tweet.text
    assert "knewter" == tweet.author
    assert date == tweet.timestamp
  end

  test "it outputs its content formatted nicely" do
    date = :erlang.now()
    tweet = Tweet.init("Some content", "knewter", date)
    assert "        knewter > Some content" == Tweet.pretty_print(tweet)
  end

  test "it can parse a tweet from the hashdicts returned in the json" do
    input = HashDict.new(
      [
        {"coordinates", nil},
        {"favorited", false},
        {"id_str", "396037985965445120"},
        {"source", "<a href=\"http://tapbots.com/tweetbot\" rel=\"nofollow\">Tweetbot for iOS</a>"},
        {"created_at", "Thu Oct 31 22:16:28 +0000 2013"},
        {"retweeted", false},
        {"entities",
         HashDict.new([{"hashtags", []}, {"symbols", []}, {"urls", []},
          {"user_mentions",
           [HashDict.new([{"id", 8383372}, {"id_str", "8383372"}, {"indices", [0, 8]},
             {"name", "Josh Adams"}, {"screen_name", "knewter"}]),
            HashDict.new([{"id", 16143891}, {"id_str", "16143891"},
             {"indices", [9, 21]}, {"name", "Ernie Miller"},
             {"screen_name", "erniemiller"}]),
            HashDict.new([{"id", 6083342}, {"id_str", "6083342"},
             {"indices", [22, 30]}, {"name", "Tony Arcieri"},
             {"screen_name", "bascule"}])]
           }])
          },
        {"favorite_count", 0},
        {"retweet_count", 0},
        {"id", 396037985965445120},
        {"in_reply_to_screen_name", "knewter"},
        {"truncated", false},
        {"geo", nil},
        {"in_reply_to_status_id", 396031426505621504}, {"contributors", nil},
        {"in_reply_to_user_id", 8383372},
        {"user",
          HashDict.new([{"id_str", "10941182"}, {"listed_count", 31},
            {"protected", false}, {"contributors_enabled", false},
            {"created_at", "Fri Dec 07 16:53:05 +0000 2007"},
            {"followers_count", 604}, {"friends_count", 102},
            {"location", "Berkshire, United Kingdom"}, {"name", "Ben Lovell"},
            {"profile_background_image_url",
             "http://abs.twimg.com/images/themes/theme1/bg.png"},
            {"entities",
             HashDict.new([{"description", HashDict.new([{"urls", []}])},
              {"url",
               HashDict.new([{"urls",
                 [HashDict.new([{"display_url", "github.com/benlovell"},
                   {"expanded_url", "http://github.com/benlovell"},
                   {"indices", [0, 22]}, {"url", "http://t.co/jZ5UxSsASx"}])]}])}])},
            {"notifications", nil}, {"profile_background_color", "C0DEED"},
            {"default_profile", true}, {"following", nil}, {"id", 10941182},
            {"profile_background_tile", false},
            {"profile_sidebar_fill_color", "DDEEF6"},
            {"url", "http://t.co/jZ5UxSsASx"}, {"default_profile_image", false},
            {"description",
             "Rubyist, go-nut, a little scala, and motorsport. Herpderp. Tea goes in, code comes out. @1minus1limited by day."},
            {"favourites_count", 303},
            {"profile_image_url",
             "http://pbs.twimg.com/profile_images/3378184741/15dc24e2afc9c729d3941a165ecfe980_normal.jpeg"},
            {"profile_link_color", "0084B4"}, {"geo_enabled", true},
            {"profile_image_url_https",
             "https://pbs.twimg.com/profile_images/3378184741/15dc24e2afc9c729d3941a165ecfe980_normal.jpeg"},
            {"profile_use_background_image", true}, {"verified", false},
            {"profile_sidebar_border_color", "C0DEED"}, {"statuses_count", 12473},
            {"time_zone", "London"}, {"utc_offset", 0},
            {"follow_request_sent", false}, {"is_translator", false}, {"lang", "en"},
            {"profile_background_image_url_https",
             "https://abs.twimg.com/images/themes/theme1/bg.png"},
            {"profile_banner_url",
             "https://pbs.twimg.com/profile_banners/10941182/1372676048"},
            {"profile_text_color", "333333"}, {"screen_name", "benlovell"}])},
          {"in_reply_to_status_id_str", "396031426505621504"},
          {"in_reply_to_user_id_str", "8383372"},
          {"place",
           HashDict.new([{"place_type", "admin"}, {"contained_within", []},
            {"name", "Bracknell Forest"}, {"id", "04c7059a3a7723e6"},
            {"url", "https://api.twitter.com/1.1/geo/id/04c7059a3a7723e6.json"},
            {"country", "United Kingdom"},
            {"bounding_box",
             HashDict.new([{"coordinates",
               [[[-0.837364, 51.331934], [-0.6305669999999999, 51.331934],
                 [-0.6305669999999999, 51.468728999999996],
                 [-0.837364, 51.468728999999996]]]}, {"type", "Polygon"}])},
            {"country_code", "GB"}, {"full_name", "Bracknell Forest, England"},
            {"attributes", HashDict.new([])}])},
          {"text",
           "@knewter @erniemiller @bascule welcome to the topic of this weekends bike shedding."},
          {"lang", "en"}])
    tweet = Tweet.parse(input)
    assert tweet.lang == "en"
    assert tweet.coordinates == nil
    assert tweet.favorited == false
    assert tweet.retweeted == false
    assert tweet.id == "396037985965445120"
    assert tweet.source == "<a href=\"http://tapbots.com/tweetbot\" rel=\"nofollow\">Tweetbot for iOS</a>"
    assert tweet.created_at == "Thu Oct 31 22:16:28 +0000 2013"
    assert tweet.text == "@knewter @erniemiller @bascule welcome to the topic of this weekends bike shedding."
  end
end
