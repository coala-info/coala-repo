# Code example from 'rna-velocity' vignette. See references/ for full tutorial.

## ----include = FALSE------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
options(width = 70L)

## ----setup----------------------------------------------------------
library(eisaR)

## -------------------------------------------------------------------
gtf <- system.file("extdata", "gencode.v28.annotation.sub.gtf",
                   package = "eisaR")
grl <- getFeatureRanges(
    gtf = gtf,
    featureType = c("spliced", "intron"),
    intronType = "separate",
    flankLength = 50L,
    joinOverlappingIntrons = FALSE,
    verbose = TRUE
)

## -------------------------------------------------------------------
grl

## -------------------------------------------------------------------
lapply(S4Vectors::metadata(grl)$featurelist, head)

## -------------------------------------------------------------------
head(S4Vectors::metadata(grl)$corrgene)

## -------------------------------------------------------------------
suppressPackageStartupMessages({
    library(BSgenome.Hsapiens.UCSC.hg38)
})
seqs <- GenomicFeatures::extractTranscriptSeqs(
    x = BSgenome.Hsapiens.UCSC.hg38,
    transcripts = grl
)
seqs

## -------------------------------------------------------------------
exportToGtf(
    grl,
    filepath = file.path(tempdir(), "exported.gtf")
)

## -------------------------------------------------------------------
df <- getTx2Gene(grl)
head(df)
tail(df)

## -------------------------------------------------------------------
sessionInfo()

