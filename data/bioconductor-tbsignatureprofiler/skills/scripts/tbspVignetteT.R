# Code example from 'tbspVignetteT' vignette. See references/ for full tutorial.

## ----load_profiler, eval = FALSE----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("TBSignatureProfiler")

## ----setup--------------------------------------------------------------------
suppressPackageStartupMessages({
  library(TBSignatureProfiler)
  library(SummarizedExperiment)
})

## ----Run_shiny_app, eval = FALSE----------------------------------------------
# TBSPapp()

## ----loading_data-------------------------------------------------------------
## HIV/TB gene expression data, included in the package
hivtb_data <- get0("TB_hiv", envir = asNamespace("TBSignatureProfiler"))

### Note that we have 25,369 genes, 33 samples, and 1 assay of counts
dim(hivtb_data)

# We start with only one assay
assays(hivtb_data)

## ----add_assays---------------------------------------------------------------
## Make a log counts, CPM and log CPM assay
hivtb_data <- mkAssay(hivtb_data, log = TRUE, counts_to_CPM = TRUE)

### Check to see that we now have 4 assays
assays(hivtb_data)

## ----run_data-----------------------------------------------------------------
## List all signatures in the profiler
data("TBsignatures")
names(TBsignatures)

## We can use all of these signatures for further analysis
siglist_hivtb <- names(TBsignatures)

## ----session info-------------------------------------------------------------
sessionInfo()


