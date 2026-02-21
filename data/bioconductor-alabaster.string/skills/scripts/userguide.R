# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
self <- Biocpkg("alabaster.string")
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
library(Biostrings)
x <- DNAStringSet(c(seq1="CTCNACCAGTAT", seq2="TTGA", seq3="TACCTAGAG"))
mcols(x)$score <- runif(length(x))
x

library(alabaster.string)
tmp <- tempfile()
saveObject(x, tmp)

list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
roundtrip <- readObject(tmp)
class(roundtrip)

## -----------------------------------------------------------------------------
x <- DNAStringSet(c("TTGA", "CTCN"))
q <- PhredQuality(c("*+,-", "6789"))
y <- QualityScaledDNAStringSet(x, q)

library(alabaster.string)
tmp <- tempfile()
saveObject(y, tmp)

roundtrip <- readObject(tmp)
class(roundtrip)

## -----------------------------------------------------------------------------
sessionInfo()

