---
name: bioconductor-cepo
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/Cepo.html
---

# bioconductor-cepo

## Overview

Cepo is a Bioconductor package designed to identify genes that govern cell identity using a metric called **Differential Stability (DS)**. Unlike standard Differential Expression (DE) methods that focus on changes in mean abundance, Cepo prioritizes genes that show stable expression patterns within a cell type compared to others. This approach is computationally efficient, making it ideal for large single-cell atlases.

## Core Workflow

### 1. Data Preparation
Cepo requires a normalized expression matrix (e.g., log-counts, CPM) and a vector of cell-type labels.

```r
library(Cepo)
library(SingleCellExperiment)

# Input: log-normalized matrix and cell type labels
# exprsMat: genes (rows) x cells (columns)
# cellTypes: vector of labels corresponding to columns
ds_res <- Cepo(exprsMat = logcounts(sce), 
               cellTypes = sce$celltype)
```

### 2. Filtering and Refinement
You can filter for lowly expressed genes or minimum log fold-change directly within the `Cepo` function:
- `exprsPct`: Keep genes expressed in at least X% of cells in at least one cell type (recommended: 0.05 to 0.07).
- `logfc`: Keep genes with at least X absolute log fold-change.

```r
ds_res_filtered <- Cepo(exprsMat = logcounts(sce),
                        cellTypes = sce$celltype,
                        exprsPct = 0.05,
                        logfc = 0.2)
```

### 3. Handling Batches
If the data contains batches, use the `block` argument to perform analysis independently per batch and then average the results.

```r
ds_res_batches <- Cepo(exprsMat = logcounts(sce),
                       cellTypes = sce$celltype,
                       block = sce$batch)

# Access averaged results
avg_stats <- ds_res_batches$average$stats
```

### 4. Significance Testing
Cepo supports two p-value computation methods:
- **Fast approach (Default)**: Uses normal approximation (set `computePvalue` to ~200).
- **Permutation approach**: Set `computeFastPvalue = FALSE` (recommended `computePvalue = 10000`).

```r
ds_res_p <- Cepo(exprsMat = logcounts(sce),
                 cellTypes = sce$celltype,
                 computePvalue = 200)
```

## Interpreting and Visualizing Results

### Extracting Top Genes
Use `topGenes` to retrieve the most stable markers for each cell type.

```r
# Get top 10 identity genes per cell type
top_markers <- topGenes(ds_res, n = 10)
```

### Visualization
Cepo provides `plotDensities` to visualize the expression distribution of identified genes across cell types.

```r
plotDensities(x = sce,
              cepoOutput = ds_res,
              nGenes = 2,
              assay = "logcounts",
              celltypeColumn = "celltype")
```

## Large-Scale Data (Out-of-Memory)
For datasets with millions of cells, Cepo integrates with `HDF5Array` and `DelayedArray` to perform computations without loading the entire matrix into RAM.

```r
library(HDF5Array)
library(BiocParallel)

# Wrap matrix as HDF5
da_matrix <- DelayedArray(realize(logcounts(sce), "HDF5Array"))

# Optional: Set up parallel processing
DelayedArray::setAutoBPPARAM(BPPARAM = MulticoreParam(workers = 4))

da_output <- Cepo(exprsMat = da_matrix, cellTypes = sce$celltype)
```

## Tips for Success
- **Input Scale**: Always use normalized data (log-counts or CPM). Raw counts are not appropriate for DS analysis.
- **Cell Labels**: Ensure `cellTypes` is a factor or character vector of the same length as the number of columns in your matrix.
- **Downstream**: The DS statistics from `ds_res$stats` can be used directly as ranked lists for Gene Set Enrichment Analysis (GSEA) using packages like `fgsea`.

## Reference documentation
- [Cepo for differential stability analysis of scRNA-seq data](./references/cepo.md)