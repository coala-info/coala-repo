# Code example from 'Cogito' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation of package Cogito, eval=FALSE-------------------------------
# BiocManager::install("Cogito")
# library("Cogito")

## ----load package, echo = FALSE, message = FALSE------------------------------
library("Cogito", quietly = TRUE, verbose = FALSE)

## ----murine example data set RNA----------------------------------------------
head(MurEpi.RNA.small[, 1:3])

## ----murine example data set RRBS---------------------------------------------
head(MurEpi.RRBS.small[, 1:3])

## ----murine example data set ChIP---------------------------------------------
head(MurEpi.ChIP.small[[1]])

## ----workflow aggregateRanges with small murine data set----------------------
mm9 <- TxDb.Mmusculus.UCSC.mm9.knownGene::TxDb.Mmusculus.UCSC.mm9.knownGene

example.dataset <- list(ChIP = MurEpi.ChIP.small, 
                        RNA = MurEpi.RNA.small,
                        RRBS = MurEpi.RRBS.small)

aggregated.ranges <- aggregateRanges(ranges = example.dataset,
                                        organism = mm9,
                                        name = "murine.example")

## ----workflow result genes of aggregateRanges with small murine data set------
head(aggregated.ranges$genes[, c(1, 2:3, 13:14, 27:28)])

## ----workflow result 1 genes of aggregateRanges with small murine data set----
lapply(aggregated.ranges$config$technologies, head, 3)
head(lapply(aggregated.ranges$config$conditions, head, 3), 3)

## ----workflow summarizeRanges with small murine data set, eval=FALSE----------
# summarizeRanges(aggregated.ranges = aggregated.ranges)

## ----session info, echo = FALSE-----------------------------------------------
sessionInfo()

