# Code example from 'core_tomtom' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(memes)
library(magrittr)

## -----------------------------------------------------------------------------
options(meme_db = system.file("extdata/flyFactorSurvey_cleaned.meme", package = "memes", mustWork = TRUE))

## ----eval=F-------------------------------------------------------------------
# library(universalmotif)
# example_motif <- create_motif("CCRAAAW")
# runTomTom(example_motif)

## ----eval=F-------------------------------------------------------------------
# data("dreme_example")
# runTomTom(dreme_example)

## -----------------------------------------------------------------------------
# This is a pre-build dataset packaged with memes 
# that mirrors running:
# options(meme_db = system.file("inst/extdata/db/fly_factor_survey_id.meme", package = "memes"))
# example_motif <- create_motif("CCRAAAW")
# example_tomtom <- runTomTom(example_motif)
data("example_tomtom")

## -----------------------------------------------------------------------------
names(example_tomtom)

## -----------------------------------------------------------------------------
names(example_tomtom$tomtom[[1]])

## ----fig.height=2, fig.width=5------------------------------------------------
library(universalmotif)
view_motifs(example_tomtom$best_match_motif)

## ----fig.height=3, fig.width=5------------------------------------------------
example_tomtom$tomtom[[1]]$match_motif[1:2] %>% 
  view_motifs()

## -----------------------------------------------------------------------------
example_tomtom %>% 
  drop_best_match() %>% 
  names

## -----------------------------------------------------------------------------
unnested <- example_tomtom %>% 
  drop_best_match() %>% 
  tidyr::unnest(tomtom) 
names(unnested)

## -----------------------------------------------------------------------------
unnested %>% 
  nest_tomtom() %>% 
  names

## -----------------------------------------------------------------------------
example_tomtom$tomtom[[1]] %>% head(3)

## -----------------------------------------------------------------------------
example_tomtom %>% 
  dplyr::select(name, best_match_name)

## -----------------------------------------------------------------------------
new_tomtom <- example_tomtom %>% 
  # multiple motifs can be updated at a time by passing additional name-value pairs.
  force_best_match(c("example_motif" = "Lag1_Cell"))

## -----------------------------------------------------------------------------
# original best match:
example_tomtom$best_match_name
# new best match after forcing:
new_tomtom$best_match_name

## ----fig.height=4, fig.width=5------------------------------------------------
example_tomtom %>% 
  view_tomtom_hits(top_n = 3)

## -----------------------------------------------------------------------------
sessionInfo()

