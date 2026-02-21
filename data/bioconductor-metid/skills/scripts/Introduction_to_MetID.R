# Code example from 'Introduction_to_MetID' vignette. See references/ for full tutorial.

## ----setup, include = FALSE, warning=FALSE------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(MetID)

## -----------------------------------------------------------------------------
data("demo1")
dim(demo1)
head(demo1) 

## -----------------------------------------------------------------------------
names(demo1)

## -----------------------------------------------------------------------------
colnames(demo1) <- c('query_m.z','name','formula','exact_m.z','pubchem_cid','kegg_id')
out <- get_scores_for_LC_MS(demo1, type = 'data.frame', na='-', mode='POS')
head(out)

