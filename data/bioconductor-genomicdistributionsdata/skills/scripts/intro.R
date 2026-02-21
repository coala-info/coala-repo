# Code example from 'intro' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
# These settings make the vignette prettier
knitr::opts_chunk$set(results="hold", collapse=FALSE, message=FALSE)
#refreshPackage("GenomicDistributionsData")
#devtools::build_vignettes("code/GenomicDistributionsData")
#devtools::test("code/GenomicDistributionsData")

## ----echo=TRUE, results="hide", message=FALSE, warning=FALSE------------------
library(GenomicDistributionsData)
library(ExperimentHub)

## ----ExpHub-Obj---------------------------------------------------------------
hub = ExperimentHub()
query(hub, "GenomicDistributionsData")

## ----chrom-sizes--------------------------------------------------------------
# Retrieve the chrom sizes file
c = hub[["EH3473"]]
head(c)

## ----chrom-sizes-meta---------------------------------------------------------
# Access the chrom sizes file and inspect its metadata
chromSizes = query(hub, c("GenomicDistributionsData", "chromSizes_hg38"))
chromSizes

## ----chrom-sizes-alt, eval=FALSE----------------------------------------------
# # Retrieve the chromosome sizes file from ExperimentHub
# c2 = chromSizes[[1]]

## ----Transcription-Start-Sites------------------------------------------------
TSS = hub[["EH3477"]]
TSS[1:3, "symbol"]

## ----gene-models--------------------------------------------------------------
#GeneModels = buildGeneModels("hg38")
GeneModels = hub[["EH3481"]]

# Get the locations of exons
head(GeneModels[["exonsGR"]])

## ----open-signal-matrix, eval=FALSE-------------------------------------------
# #hg38OpenSignal = buildOpenSignalMatrix("hg38")
# OpenSignal = hub[["EH3485"]]
# head(OpenSignal)

## ----load-data-by-name, eval=FALSE--------------------------------------------
# chromSizes_hg38()
# chromSizes_hg19()
# chromSizes_mm10()
# chromSizes_mm9()
# TSS_hg38()
# TSS_hg19()
# TSS_mm10()
# TSS_mm9()
# geneModels_hg38()
# geneModels_hg19()
# geneModels_mm10()
# geneModels_mm9()
# openSignalMatrix_hg38()
# openSignalMatrix_hg19()
# openSignalMatrix_mm10()

