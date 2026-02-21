# Code example from 'CSSQ' vignette. See references/ for full tutorial.

## ----setup_knitr, include = FALSE, cache = FALSE------------------------------
library(BiocStyle)
# Decide whether to display parts for BioC (TRUE) or F1000 (FALSE)
on.bioc <- TRUE
library(knitr)
# Use fig.width = 7 for html and fig.width = 6 for pdf
fig.width <- ifelse(on.bioc, 8, 6)
knitr::opts_chunk$set(cache = 2, warning = FALSE, message = FALSE, error = FALSE,
  cache.path = "cache/", fig.path = "figure/", fig.width = fig.width)

## -----------------------------------------------------------------------------
library(CSSQ)
regionBed <- read.table(system.file("extdata", "chr19_regions.bed", package="CSSQ",mustWork = TRUE))
sampleInfo <- read.table(system.file("extdata", "sample_info.txt", package="CSSQ",mustWork = TRUE),sep="\t",header=TRUE)
head(regionBed)
sampleInfo

## -----------------------------------------------------------------------------
countData <- getRegionCounts(system.file("extdata", "chr19_regions.bed", package="CSSQ"),sampleInfo,sampleDir = system.file("extdata", package="CSSQ"))
countData
head(assays(countData)$countData)
colData(countData)
rowRanges(countData)

## -----------------------------------------------------------------------------
countData <- loadCountData(system.file("extdata", "sample_count_data.txt", package="CSSQ",mustWork = TRUE),system.file("extdata", "chr19_regions.bed", package="CSSQ"),sampleInfo)
countData
head(assays(countData)$countData)
colData(countData)
rowRanges(countData)

## -----------------------------------------------------------------------------
ansCountData <- ansTransform(countData)
ansCountData
head(assays(ansCountData)$ansCount)

## -----------------------------------------------------------------------------
normInfo <- normalizeData(ansCountData,numClusters=4)
normInfo
head(assays(normInfo)$normCount)

## -----------------------------------------------------------------------------
result <- DBAnalyze(normInfo,comparison=c("HSMM","HESC"))
result

## -----------------------------------------------------------------------------
#To let CSSQ calculate the counts
processedData <- preprocessData(system.file("extdata", "chr19_regions.bed", package="CSSQ"),system.file("extdata", "sample_info.txt", package="CSSQ"),sampleDir = system.file("extdata", package="CSSQ"),numClusters=4,noNeg=TRUE,plotData=FALSE)
#To provide CSSQ with the counts 
processedData <- preprocessData(system.file("extdata", "chr19_regions.bed", package="CSSQ"),system.file("extdata", "sample_info.txt", package="CSSQ"),inputCountData = system.file("extdata", "sample_count_data.txt", package="CSSQ",mustWork = TRUE),numClusters=4,noNeg=TRUE,plotData=FALSE)
#To find differential binding sites
result <- DBAnalyze(processedData,comparison=c("HSMM","HESC"))
processedData
result

## -----------------------------------------------------------------------------
sessionInfo()

