# Code example from 'biscuiteerData' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("biscuiteerData")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("trichelab/biscuiteerData")

## -----------------------------------------------------------------------------
library(biscuiteerData)

## ----eval=FALSE---------------------------------------------------------------
# PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda")

## -----------------------------------------------------------------------------
biscuiteerDataList()

## -----------------------------------------------------------------------------
biscuiteerDataListDates()

## ----eval=FALSE---------------------------------------------------------------
# PMDs.hg19 <- biscuiteerDataGet("PMDs.hg19.rda", dateAdded = "2019-09-25")

