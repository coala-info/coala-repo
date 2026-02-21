# Code example from 'usage_python' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
reticulate::py_require("mudata")
reticulate::py_require("scanpy")

# Check if required Python packages are available
python_available <- reticulate::py_module_available("scanpy") &&
  reticulate::py_module_available("mudata")

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  # Set eval based on Python package availability
  eval = python_available
)

## ----python_unavailable, eval=!python_available-------------------------------
message(
  "Python packages scanpy and mudata are required to run this vignette. Code chunks will not be evaluated."
)

## ----python_setup, eval=FALSE-------------------------------------------------
# reticulate::py_require("scanpy")

## ----load_libraries-----------------------------------------------------------
# library(anndataR)
# library(reticulate)
# sc <- import("scanpy")

## ----load_python_data---------------------------------------------------------
# adata <- sc$datasets$pbmc3k_processed()
# adata

## ----apply_python_functions---------------------------------------------------
# sc$pp$filter_cells(adata, min_genes = 200L)
# sc$pp$normalize_total(adata, target_sum = 1e4)
# sc$pp$log1p(adata)

## ----convert_to_sce-----------------------------------------------------------
# sce_obj <- adata$as_SingleCellExperiment()
# sce_obj

## ----convert_to_seurat--------------------------------------------------------
# seurat_obj <- adata$as_Seurat()
# seurat_obj

## ----mudata_setup, eval=FALSE-------------------------------------------------
# reticulate::py_install("mudata")

## ----load_mudata--------------------------------------------------------------
# md <- import("mudata")

## ----load_mudata_example, eval = python_available && requireNamespace("BiocFileCache", quietly = TRUE)----
# cache <- BiocFileCache::BiocFileCache(ask = FALSE)
# h5mu_file <- BiocFileCache::bfcrpath(
#   cache,
#   "https://github.com/gtca/h5xx-datasets/raw/b1177ac8877c89d8bb355b072164384b4e9cc81d/datasets/minipbcite.h5mu"
# )
# 
# mdata <- md$read_h5mu(h5mu_file)

## ----access_modalities--------------------------------------------------------
# rna_mod <- mdata$mod[["rna"]]
# 
# rna_seurat <- rna_mod$as_Seurat()
# print(rna_seurat)
# 
# rna_sce <- rna_mod$as_SingleCellExperiment()
# print(rna_sce)

## ----r-sessioninfo------------------------------------------------------------
# sessionInfo()

## ----python-sessioninfo-------------------------------------------------------
# reticulate::py_config()
# 
# reticulate::py_list_packages()

