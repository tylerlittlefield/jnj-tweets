
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jnj-tweets

<!-- badges: start -->

<!-- badges: end -->

This repository collects twitter data and stores it to my own personal
s3 bucket. More specifically, it…

  - Uses `rtweet` to search for tweets with *“johnson and johnson”* or
    *“johnson & johnson”* in the text.
  - Compares new tweets to tweets that I have already collected by
    filtering out status IDs that already exist.
  - Saves the dataset to a personal s3 bucket.
  - Does this daily using a cron job from `cronR`.

I have no real use case for this at the moment. I am more or less just
interested in setting up a job to collect data. I think of it as a kind
of template that I may come back to if there is any twitter data I’d
like to routinely collect.
