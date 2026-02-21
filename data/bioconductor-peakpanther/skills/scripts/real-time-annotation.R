# Code example from 'real-time-annotation' vignette. See references/ for full tutorial.

## ----biocstyle, echo = FALSE, results = "asis"--------------------------------
BiocStyle::markdown()

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----init, message = FALSE, echo = FALSE, results = "hide"--------------------
## Silently loading all packages
library(BiocStyle)
library(peakPantheR)
library(faahKO)
library(pander)

## -----------------------------------------------------------------------------
library(faahKO)
## file paths
input_spectraPath  <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"))
input_spectraPath

## ----eval = FALSE-------------------------------------------------------------
# # targetFeatTable
# input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
#                         c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
#                         "mz", "mzMax"))), stringsAsFactors=FALSE)
# input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
#                                 522.194778, 522.2, 522.205222)
# input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
#                                 496.195038, 496.2, 496.204962)
# input_targetFeatTable[,c(3:8)] <- sapply(input_targetFeatTable[,c(3:8)],
#                                             as.numeric)

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(), 
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin", 
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390., 
                                522.194778, 522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440., 
                                496.195038, 496.2, 496.204962)
input_targetFeatTable[,c(3:8)] <- sapply(input_targetFeatTable[,c(3:8)], 
                                            as.numeric)
rownames(input_targetFeatTable) <- NULL
pander::pandoc.table(input_targetFeatTable, digits = 9)

## -----------------------------------------------------------------------------
library(peakPantheR)
annotation <- peakPantheR_singleFileSearch(
                                    singleSpectraDataPath = input_spectraPath,
                                    targetFeatTable = input_targetFeatTable,
                                    peakStatistic = TRUE,
                                    curveModel = 'skewedGaussian',
                                    verbose = TRUE)

## -----------------------------------------------------------------------------
annotation$TIC

## -----------------------------------------------------------------------------
## acquisition time cannot be extracted from NetCDF files
annotation$acquTime

## ----eval = FALSE-------------------------------------------------------------
# annotation$peakTable

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
pander::pandoc.table(annotation$peakTable, digits = 7)

## -----------------------------------------------------------------------------
annotation$curveFit

## -----------------------------------------------------------------------------
annotation$ROIsDataPoint

## ----out.width = "700px", echo = FALSE----------------------------------------
knitr::include_graphics("figures/singleFileSearch_EICsPlot.png")

## ----echo = FALSE-------------------------------------------------------------
devtools::session_info()

