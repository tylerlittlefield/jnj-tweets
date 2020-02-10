
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

    #> # A tibble: 1,857 x 2
    #>    created_at          text                                                     
    #>    <dttm>              <chr>                                                    
    #>  1 2020-02-09 23:54:17 "@Jedi4Revolution Oh, and look!!!! Johnson and Johnson i…
    #>  2 2020-02-09 23:57:20 "You are invited to celebrate with me today 🙌. I am cele…
    #>  3 2020-02-09 23:53:28 "@Mahousloth Who am I wearing? Johnson &amp; Johnson bra…
    #>  4 2020-02-09 22:36:31 "@diaryofdg @Twitter Like Johnson and Johnson shampoo ??…
    #>  5 2020-02-09 22:02:19 "If you are depressed and crying. Just use johnson and j…
    #>  6 2020-02-09 21:35:56 "@JNJNews @SquawkCNBC Anything Johnson and Johnson makes…
    #>  7 2020-02-09 21:26:40 "@jessarose__ @godriah_ have you ever bought anything fr…
    #>  8 2020-02-09 19:02:37 "@stephen16781577 Johnson and johnson"                   
    #>  9 2020-02-09 17:23:14 "@BillTufts @ActivistPost Johnson and Johnson Drug Carte…
    #> 10 2020-02-09 15:41:06 "NO MORE JOHNSON AND JOHNSON FOR ME OR MY KIDS.... #fuck…
    #> # … with 1,847 more rows
