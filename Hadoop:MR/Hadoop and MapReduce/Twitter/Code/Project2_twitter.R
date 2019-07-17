library(rtweet)
library(twitteR)

consumer_key <- "AA5zjax4gAEMWAJani03diYbR"
consumer_secret <-
  "XZj4f825GpSLnvuSj4KJd3RtkCfcPxbFWSaJUpvdtGSjqOF2mg"
access_token <- "1351169059-gzj0mgQ9qkZSUUh4g9CSkUoAbDvmWTsGqbMQ3qv"
access_secret <- "8zaOiUQGWbmAltPVPU3hvKtZNvoi0fRYRNngh69I0tYHB"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Change keywords for different tweets
tweets <-
  search_tweets(q = "#melania",
                n = 10000, retryonratelimit = TRUE, include_rts = FALSE)

# Remove non English tweets
data  <- subset(tweets, account_lang == "en")
data <- subset(data, created_at >= "2019-01-01 00:00:00")

# Ridiculous posts by this user, hence removing him.
data <- subset(data, screen_name != "TomJanneck")
data_text <- subset(data["text"])

save_as_csv(data_text, "Data/Twitter/rtweet_twitter_proj2_4.csv")