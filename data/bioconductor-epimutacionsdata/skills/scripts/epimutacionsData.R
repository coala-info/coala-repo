# Code example from 'epimutacionsData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message = FALSE----------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, c("epimutacionsData"))

## ----message = FALSE, eval = FALSE--------------------------------------------
# candRegsGR <- eh[["EH6692"]]

## ----message = FALSE----------------------------------------------------------
reference_panel <- eh[["EH6691"]]

## ----message = FALSE----------------------------------------------------------
methy <- eh[["EH6690"]]

## ----message = FALSE, eval = FALSE--------------------------------------------
# library(minfi)
# baseDir <- system.file("extdata", package = "epimutacionsData")
# targets <- read.metharray.sheet(baseDir)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

