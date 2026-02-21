# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## -----------------------------------------------------------------------------
# use the AnnotationHub to load the scAnnotatR.models package
eh <- AnnotationHub::AnnotationHub()

# load the stored models
query <- AnnotationHub::query(eh, "scAnnotatR.models")
models <- query[["AH95906"]]

## -----------------------------------------------------------------------------
# print the available cell types
names(models)

## -----------------------------------------------------------------------------
models[['B cells']]

## -----------------------------------------------------------------------------
# Load the scAnnotatR package to view the models
library(scAnnotatR)

## -----------------------------------------------------------------------------
default_models <- load_models("default")
names(default_models)

## -----------------------------------------------------------------------------
default_models[['B cells']]

## -----------------------------------------------------------------------------
sessionInfo()

