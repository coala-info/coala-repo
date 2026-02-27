---
name: bioconductor-scmerge
description: The scMerge package merges and normalizes single-cell RNA-seq data across different batches using stably expressed genes and the RUVIII model. Use when user asks to merge scRNA-seq datasets, remove batch effects, identify negative control genes, or perform scalable hierarchical data integration.
homepage: https://bioconductor.org/packages/release/bioc/html/scMerge.html
---


# bioconductor-scmerge

## Overview

The `scMerge` package provides a framework for merging and normalizing single-cell RNA-seq (scRNA-seq) data from different batches. It utilizes Stably Expressed Genes (SEGs) as negative controls and constructs pseudo-replicates to estimate and remove unwanted variation using the RUVIII model. The package supports unsupervised, supervised, and semi-supervised workflows, and includes `scMerge2` for improved scalability and hierarchical merging.

## Core Workflow

### 1. Prepare Data
Data should be stored in a `SingleCellExperiment` object. Ensure that the batches are combined into a single object and that a log-normalized assay (e.g., "logcounts") is available.

```r
library(scMerge)
library(SingleCellExperiment)

# Example: example_sce contains 'batch' and 'cellTypes' in colData
data("example_sce", package = "scMerge")
```

### 2. Identify Negative Controls (SEGs)
Negative controls are genes with constant expression across datasets. You can use pre-computed lists provided by the package or calculate them from your data.

```r
# Use pre-computed mouse SEGs (Ensembl IDs)
data("segList_ensemblGeneID", package = "scMerge")
ctl_genes <- segList_ensemblGeneID$mouse$mouse_scSEG

# Or compute SEGs from your own data
exprs_mat <- assay(example_sce, "counts")
seg_index <- scSEGIndex(exprs_mat = exprs_mat)
```

### 3. Run scMerge (Original)
Choose a mode based on available cell type information:

*   **Unsupervised:** Requires `kmeansK` (number of clusters per batch).
*   **Supervised:** Uses known `cell_type` labels.
*   **Semi-supervised:** Uses partial labels or mutual nearest clusters (`cell_type_match = TRUE`).

```r
# Unsupervised example
sce_merged <- scMerge(
  sce_combine = example_sce,
  ctl = ctl_genes,
  kmeansK = c(3, 3), # 3 clusters for batch 1, 3 for batch 2
  assay_name = "scMerge_normalized"
)
```

### 4. Run scMerge2 (Scalable & Hierarchical)
`scMerge2` is designed for larger datasets and offers a hierarchical merging strategy.

```r
# Basic scMerge2
scMerge2_res <- scMerge2(
  exprsMat = logcounts(example_sce),
  batch = example_sce$batch,
  ctl = ctl_genes,
  verbose = FALSE
)

# Assign result back to SCE object
assay(example_sce, "scMerge2") <- scMerge2_res$newY
```

## Advanced Features

### Hierarchical Merging (`scMerge2h`)
Useful for complex experimental designs (e.g., removing sample effects within a batch before merging batches).

```r
# Define levels of merging via index lists and batch lists
# level 1: within batch; level 2: across batches
h_idx_list <- list(level1 = split(seq_len(ncol(example_sce)), example_sce$batch),
                   level2 = list(seq_len(ncol(example_sce))))

batch_list <- list(level1 = split(example_sce$sample, example_sce$batch),
                   level2 = list(example_sce$batch))

res_h <- scMerge2h(
  exprsMat = logcounts(example_sce),
  batch_list = batch_list,
  h_idx_list = h_idx_list,
  ctl = ctl_genes,
  ruvK_list = c(2, 5) # K for each level
)
```

### Performance Optimization
*   **Fast SVD:** Use `BSPARAM = BiocSingular::IrlbaParam()` and `svd_k` for large datasets.
*   **Parallelization:** Use `BPPARAM = BiocParallel::MulticoreParam(workers = n)`.
*   **Memory Efficiency:** Supports `DelayedArray`, `SparseArray`, and `HDF5Array` inputs.

## Reference documentation
- [An introduction to the scMerge package](./references/scMerge.md)
- [An introduction to scMerge2](./references/scMerge2.md)