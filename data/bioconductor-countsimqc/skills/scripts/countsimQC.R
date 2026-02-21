# Code example from 'countsimQC' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      crop = NA)

## ----warning = FALSE----------------------------------------------------------
suppressPackageStartupMessages({
  library(countsimQC)
  library(DESeq2)
})

data(countsimExample)
countsimExample
countsimExample <- lapply(countsimExample, function(cse) {
  cse[seq_len(1500), ]
})

## ----results = "hide", warning = FALSE, message = FALSE-----------------------
tempDir <- tempdir()
countsimQCReport(ddsList = countsimExample, outputFile = "countsim_report.html",
                 outputDir = tempDir, outputFormat = "html_document", 
                 showCode = FALSE, forceOverwrite = TRUE,
                 savePlots = TRUE, description = "This is my test report.", 
                 maxNForCorr = 25, maxNForDisp = Inf, 
                 calculateStatistics = TRUE, subsampleSize = 25,
                 kfrac = 0.01, kmin = 5, 
                 permutationPvalues = FALSE, nPermutations = NULL)

## ----warning = FALSE----------------------------------------------------------
ggplots <- readRDS(file.path(tempDir, "countsim_report_ggplots.rds"))
if (!dir.exists(file.path(tempDir, "figures"))) {
  dir.create(file.path(tempDir, "figures"))
}
generateIndividualPlots(ggplots, device = "pdf", nDatasets = 3, 
                        outputDir = file.path(tempDir, "figures"))

## -----------------------------------------------------------------------------
data(countsimExample_dfmat)
names(countsimExample_dfmat)
lapply(countsimExample_dfmat, class)

## ----results = "hide", warning = FALSE, eval = FALSE--------------------------
# tempDir <- tempdir()
# countsimQCReport(ddsList = countsimExample_dfmat,
#                  outputFile = "countsim_report_dfmat.html",
#                  outputDir = tempDir, outputFormat = "html_document",
#                  showCode = FALSE, forceOverwrite = TRUE,
#                  savePlots = TRUE, description = "This is my test report.",
#                  maxNForCorr = 25, maxNForDisp = Inf,
#                  calculateStatistics = TRUE, subsampleSize = 25,
#                  kfrac = 0.01, kmin = 5,
#                  permutationPvalues = FALSE, nPermutations = NULL)

## -----------------------------------------------------------------------------
sessionInfo()

