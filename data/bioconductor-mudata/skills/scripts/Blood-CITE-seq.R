# Code example from 'Blood-CITE-seq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# library(remotes)
# remotes::install_github("ilia-kats/MuData")

## ----setup, message = FALSE---------------------------------------------------
library(MuData)
library(SingleCellExperiment)
library(MultiAssayExperiment)
library(CiteFuse)
library(scater)

library(rhdf5)

## -----------------------------------------------------------------------------
data("CITEseq_example", package = "CiteFuse")
lapply(CITEseq_example, dim)

## -----------------------------------------------------------------------------
sce_citeseq <- preprocessing(CITEseq_example)
sce_citeseq

## -----------------------------------------------------------------------------
sce_citeseq <- scater::logNormCounts(sce_citeseq)
sce_citeseq  # new assay: logcounts

## -----------------------------------------------------------------------------
sce_citeseq <- CiteFuse::normaliseExprs(
  sce_citeseq, altExp_name = "ADT", transform = "log"
)
altExp(sce_citeseq, "ADT")  # new assay: logcounts

## -----------------------------------------------------------------------------
sce_citeseq <- scater::runPCA(
  sce_citeseq, exprs_values = "logcounts", ncomponents = 20
)

## -----------------------------------------------------------------------------
scater::plotReducedDim(sce_citeseq, dimred = "PCA", 
                       by_exprs_values = "logcounts", colour_by = "CD27")

## -----------------------------------------------------------------------------
experiments <- list(
  ADT = altExp(sce_citeseq, "ADT"),
  HTO = altExp(sce_citeseq, "HTO")
)

# Drop other modalities from sce_citeseq
altExp(sce_citeseq) <- NULL
experiments[["RNA"]] <- sce_citeseq

mae <- MultiAssayExperiment(experiments)

## -----------------------------------------------------------------------------
writeH5MU(mae, "citefuse_example.h5mu")

## -----------------------------------------------------------------------------
h5 <- rhdf5::H5Fopen("citefuse_example.h5mu")
h5ls(H5Gopen(h5, "mod"), recursive = FALSE)

## -----------------------------------------------------------------------------
h5ls(H5Gopen(h5, "mod/ADT"), FALSE)
h5ls(H5Gopen(h5, "mod/ADT/layers"), FALSE)

## -----------------------------------------------------------------------------
h5ls(H5Gopen(h5, "mod/RNA/obsm"), FALSE)
# There is an alternative way to access groups:
# h5&'mod'&'RNA'&'obsm'
rhdf5::H5close()

## -----------------------------------------------------------------------------
sessionInfo()

