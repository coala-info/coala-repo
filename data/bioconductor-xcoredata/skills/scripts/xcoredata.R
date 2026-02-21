# Code example from 'xcoredata' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE)

## -----------------------------------------------------------------------------
library("xcoredata")

## -----------------------------------------------------------------------------
# FANTOM5 promoters
promoters_f5()
promoters_f5_core()

# ReMap2020 molecular signatures
remap_promoters_f5()
remap_meta()

# ChIP-Atlas molecular signatures
chip_atlas_promoters_f5()
chip_atlas_meta()

## -----------------------------------------------------------------------------
library("ExperimentHub")

eh <- ExperimentHub()
query(eh, "remap_meta")
eh[["EH7299"]]

## -----------------------------------------------------------------------------
sessionInfo()

