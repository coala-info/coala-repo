# Code example from 'usage_seurat' vignette. See references/ for full tutorial.

## ----options, include = FALSE-------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)

## ----prep-file----------------------------------------------------------------
library(anndataR)
library(Seurat)

h5ad_file <- system.file("extdata", "example.h5ad", package = "anndataR")

## ----read-data----------------------------------------------------------------
seurat_obj <- read_h5ad(h5ad_file, as = "Seurat")
seurat_obj

## ----convert-seurat-----------------------------------------------------------
adata <- read_h5ad(h5ad_file)
seurat_obj <- adata$as_Seurat()
seurat_obj

## ----mapping, fig.cap = "Mapping between `AnnData` and `Seurat` objects", fig.wide = TRUE, echo = FALSE----
knitr::include_graphics("../man/figures/AnnData-Seurat.png")

## ----customize-seurat-conversion----------------------------------------------
seurat_obj <- adata$as_Seurat(
  layers_mapping = c("counts", "dense_counts"),
  object_metadata_mapping = c(metadata1 = "Int", metadata2 = "Float"),
  assay_metadata_mapping = FALSE,
  reduction_mapping = list(
    pca = c(key = "PC_", embeddings = "X_pca", loadings = "PCs"),
    umap = c(key = "UMAP_", embeddings = "X_umap")
  ),
  graph_mapping = TRUE,
  misc_mapping = c(misc1 = "Bool", misc2 = "IntScalar")
)
seurat_obj

## ----write-seurat-------------------------------------------------------------
write_h5ad(seurat_obj, tempfile(fileext = ".h5ad"))

## ----convert-to-anndata-------------------------------------------------------
adata <- as_AnnData(seurat_obj)
adata$write_h5ad(tempfile(fileext = ".h5ad"))

## ----customize-anndata-conversion---------------------------------------------
adata <- as_AnnData(
  seurat_obj,
  assay_name = "RNA",
  x_mapping = "counts",
  layers_mapping = c("dense_counts"),
  obs_mapping = c(RNA_count = "nCount_RNA", metadata1 = "metadata1"),
  var_mapping = FALSE,
  obsm_mapping = list(X_pca = "pca", X_umap = "umap"),
  obsp_mapping = TRUE,
  uns_mapping = c("misc1", "misc2")
)
adata

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

