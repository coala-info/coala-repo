# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
self <- Biocpkg("alabaster.mae")
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
library(SummarizedExperiment)
rna.counts <- matrix(rpois(60, 10), ncol=6)
colnames(rna.counts) <- c("disease1", "disease2", "disease3", "control1", "control2", "control3")
rownames(rna.counts) <- c("ENSMUSG00000000001", "ENSMUSG00000000003", "ENSMUSG00000000028", 
    "ENSMUSG00000000031", "ENSMUSG00000000037", "ENSMUSG00000000049",  "ENSMUSG00000000056", 
    "ENSMUSG00000000058", "ENSMUSG00000000078",  "ENSMUSG00000000085")
rna.se <- SummarizedExperiment(list(counts=rna.counts))
colData(rna.se)$disease <- rep(c("disease", "control"), each=3)

chip.counts <- matrix(rpois(100, 10), ncol=4)
colnames(chip.counts) <- c("disease1", "disease2", "control1", "control3")
chip.peaks <- GRanges("chr1", IRanges(1:25*100+1, 1:25*100+100))
chip.se <- SummarizedExperiment(list(counts=chip.counts), rowRanges=chip.peaks)

library(MultiAssayExperiment)
mapping <- DataFrame(
    assay = rep(c("rnaseq", "chipseq"), c(ncol(rna.se), ncol(chip.se))), # experiment name
    primary = c(colnames(rna.se), colnames(chip.se)), # sample identifiers
    colname = c(colnames(rna.se), colnames(chip.se)) # column names inside each experiment
)
mae <- MultiAssayExperiment(list(rnaseq=rna.se, chipseq=chip.se), sampleMap=mapping)

## -----------------------------------------------------------------------------
library(alabaster.mae)
tmp <- tempfile()
meta <- saveObject(mae, tmp)
list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
roundtrip <- readObject(tmp)
class(roundtrip)

## -----------------------------------------------------------------------------
sessionInfo()

