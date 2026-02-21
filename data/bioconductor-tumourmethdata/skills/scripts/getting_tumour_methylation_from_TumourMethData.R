# Code example from 'getting_tumour_methylation_from_TumourMethData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = F-------------------------------------------------------
library(TumourMethData)

## ----eval=TRUE----------------------------------------------------------------
# Show available methylation datasets
data("TumourMethDatasets", package = "TumourMethData")
print(TumourMethDatasets)

## ----eval=TRUE----------------------------------------------------------------
# Download esophageal WGBS data
mcrpc_wgbs_hg38_chr11 = download_meth_dataset(dataset = "mcrpc_wgbs_hg38_chr11")
print(mcrpc_wgbs_hg38_chr11)

## -----------------------------------------------------------------------------
sessionInfo()

