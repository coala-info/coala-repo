# Code example from 'MouseThymusAgeing' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("MouseThymusAgeing")

## ----Load, message=FALSE------------------------------------------------------
library(MouseThymusAgeing)

## -----------------------------------------------------------------------------
head(SMARTseqMetadata, n = 5)

## -----------------------------------------------------------------------------
head(DropletMetadata, n = 5)

## ----message=FALSE------------------------------------------------------------
smart.sce <- MouseSMARTseqData(samples="day2")
smart.sce

## ----message=FALSE------------------------------------------------------------
head(counts(smart.sce)[, 1:10])

## -----------------------------------------------------------------------------
head(sizeFactors((smart.sce)))

## ----message=FALSE------------------------------------------------------------
library(scuttle)
smart.sce <- logNormCounts(smart.sce)

## ----message=FALSE------------------------------------------------------------
head(colData(smart.sce))

## -----------------------------------------------------------------------------
sessionInfo()

