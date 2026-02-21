# Code example from 'h5ad_on_disk' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  message = FALSE,
  error = FALSE,
  eval = FALSE,
  tidy = FALSE,
  dev = c("png"),
  cache = TRUE
)

## ----example, eval=FALSE------------------------------------------------------
# library(zellkonverter)
# library(SingleCellExperiment)
# 
# # Create SingleCellExperiment object that points to on-disk H5AD file
# sce <- readH5AD(h5ad_file, use_hdf5 = TRUE)

## ----example2, eval=FALSE-----------------------------------------------------
# # Read a series of H5AD files into a list
# # then combine them into a single merged SingleCellExperiment
# sce.lst <- lapply(h5ad_files, function(file) {
#   readH5AD(file, use_hdf5 = TRUE)
# })
# sce <- do.call(cbind, sce.list)

## ----example3, eval=FALSE-----------------------------------------------------
# # read raw/ from H5AD file
# # raw = TRUE tells readH5AD() to read alternative data
# # Must use zellkonverter >=1.3.3
# sce_in <- readH5AD(h5ad_file, use_hdf5 = TRUE, raw = TRUE)
# 
# # use `raw` as counts
# sce <- swapAltExp(sce_in, "raw") # use raw as main
# counts(sce) <- assay(sce, "X") # set counts assay to data in X
# assay(sce, "X") <- NULL # free X

## ----Seurat, eval=FALSE-------------------------------------------------------
# library(SingleCellExperiment)
# library(SeuratDisk)
# 
# # Convert h5ad file to h5seurat format
# Convert(h5ad_file, dest = "h5seurat")
# 
# # load Seurat file
# obj <- LoadH5Seurat(h5seurat_file)
# 
# # Convert Seurat object to SingleCellExperiment
# sce <- as.SingleCellExperiment(obj)

## ----session, echo=FALSE------------------------------------------------------
# sessionInfo()

