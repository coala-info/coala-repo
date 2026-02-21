# Code example from 'sources' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  message = FALSE,
  warning = FALSE,
  echo = FALSE
)

## ----setup--------------------------------------------------------------------
library(DT)
library(bugphyzz)
library(dplyr)
library(purrr)

## ----echo=FALSE---------------------------------------------------------------
sources_fname <- system.file(
  "extdata", "attribute_sources.tsv", package = "bugphyzz", mustWork = TRUE
)
sources <- readr::read_tsv(sources_fname, show_col_types = FALSE) |> 
  dplyr::rename(
    Source = Attribute_source,
    `Confidence in curation` = Confidence_in_curation,
    `Full source` = full_source
  )

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(sources)

