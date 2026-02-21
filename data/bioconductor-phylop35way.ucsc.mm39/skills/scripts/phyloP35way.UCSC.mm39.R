# Code example from 'phyloP35way.UCSC.mm39' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
options(width=80)

## ---- echo=FALSE--------------------------------------------------------------
avgs <- readRDS(system.file("extdata", "avgs.rds", package="GenomicScores"))

## ----retrieve2, message=FALSE, cache=FALSE, eval=FALSE------------------------
#  availableGScores()

## ---- echo=FALSE--------------------------------------------------------------
avgs

## ----retrieve3, message=FALSE, cache=FALSE, eval=FALSE------------------------
#  phylop <- getGScores("phyloP35way.UCSC.mm39")

## ----retrieve4, message=FALSE, eval=FALSE-------------------------------------
#  gscores(phylop, GRanges(seqnames="chr22", IRanges(start=50967020:50967025, width=1)))

## ----eval=FALSE---------------------------------------------------------------
#  makeGScoresPackage(phylop, maintainer="Me <me@example.com>", author="Me", version="1.0.0")

## ----echo=FALSE---------------------------------------------------------------
cat("Creating package in ./phyloP35way.UCSC.mm39\n")

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

