---
name: bioconductor-decontx
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/decontX.html
---

# bioconductor-decontx

name: bioconductor-decontx
description: Decontamination of single-cell RNA-seq (scRNA-seq) and protein expression (CITE-seq/Total-seq) data. Use this skill to estimate and remove ambient RNA or background protein contamination from count matrices or SingleCellExperiment objects using the decontX and decontPro algorithms.

# bioconductor-decontx

## Overview

The `decontX` package provides Bayesian methods to identify and remove contamination in single-cell datasets. It contains two primary algorithms:
1. **decontX**: Designed for scRNA-seq data to remove ambient RNA cross-contamination.
2. **decontPro**: Designed for single-cell protein expression data (e.g., ADT counts from CITE-seq) to remove ambient and non-specific background contamination.

Both methods decompose observed counts into native expression and contamination components, improving downstream clustering and visualization.

## Workflow for scRNA-seq (decontX)

### 1. Data Input
`decontX` accepts either a `SingleCellExperiment` (SCE) object or a sparse counts matrix.

```r
library(decontX)
# Using a SingleCellExperiment
sce <- decontX(sce)

# Using a matrix
result <- decontX(counts_matrix)
# Decontaminated counts are in result$decontXcounts
```

### 2. Using Background Data
If available, providing a "raw" or "droplet" matrix (containing empty droplets) improves the estimation of the ambient RNA profile.

```r
sce <- decontX(sce, background = sce_raw)
```

### 3. Cell Clustering
`decontX` performs heuristic clustering by default. If you have pre-defined cell labels, provide them via the `z` parameter to improve accuracy.

```r
sce <- decontX(sce, z = my_cluster_labels)
```

### 4. Accessing Results
* **Contamination Score**: Found in `colData(sce)$decontX_contamination` (0 to 1 scale).
* **Decontaminated Counts**: Accessed via `decontXcounts(sce)`.

## Workflow for Protein Data (decontPro)

### 1. Preparation
`decontPro` requires a counts matrix and a vector of cell clusters.

```r
# counts: matrix of ADT counts
# clusters: integer vector of cluster assignments
out <- decontPro(counts, clusters)
```

### 2. Tuning Priors
For small or highly contaminated datasets, adjust `delta_sd` and `background_sd`. Larger values increase the model's flexibility to identify contamination.

```r
out <- decontPro(counts, clusters, delta_sd = 2e-4, background_sd = 2e-5)
```

### 3. Results
The decontaminated matrix is stored in `out$decontaminated_counts`.

## Visualization and QC

### scRNA-seq (celda package integration)
Use the `celda` package for specialized `decontX` plots:
* `plotDecontXContamination(sce)`: Visualizes contamination levels on a UMAP.
* `plotDecontXMarkerPercentage(sce, markers = list(...))`: Compares marker detection before and after decontamination.
* `plotDecontXMarkerExpression(sce, markers = c(...))`: Violin plots of marker expression.

### Protein Data
* `plotDensity(counts, decont_counts, features)`: Compares ADT density distributions. Background peaks should disappear after decontamination.
* `plotBoxByCluster(counts, decont_counts, clusters, features)`: Visualizes changes per cluster.

## Integration with Seurat

To use `decontX` results in a Seurat workflow:

```r
# From Seurat to decontX
counts <- GetAssayData(seurat_obj, slot = "counts")
sce <- SingleCellExperiment(list(counts = counts))
sce <- decontX(sce)

# Back to Seurat (Note: round decontaminated counts)
seurat_obj[["decontXcounts"]] <- CreateAssayObject(counts = round(decontXcounts(sce)))
```

## Reference documentation

- [Decontamination of single cell protein expression data with DecontPro](./references/decontPro.md)
- [Decontamination of ambient RNA in single-cell genomic data with DecontX](./references/decontX.md)