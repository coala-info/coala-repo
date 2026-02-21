# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
self <- Githubpkg("ArtifactDB/alabaster.vcf")
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
library(VariantAnnotation)
fl <- system.file("extdata", "structural.vcf", package="VariantAnnotation")
vcf <- readVcf(fl, genome="hg19")
vcf

library(alabaster.vcf)
tmp <- tempfile()
dir.create(tmp)
meta <- stageObject(vcf, tmp, "vcf")
.writeMetadata(meta, tmp)

list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
meta <- acquireMetadata(tmp, "vcf/experiment.json")
roundtrip <- loadObject(meta, tmp)
class(roundtrip)

## -----------------------------------------------------------------------------
library(alabaster.se)
loadSummarizedExperiment(meta, tmp)

## -----------------------------------------------------------------------------
sessionInfo()

