# Code example from 'rmpsc' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----BiocManager, eval=FALSE--------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("rmspc")

## ----initialize, results="hide", warning=FALSE, message=FALSE-----------------
library(rmspc)

## -----------------------------------------------------------------------------
path <- system.file("extdata", package = "rmspc")

## -----------------------------------------------------------------------------
list.files(path)

## -----------------------------------------------------------------------------
input1 <- paste0(path, "/rep1.bed")
input2 <- paste0(path, "/rep2.bed")
input <- c(input1, input2)
input

## -----------------------------------------------------------------------------
results <- mspc(
    input = input, replicateType = "Technical",
    stringencyThreshold = 1e-8,
    weakThreshold = 1e-4, gamma = 1e-8,
    keep = FALSE,GRanges = TRUE,
    multipleIntersections = "Lowest",
    c = 2,alpha = 0.05)

## -----------------------------------------------------------------------------
results$status
head(results$GRangesObjects,3)

## -----------------------------------------------------------------------------
results$GRangesObjects$ConsensusPeaks
results$GRangesObjects$`rep1/Background`

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("GenomicRanges",dependencies = TRUE)
# BiocManager::install("rtracklayer",dependencies = TRUE)

## ----message=FALSE,warning=FALSE----------------------------------------------
library(GenomicRanges)
library(rtracklayer)

## -----------------------------------------------------------------------------

path <- system.file("extdata", package = "rmspc")
input1 <- paste0(path, "/rep1.bed")
input2 <- paste0(path, "/rep2.bed")

GR1 <- rtracklayer::import(con = input1, format = "bed")
GR2 <- rtracklayer::import(con = input2, format = "bed")


## -----------------------------------------------------------------------------
GR1

## -----------------------------------------------------------------------------
GR <- GenomicRanges::GRangesList("GR1" = GR1, "GR2" = GR2)
GR

## -----------------------------------------------------------------------------

results <- mspc(
    input = GR, replicateType = "Biological",
    stringencyThreshold = 1e-8, weakThreshold = 1e-4,
    gamma =  1e-8, GRanges = TRUE, keep = FALSE,
    multipleIntersections = "Highest",
    c = 2,alpha = 0.05)

## -----------------------------------------------------------------------------
results$status
tail(results$GRangesObjects)

## ----SessionInfo--------------------------------------------------------------
sessionInfo()

