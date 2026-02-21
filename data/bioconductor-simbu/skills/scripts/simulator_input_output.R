# Code example from 'simulator_input_output' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(Seurat)
library(curl)
library(SimBu)

## -----------------------------------------------------------------------------
counts <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::t(1e6 * Matrix::t(tpm) / Matrix::colSums(tpm))
colnames(counts) <- paste0("cell-", rep(1:300))
colnames(tpm) <- paste0("cell-", rep(1:300))
rownames(counts) <- paste0("gene-", rep(1:1000))
rownames(tpm) <- paste0("gene-", rep(1:1000))
annotation <- data.frame(
  "ID" = paste0("cell-", rep(1:300)),
  "cell_type" = c(
    rep("T cells CD4", 50),
    rep("T cells CD8", 50),
    rep("Macrophages", 100),
    rep("NK cells", 10),
    rep("B cells", 70),
    rep("Monocytes", 20)
  ),
  row.names = paste0("cell-", rep(1:300))
)
seurat_obj <- Seurat::CreateSeuratObject(counts = counts, assay = "gene_expression", meta.data = annotation)
# store normalized matrix in the 'data' layer
SeuratObject::LayerData(seurat_obj, assay = "gene_expression", layer = "data") <- tpm
seurat_obj

## -----------------------------------------------------------------------------
ds_seurat <- SimBu::dataset_seurat(
  seurat_obj = seurat_obj,
  counts_layer = "counts",
  cell_id_col = "ID",
  cell_type_col = "cell_type",
  tpm_layer = "data",
  name = "seurat_dataset"
)

## -----------------------------------------------------------------------------
# example h5ad file, where cell type info is stored in `obs` layer
# h5 <- system.file("extdata", "anndata.h5ad", package = "SimBu")
# ds_h5ad <- SimBu::dataset_h5ad(
#  h5ad_file_counts = h5,
#  name = "h5ad_dataset",
#  cell_id_col = 0, # this will use the rownames of the metadata as cell identifiers
#  cell_type_col = "group", # this will use the 'group' column of the metadata as cell type info
#  cells_in_obs = TRUE # in case your cell information is stored in the var layer, switch to FALSE
# )

## -----------------------------------------------------------------------------
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  tpm_matrix = tpm,
  name = "test_dataset"
)
ds_multiple <- SimBu::dataset_merge(
  dataset_list = list(ds_seurat, ds),
  name = "ds_multiple"
)

## -----------------------------------------------------------------------------
simulation <- SimBu::simulate_bulk(
  data = ds_multiple,
  scenario = "random",
  scaling_factor = "NONE",
  nsamples = 10, ncells = 100
)
dim(SummarizedExperiment::assays(simulation$bulk)[["bulk_counts"]])
dim(SummarizedExperiment::assays(simulation$bulk)[["bulk_tpm"]])

## -----------------------------------------------------------------------------
utils::sessionInfo()

