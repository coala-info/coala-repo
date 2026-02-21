# Code example from 'PowerExplore_vignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----showDataExample, message=FALSE, warning=FALSE-----------------------
library(PowerExplorer)
data("exampleProteomicsData")
head(exampleProteomicsData$dataMatrix)

## ------------------------------------------------------------------------
show(exampleProteomicsData$groupVec)

## ------------------------------------------------------------------------
colnames(exampleProteomicsData$dataMatrix)

## ----est run, echo=TRUE, fig.keep='none', message=FALSE, warning=FALSE----
library(PowerExplorer)
data("exampleProteomicsData")
res <- estimatePower(inputObject = exampleProteomicsData$dataMatrix,
                     groupVec = exampleProteomicsData$groupVec,
                     isLogTransformed = FALSE,
                     dataType = "Proteomics",
                     minLFC = 0.5,
                     enableROTS = TRUE,
                     paraROTS = list(B = 1000, K = NULL),
                     alpha = 0.05,
                     ST = 50,
                     seed = 345, 
                     showProcess = FALSE, 
                     saveResultData = FALSE
                     )

## ----plot estimated power------------------------------------------------
plotEstPwr(res)

## ------------------------------------------------------------------------
res

## ------------------------------------------------------------------------
data(exampleObject)
listEstPwr(exampleObject, decreasing = TRUE, top = 10)

## ------------------------------------------------------------------------
listEstPwr(exampleObject, 
           selected = c("ENSMUSG00000000303", 
                         "ENSMUSG00000087272", 
                         "ENSMUSG00000089921"))

## ----prediction run2, message=FALSE, warning=FALSE-----------------------
data("exampleProteomicsData")
res <- predictPower(inputObject = res,
                    groupVec = exampleProteomicsData$groupVec,
                    isLogTransformed = FALSE,
                    dataType = "Proteomics",
                    minLFC = 0.5,
                    rangeSimNumRep = c(5, 10, 15, 20),
                    enableROTS = TRUE,
                    paraROTS = list(B = 1000, K = NULL),
                    alpha = 0.05,
                    ST = 50,
                    seed = 345)

## ----LinePlot------------------------------------------------------------
plotPredPwr(res, LFCscale = 0.5)

## ------------------------------------------------------------------------
res

## ------------------------------------------------------------------------
listPredPwr(exampleObject, decreasing = TRUE, top = 10)

## ------------------------------------------------------------------------
listPredPwr(exampleObject, 
            selected = c("ENSMUSG00000000303", 
                         "ENSMUSG00000087272", 
                         "ENSMUSG00000089921"))

