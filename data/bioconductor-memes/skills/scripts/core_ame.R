# Code example from 'core_ame' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
NOT_CRAN <- identical(tolower(Sys.getenv("NOT_CRAN")), "true")

eval_vignette <- NOT_CRAN & memes::meme_is_installed()

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  purl = eval_vignette,
  eval = eval_vignette
)

