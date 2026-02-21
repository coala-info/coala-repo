# Code example from 'nullrangesData' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(nullrangesData)
suppressPackageStartupMessages(library(GenomicRanges))
suppressPackageStartupMessages(library(InteractionSet))

## -----------------------------------------------------------------------------
dhs <- DHSA549Hg38()
dhs

## -----------------------------------------------------------------------------
data("sc_rna")
data("sc_promoter")
sc_rna
sc_promoter

## -----------------------------------------------------------------------------
bins <- hg19_10kb_bins()
binPairs <- hg19_10kb_ctcfBoundBinPairs()
bins
binPairs

## -----------------------------------------------------------------------------
sessionInfo()

