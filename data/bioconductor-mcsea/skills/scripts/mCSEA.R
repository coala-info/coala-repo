# Code example from 'mCSEA' vignette. See references/ for full tutorial.

## ----message = FALSE----------------------------------------------------------
library(minfi)
minfiDataDir <- system.file("extdata", package = "minfiData")
targets <- read.metharray.sheet(minfiDataDir, verbose = FALSE)
RGset <- read.metharray.exp(targets = targets)

## ----message=FALSE------------------------------------------------------------
library(FlowSorted.Blood.450k)
library(mCSEA)
data(mcseadata)

cellCounts = estimateCellCounts(RGset)
print(cellCounts)

## ----message = FALSE, results='hide'------------------------------------------
library(mCSEA)
data(mcseadata)

## -----------------------------------------------------------------------------
head(betaTest, 3)
print(phenoTest)

## -----------------------------------------------------------------------------
myRank <- rankProbes(betaTest, phenoTest, refGroup = "Control")

## -----------------------------------------------------------------------------
head(myRank)

## ----warning=FALSE------------------------------------------------------------
myResults <- mCSEATest(myRank, betaTest, phenoTest, 
                        regionsTypes = "promoters", platform = "EPIC")

## -----------------------------------------------------------------------------
ls(myResults)

## -----------------------------------------------------------------------------
head(myResults[["promoters"]][,-7])

## -----------------------------------------------------------------------------
head(myResults[["promoters_association"]], 3)

## -----------------------------------------------------------------------------
head(assocGenes450k, 3)

## ----message = FALSE, results='hide'------------------------------------------
mCSEAPlot(myResults, regionType = "promoters", 
           dmrName = "CLIC6",
           transcriptAnnotation = "symbol", makePDF = FALSE)

## -----------------------------------------------------------------------------
mCSEAPlotGSEA(myRank, myResults, regionType = "promoters", dmrName = "CLIC6")

## -----------------------------------------------------------------------------
# Explore expression data
head(exprTest, 3)

# Run mCSEAIntegrate function
resultsInt <- mCSEAIntegrate(myResults, exprTest, "promoters", "ENSEMBL")

resultsInt

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

