# Code example from 'COSMIC.67' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----echo=FALSE, results='hide'--------------------------------
set.seed(1)
options(width=65)
library(knitr)
opts_chunk$set(background = "#FFFFFF", comment = NA, fig.path = "")

## ----load_packages,results='hide'------------------------------
library(VariantAnnotation)
library(GenomicRanges)

## ----load_data-------------------------------------------------
data(package = "COSMIC.67")
data(cosmic_67, package = "COSMIC.67")

## ----overlap_with_tp53-----------------------------------------
tp53_range = GRanges("17", IRanges(7565097, 7590856))
vcf_path = system.file("vcf", "cosmic_67.vcf.gz", package = "COSMIC.67")
cosmic_tp53 = readVcf(vcf_path, genome = "GRCh37", ScanVcfParam(which = tp53_range))
cosmic_tp53

## ----CGC-------------------------------------------------------
data(cgc_67, package = "COSMIC.67")
head(cgc_67)

## ----echo=FALSE------------------------------------------------
sessionInfo()

