suppressPackageStartupMessages({
  library(dplyr)
  library(aws.s3)
  library(glue)
  library(rtweet)
})

s3_bucketname <- Sys.getenv("TWEETS_S3_BUCKETNAME")

df_old_tweets <- s3readRDS(
  object = "jnj_tweets.rds",
  bucket = s3_bucketname
)

df_new_tweets <- search_tweets2(
  q = c('"johnson and johnson"', '"johnson & johnson"', "#jnj"),
  n = 18000, 
  include_rts = FALSE, 
  retryonratelimit = TRUE, 
  verbose = FALSE, 
  token = readRDS(".rtweet_token2.rds")
)

df_new_tweets %>% 
  filter(!status_id %in% df_old_tweets$status_id) %>% 
  { cat(glue("[{Sys.Date()}] Collecting {nrow(.)} new tweets...\n\n")); . } %>%
  bind_rows(df_old_tweets) %>% 
  s3saveRDS(
    object = "jnj_tweets.rds", 
    bucket = s3_bucketname,
    multipart = TRUE
  )

# cronR::cron_add(
#   command = "cd /home/tyler/dev/jnj-tweets && /usr/bin/Rscript 'R/collect.R' >> 'R/collect.log' 2>&1",
#   frequency = "daily",
#   at = "10PM",
#   id = "JNJ Tweets",
#   tags = "#rstats, #twitter, #data",
#   description = "Collects twitter data with 'johnson and johnson' or 'johnson & johnson' in text, everyday at 10PM."
# )
