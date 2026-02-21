# Code example from 'bodymapRat' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----loadlibs, message=FALSE, warning=FALSE-----------------------------------
library(SummarizedExperiment) 
library(bodymapRat)

## ----loaddata-----------------------------------------------------------------
bm_rat <- bodymapRat()

# Get the expression data
counts = assay(bm_rat)
dim(counts)
counts[1:5, 1:5]

# Get the meta data along columns
head(colData(bm_rat))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

