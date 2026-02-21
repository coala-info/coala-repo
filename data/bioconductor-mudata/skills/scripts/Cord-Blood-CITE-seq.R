# Code example from 'Cord-Blood-CITE-seq' vignette. See references/ for full tutorial.

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
library(SingleCellMultiModal)
library(scater)

library(rhdf5)

## -----------------------------------------------------------------------------
mae <- CITEseq(
    DataType="cord_blood", modes="*", dry.run=FALSE, version="1.0.0"
)

mae

## -----------------------------------------------------------------------------
# Define CLR transformation as in the Seurat workflow
clr <- function(data) t(
  apply(data, 1, function(x) log1p(
    x / (exp(sum(log1p(x[x > 0]), na.rm = TRUE) / length(x)))
  ))
)

## -----------------------------------------------------------------------------
adt_counts <- mae[["scADT"]]

mae[["scADT"]] <- SingleCellExperiment(adt_counts)
assay(mae[["scADT"]], "clr") <- clr(adt_counts)

## -----------------------------------------------------------------------------
mae[["scADT"]] <- runPCA(
  mae[["scADT"]], exprs_values = "clr", ncomponents = 20
)

## -----------------------------------------------------------------------------
plotReducedDim(mae[["scADT"]], dimred = "PCA",
               by_exprs_values = "clr", colour_by = "CD3")
plotReducedDim(mae[["scADT"]], dimred = "PCA",
               by_exprs_values = "clr", colour_by = "CD14")

## -----------------------------------------------------------------------------
writeH5MU(mae, "cord_blood_citeseq.h5mu")

## -----------------------------------------------------------------------------
h5 <- rhdf5::H5Fopen("cord_blood_citeseq.h5mu")
h5ls(H5Gopen(h5, "mod"), recursive = FALSE)

## -----------------------------------------------------------------------------
h5ls(H5Gopen(h5, "mod/scADT"), recursive = FALSE)
h5ls(H5Gopen(h5, "mod/scADT/layers"), recursive = FALSE)

## -----------------------------------------------------------------------------
h5ls(H5Gopen(h5, "mod/scADT/obsm"), recursive = FALSE)
# There is an alternative way to access groups:
# h5&'mod'&'scADT'&'obsm'
rhdf5::H5close()

## -----------------------------------------------------------------------------
sessionInfo()

