# Code example from 'AlphaMissense.v2023.hg19' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
options(width=80)

## ----echo=FALSE---------------------------------------------------------------
avgs <- readRDS(system.file("extdata", "avgs.rds", package="GenomicScores"))

## ----retrieve2, message=FALSE, cache=FALSE, eval=FALSE------------------------
#  library(GenomicScores)
#  
#  availableGScores()

## ----message=FALSE, cache=FALSE, echo=FALSE-----------------------------------
library(AnnotationHub)
library(GenomicScores)
setAnnotationHubOption("MAX_DOWNLOADS", 30)
avgs

## ----retrieve3, message=FALSE, cache=FALSE------------------------------------
am23 <- getGScores("AlphaMissense.v2023.hg19", accept.license=TRUE)
am23
citation(am23)

## ----retrieve4, message=FALSE-------------------------------------------------
gscores(am23, GRanges("chr7:44185175"), ref="C", alt="T")

## ----eval=FALSE---------------------------------------------------------------
#  makeGScoresPackage(am23, maintainer="Me <me@example.com>", author="Me", version="1.0.0")

## ----echo=FALSE---------------------------------------------------------------
cat("Creating package in ./AlphaMissense.v2023.hg19\n")

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

