# Code example from 'bioqc-signedGenesets' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----lib, warning=FALSE, message=FALSE, results="hide"------------------------
library(BioQC)

## ----gmt----------------------------------------------------------------------
gmtFile <- system.file("extdata/test.gmt", package="BioQC")
## print the file context
cat(readLines(gmtFile), sep="\n")
## read the file into SignedGenesets
genesets <- readSignedGmt(gmtFile)
print(genesets)

## ----gmtPos-------------------------------------------------------------------
genesets <- readSignedGmt(gmtFile, nomatch="pos")
print(genesets)

## ----data---------------------------------------------------------------------
set.seed(1887)
testN <- 100L
testSampleCount <- 3L
testGenes <- c("AKT1", "AKT2", "ERBB2", "ERBB3", "EGFR","TSC1", "TSC2", "GATA2", "GATA4", "GATA1", "GATA3")
testRows <- c(testGenes, paste("Gene", (length(testGenes)+1):testN, sep=""))
testMatrix <- matrix(rnorm(testN*testSampleCount, sd=0.1), nrow=testN, dimnames=list(testRows, NULL))
testMatrix[1:2,] <- testMatrix[1:2,]+10
testMatrix[6:7,] <- testMatrix[6:7,]-10
testMatrix[3:4,] <- testMatrix[3:4,]-5
testMatrix[5,] <- testMatrix[5,]+5
testEset <- new("ExpressionSet", exprs=testMatrix)

## ----index--------------------------------------------------------------------
testIndex <- matchGenes(genesets, testEset, col=NULL)
print(testIndex)

## ----runWmwGreater------------------------------------------------------------
wmwResult.greater <- wmwTest(testEset, testIndex, valType="p.greater")
print(wmwResult.greater)

## ----runWmwLess---------------------------------------------------------------
wmwResult.less <- wmwTest(testEset, testIndex, valType="p.less")
print(wmwResult.less)

## ----runWmwTwoSided-----------------------------------------------------------
wmwResult.two.sided <- wmwTest(testEset, testIndex, valType="p.two.sided")
print(wmwResult.two.sided)

## ----runWmwQ------------------------------------------------------------------
wmwResult.Q <- wmwTest(testEset, testIndex, valType="Q")
print(wmwResult.Q)

## ----session------------------------------------------------------------------
sessionInfo()

