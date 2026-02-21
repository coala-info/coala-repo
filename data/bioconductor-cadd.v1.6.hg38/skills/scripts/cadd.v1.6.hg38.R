# Code example from 'cadd.v1.6.hg38' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
options(width=80)

## ----echo=FALSE---------------------------------------------------------------
avgs <- readRDS(system.file("extdata", "avgs.rds", package="GenomicScores"))

## ----retrieve2, message=FALSE, cache=FALSE, eval=FALSE------------------------
#  availableGScores()

## ----message=FALSE, cache=FALSE, echo=FALSE-----------------------------------
library(AnnotationHub)
library(GenomicScores)
setAnnotationHubOption("MAX_DOWNLOADS", 30)
avgs

## ----retrieve3, message=FALSE, cache=FALSE------------------------------------
cadd <- getGScores("cadd.v1.6.hg38")
cadd
citation(cadd)

## ----retrieve4, message=FALSE-------------------------------------------------
gscores(cadd, GRanges("chr7:44145576"), ref="C", alt="T")

## ----eval=FALSE---------------------------------------------------------------
#  makeGScoresPackage(cadd, maintainer="Me <me@example.com>", author="Me", version="1.0.0")

## ----echo=FALSE---------------------------------------------------------------
cat("Creating package in ./cadd.v1.6.hg38\n")

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

