# Code example from 'hummingbird' vignette. See references/ for full tutorial.

## ----sampleDataset, message=FALSE, warning=FALSE------------------------------
library(GenomicRanges)
library(SummarizedExperiment)
library(hummingbird)
data(exampleHummingbird)

## ----sampleDataset_initialMatrices--------------------------------------------
head(normM)

## ----sampleDataset_initialpos-------------------------------------------------
head(pos)

## ----sampleDataset_creatingSE-------------------------------------------------
pos <- pos[,1]
assaysControl <- list(normM = normM, normUM = normUM)
assaysCase <- list(abnormM = abnormM, abnormUM = abnormUM)
exampleSEControl <- SummarizedExperiment(assaysControl, 
                                        rowRanges = GPos("chr29", pos))
exampleSECase <- SummarizedExperiment(assaysCase, 
                                    rowRanges = GPos("chr29", pos))

## ----sampleDataset_pos--------------------------------------------------------
rowRanges(exampleSEControl)
rowRanges(exampleSECase)

## ----sampleDataset_norm-------------------------------------------------------
head(assays(exampleSEControl)[["normM"]])
head(assays(exampleSEControl)[["normUM"]])

## ----sampleDataset_abnorm-----------------------------------------------------
head(assays(exampleSECase)[["abnormM"]])
head(assays(exampleSECase)[["abnormUM"]])

## ----hummingbird--------------------------------------------------------------
library(hummingbird)
data(exampleHummingbird)

## ----hummingbird_em-----------------------------------------------------------
emInfo <- hummingbirdEM(experimentInfoControl = exampleSEControl, 
                        experimentInfoCase = exampleSECase, binSize = 40)
emInfo

## ----hummingbird_postAdjustment-----------------------------------------------
postAdjInfo <- hummingbirdPostAdjustment(
    experimentInfoControl = exampleSEControl, 
    experimentInfoCase = exampleSECase, 
    emInfo = emInfo, minCpGs = 10, 
    minLength = 100, maxGap = 300)
postAdjInfo$DMRs

## ----hummingbird_graph--------------------------------------------------------
hummingbirdGraph(experimentInfoControl = exampleSEControl, 
                experimentInfoCase = exampleSECase, 
                postAdjInfoDMRs = postAdjInfo$DMRs, 
                coord1 = 107991, coord2 = 108350)

## ----sessionInfo, echo=TRUE, eval=TRUE----------------------------------------
sessionInfo()

