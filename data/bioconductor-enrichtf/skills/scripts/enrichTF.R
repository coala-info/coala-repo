# Code example from 'enrichTF' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,warning = FALSE)

## ----installpkg,eval=FALSE,message=FALSE,warning=FALSE-------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("enrichTF")

## ----loading00,eval=TRUE,message=FALSE-----------------------------------
library(enrichTF)

## ----eval=TRUE-----------------------------------------------------------
# Provide your region list in BED format with 3 columns.
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
# Call the whole pipeline
PECA_TF_enrich(inputForegroundBed = foregroundBedPath, genome = "testgenome") # change"testgenome" to one of "hg19", "hg38", "mm9", 'mm10' ! "testgenome" is only a test example.

## ----loading01-----------------------------------------------------------
setGenome("testgenome")
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
gen <- genBackground(inputForegroundBed = foregroundBedPath)

## ----loading02-----------------------------------------------------------
conTG <- enrichRegionConnectTargetGene(gen)

## ----loading03-----------------------------------------------------------
findMotif <- enrichFindMotifsInRegions(gen,motifRc="integrate")

## ----eval=TRUE-----------------------------------------------------------
result <- enrichTFsEnrichInRegions(gen)

## ------------------------------------------------------------------------
library(magrittr)
setGenome("testgenome")
foregroundBedPath <- system.file(package = "enrichTF", "extdata","testregion.bed")
result <- genBackground(inputForegroundBed = foregroundBedPath) %>%
enrichRegionConnectTargetGene%>%
enrichFindMotifsInRegions(motifRc="integrate") %>%
enrichTFsEnrichInRegions

## ------------------------------------------------------------------------

examplefile  <- system.file(package = "enrichTF", "extdata","result.example.txt")
read.table(examplefile, sep='\t', header = TRUE)%>%
  knitr::kable() 


## ------------------------------------------------------------------------
sessionInfo()

