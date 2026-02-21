# Code example from 'usage_singlecellexperiment' vignette. See references/ for full tutorial.

## ----options, include = FALSE-------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)

## ----prep-h5ad-file-----------------------------------------------------------
library(anndataR)
library(SingleCellExperiment)

h5ad_file <- system.file("extdata", "example.h5ad", package = "anndataR")

## ----read-data----------------------------------------------------------------
sce_obj <- read_h5ad(h5ad_file, as = "SingleCellExperiment")
sce_obj

## ----read-h5ad----------------------------------------------------------------
adata <- read_h5ad(h5ad_file)
sce <- adata$as_SingleCellExperiment()
sce

## ----mapping, fig.cap = "Mapping between `AnnData` and `SingleCellExperiment` objects", fig.wide = TRUE, echo = FALSE----
knitr::include_graphics("../man/figures/AnnData-SCE.png")

## ----ex-mapping---------------------------------------------------------------
adata$as_SingleCellExperiment(
  x_mapping = "counts",
  assays_mapping = c("csc_counts"),
  colData_mapping = c("Int", "IntNA"),
  rowData_mapping = c(rowdata1 = "String", rowdata2 = "total_counts"),
  reducedDims_mapping = list(
    "pca" = c(sampleFactors = "X_pca", featureLoadings = "PCs"),
    "umap" = c(sampleFactors = "X_umap")
  ),
  colPairs_mapping = TRUE,
  rowPairs_mapping = FALSE,
  metadata_mapping = c(value1 = "Bool", value2 = "IntScalar")
)

## ----write-sce----------------------------------------------------------------
write_h5ad(sce_obj, tempfile(fileext = ".h5ad"))

## ----convert-and-write--------------------------------------------------------
adata <- as_AnnData(sce_obj)
adata$write_h5ad(tempfile(fileext = ".h5ad"))

## ----customize-anndata-conversion---------------------------------------------
as_AnnData(
  sce_obj,
  x_mapping = "counts",
  layers_mapping = c("csc_counts"),
  obs_mapping = c(metadata1 = "Int", metadata2 = "IntNA"),
  var_mapping = FALSE,
  obsm_mapping = list(X_pca = "X_pca", X_umap = "X_umap"),
  obsp_mapping = TRUE,
  uns_mapping = c("Bool", "IntScalar")
)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

