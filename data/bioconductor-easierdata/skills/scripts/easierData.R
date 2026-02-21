# Code example from 'easierData' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=FALSE-----------------------------------------------------
library("easierData")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("easierData")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
    library("ExperimentHub")
    library("easierData")
})

eh <- ExperimentHub()
query(eh, "easierData")

## -----------------------------------------------------------------------------
list_easierData()

## ----message=FALSE------------------------------------------------------------
mariathasan_dataset <- eh[["EH6677"]]
mariathasan_dataset

mariathasan_dataset <- get_Mariathasan2018_PDL1_treatment()
mariathasan_dataset

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

