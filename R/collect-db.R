suppressPackageStartupMessages({
  library(dplyr)
  library(dbplyr)
  library(DBI)
  library(aws.s3)
  library(glue)
  library(rtweet)
})

# database configuration
dw <- config::get("datawarehouse")

# connection
con <- DBI::dbConnect(
  odbc::odbc(), 
  Driver   = dw$driver, 
  Server   = dw$server, 
  Database = dw$database, 
  UID      = dw$uid, 
  PWD      = dw$pwd, 
  Port     = dw$port
)

# currently collected tweets (status IDs)
cur_ids <- tbl(con, "jnj_twitter") %>% 
  distinct(status_id) %>% 
  collect()

# collect new tweets
df_new_tweets <- search_tweets2(
  q = c('"johnson and johnson"', '"johnson & johnson"', "#jnj", "janssen", "ethicon", "biosense webster", "depuy"),
  n = 18000,
  include_rts = FALSE, 
  retryonratelimit = TRUE, 
  verbose = FALSE, 
  token = readRDS(".rtweet_token2.rds")
)

# get status IDs that we currently do not have
df_append_to_db <- df_new_tweets %>% 
  filter(!status_id %in% cur_ids$status_id) %>% 
  flatten()

# message for log
cat(glue("[{Sys.Date()}] Collecting {nrow(df_append_to_db)} new tweets...\n\n"))

# append to the database table
dbWriteTable(con, "jnj_twitter", df_append_to_db, append = TRUE)

# disconnect
dbDisonnect(con)

# cronR::cron_add(
#   command = "cd /home/tyler/dev/jnj-tweets && /usr/bin/Rscript 'R/collect-db.R' >> 'R/collect-db.log' 2>&1",
#   frequency = "daily",
#   at = "10PM",
#   id = "JNJ Tweets",
#   tags = "#rstats, #twitter, #data",
#   description = "Collects twitter data with 'johnson and johnson' or 'johnson & johnson' in text, everyday at 10PM."
# )
