# Code example from 'pepStat' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(tidy=FALSE)

## ----loading-libraries, message=FALSE-----------------------------------------
library(pepDat)
library(pepStat)

## ----read-data----------------------------------------------------------------
mapFile <- system.file("extdata/mapping.csv", package = "pepDat")
dirToParse <- system.file("extdata/gpr_samples", package = "pepDat")
pSet <- makePeptideSet(files = NULL, path = dirToParse,
                       mapping.file = mapFile, log=TRUE)

## ----data-content-------------------------------------------------------------
read.csv(mapFile)

## ----read-data-ctrl-----------------------------------------------------------
pSetNoCtrl <- makePeptideSet(files = NULL, path = dirToParse,
                       mapping.file = mapFile, log = TRUE,
                       rm.control.list = c("JPT-control", "Ig", "Cy3"),
                       empty.control.list= c("empty", "blank control"))

## ----plot-slide, include=TRUE, fig.width=7.48, fig.height=3-------------------
plotArrayImage(pSet, array.index = 1)

## ----plot-residuals, include=TRUE, fig.width=7.48, fig.height=3---------------
plotArrayResiduals(pSet, array.index = 1, smooth = TRUE)

## ----create-pep-load-data-----------------------------------------------------
peps <- read.csv(system.file("extdata/pep_info.csv", package = "pepDat"))
head(peps)

## ----create-db----------------------------------------------------------------
pep_custom <- create_db(peps)

## ----create-db-GR-------------------------------------------------------------
pep_custom <- create_db(pep_custom)

## ----summarizePeptideSet------------------------------------------------------
psSet <- summarizePeptides(pSet, summary = "mean", position = pep_custom)

## ----normalizeArray-----------------------------------------------------------
pnSet <- normalizeArray(psSet)

## ----slidingMean--------------------------------------------------------------
psmSet <- slidingMean(pnSet, width = 9)

## ----slidingMean-splitbyclade-------------------------------------------------
psmSetAg <- slidingMean(pnSet, width = 9, split.by.clade = FALSE)

## ----makeCalls----------------------------------------------------------------
calls <- makeCalls(psmSet, freq = TRUE, group = "treatment",
                     cutoff = .1, method = "FDR", verbose = TRUE)

## ----makeCalls-aggregate------------------------------------------------------
callsAg <- makeCalls(psmSetAg, freq = TRUE, group = "treatment",
                     cutoff = .1, method = "FDR")

## ----restab-------------------------------------------------------------------
summary <- restab(psmSet, calls)
head(summary)

## ----plot-inter, fig.height=4, message=FALSE----------------------------------
library(Pviz)
summaryAg <- restab(psmSetAg, callsAg)
plot_inter(summaryAg)

## ----plot-clade, fig.height=4-------------------------------------------------
plot_clade(summary, clade=c("A", "M", "CRF01"), from = 300, to = 520)

## ----shinyApp, eval = FALSE---------------------------------------------------
# shinyPepStat()

## ----quick-analysis, results='hide', message=FALSE----------------------------
library(pepStat)
library(pepDat)
mapFile <- system.file("extdata/mapping.csv", package = "pepDat")
dirToParse <- system.file("extdata/gpr_samples", package = "pepDat")
ps <- makePeptideSet(files = NULL, path = dirToParse, mapping.file = mapFile)
data(pep_hxb2)
ps <- summarizePeptides(ps, summary = "mean", position = pep_hxb2)
ps <- normalizeArray(ps)
ps <- slidingMean(ps)
calls <- makeCalls(ps, group = "treatment")
summary <- restab(ps, calls)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

