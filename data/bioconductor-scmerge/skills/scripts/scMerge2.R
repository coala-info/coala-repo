# Code example from 'scMerge2' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----loading packages, warning = FALSE, message = FALSE-----------------------
suppressPackageStartupMessages({
    library(SingleCellExperiment)
    library(scMerge)
    library(scater)
})

## ----loading data-------------------------------------------------------------
## Subsetted mouse ESC data
data("example_sce", package = "scMerge")
data("segList_ensemblGeneID", package = "scMerge")

## ----checking raw data--------------------------------------------------------
example_sce = runPCA(example_sce, exprs_values = "logcounts")

scater::plotPCA(example_sce, 
                colour_by = "cellTypes", 
                shape_by = "batch")

## -----------------------------------------------------------------------------
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE)

assay(example_sce, "scMerge2") <- scMerge2_res$newY

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')                                       
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')

## -----------------------------------------------------------------------------
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         cellTypes = example_sce$cellTypes,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE)


assay(example_sce, "scMerge2") <- scMerge2_res$newY

example_sce = scater::runPCA(example_sce, exprs_values = 'scMerge2')                                       
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')

## -----------------------------------------------------------------------------
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         k_pseudoBulk = 50,
                         verbose = FALSE)


assay(example_sce, "scMerge2") <- scMerge2_res$newY

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')                                       
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')

## -----------------------------------------------------------------------------
scMerge2_res <- scMerge2(exprsMat = logcounts(example_sce),
                         batch = example_sce$batch,
                         ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                         verbose = FALSE,
                         return_matrix = FALSE)

cosineNorm_mat <- batchelor::cosineNorm(logcounts(example_sce))
adjusted_means <- DelayedMatrixStats::rowMeans2(cosineNorm_mat)

newY <- list()
for (i in levels(example_sce$batch)) {
    newY[[i]] <- getAdjustedMat(cosineNorm_mat[, example_sce$batch == i], 
                                scMerge2_res$fullalpha,
                                ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                                ruvK = 20,
                                adjusted_means = adjusted_means)
}
newY <- do.call(cbind, newY)

assay(example_sce, "scMerge2") <- newY[, colnames(example_sce)]

set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')                                       
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')


## -----------------------------------------------------------------------------
# Create a fake sample information
example_sce$sample <- rep(c(1:4), each = 50)
table(example_sce$sample, example_sce$batch)

## -----------------------------------------------------------------------------
# Construct a hierarchical index list
h_idx_list <- list(level1 = split(seq_len(ncol(example_sce)), example_sce$batch),
                   level2 = list(seq_len(ncol(example_sce))))

## -----------------------------------------------------------------------------
h_idx_list$level1

## -----------------------------------------------------------------------------
h_idx_list$level2

## -----------------------------------------------------------------------------
# Construct a batch information list
batch_list <- list(level1 = split(example_sce$sample, example_sce$batch),
                   level2 = list(example_sce$batch))

## -----------------------------------------------------------------------------
batch_list$level1

## ----warning=FALSE------------------------------------------------------------
scMerge2_res <- scMerge2h(exprsMat = logcounts(example_sce),
                          batch_list = batch_list,
                          h_idx_list = h_idx_list,
                          ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                          ruvK_list = c(2, 5),
                          verbose = FALSE)

## -----------------------------------------------------------------------------
length(scMerge2_res)
lapply(scMerge2_res, dim)

## -----------------------------------------------------------------------------
assay(example_sce, "scMerge2") <- scMerge2_res[[length(h_idx_list)]]
set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')                           
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')

## -----------------------------------------------------------------------------
h_idx_list2 <- h_idx_list
batch_list2 <- batch_list
h_idx_list2$level1$batch2 <- NULL
batch_list2$level1$batch2 <- NULL
print(h_idx_list2)
print(batch_list2)

## ----warning=FALSE------------------------------------------------------------
scMerge2_res <- scMerge2h(exprsMat = logcounts(example_sce),
                          batch_list = batch_list2,
                          h_idx_list = h_idx_list2,
                          ctl = segList_ensemblGeneID$mouse$mouse_scSEG,
                          ruvK_list = c(2, 5),
                          verbose = FALSE)

## -----------------------------------------------------------------------------
assay(example_sce, "scMerge2") <- scMerge2_res[[length(h_idx_list)]]
set.seed(2022)
example_sce <- scater::runPCA(example_sce, exprs_values = 'scMerge2')                           
scater::plotPCA(example_sce, colour_by = 'cellTypes', shape = 'batch')

## ----session info-------------------------------------------------------------
sessionInfo()

