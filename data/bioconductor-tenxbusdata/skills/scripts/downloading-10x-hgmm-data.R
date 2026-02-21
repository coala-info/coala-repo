# Code example from 'downloading-10x-hgmm-data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(TENxBUSData)
library(ExperimentHub)

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
listResources(eh, "TENxBUSData")

## -----------------------------------------------------------------------------
TENxBUSData(".", dataset = "hgmm100", force = TRUE)

## -----------------------------------------------------------------------------
list.files("./out_hgmm100")

