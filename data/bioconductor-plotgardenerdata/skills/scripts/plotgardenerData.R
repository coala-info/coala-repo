# Code example from 'plotgardenerData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(plotgardenerData)
data("IMR90_HiC_10kb")

## -----------------------------------------------------------------------------
bwFile <- system.file("extdata/test.bw", package = "plotgardenerData")
hicFile <- system.file("extdata/test_chr22.hic", package = "plotgardenerData")

## -----------------------------------------------------------------------------
sessionInfo()

