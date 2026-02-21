---
name: bioconductor-cellmixs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CellMixS.html
---

# bioconductor-cellmixs

name: bioconductor-cellmixs
description: Evaluate and visualize data integration and batch effects in single-cell RNA-seq data. Use this skill to calculate Cellspecific Mixing Scores (CMS), Local Density Differences (ldfDiff), and other integration metrics (entropy, ISI) to quantify batch mixing and structural preservation.

# bioconductor-cellmixs

## Overview

CellMixS is a Bioconductor package designed to quantify and visualize batch effects in single-cell RNA-seq data. It is particularly useful for evaluating the performance of data integration methods. Its two primary metrics are:
1. **Cellspecific Mixing Score (CMS)**: A test for batch effects within k-nearest neighborhoods.
2. **Local Density Differences (ldfDiff)**: A score that measures how much the internal structure of a batch is preserved after integration.

The package works primarily with `SingleCellExperiment` objects.

## Typical Workflow

### 1. Initial Visualization
Before quantifying, visualize the batch distribution on a reduced dimension plot (e.g., UMAP or TSNE).

```r
library(CellMixS)
library(scater)

# Visualize batch distribution
visGroup(sce, group = "batch", dim_red = "UMAP")
```

### 2. Quantify Batch Mixing (CMS)
The `cms` function calculates a p-value for each cell, testing the hypothesis that batches are well-mixed in its neighborhood.

```r
# Calculate CMS
# k: number of neighbors (default 30)
# group: the colData column containing batch labels
sce <- cms(sce, k = 30, group = "batch", res_name = "unaligned")

# Visualize results
visHist(sce, metric = "cms.unaligned") # Histogram of p-values
visMetric(sce, metric_var = "cms_smooth.unaligned") # CMS on UMAP
```
*   **Interpretation**: A flat p-value histogram indicates good mixing. An enrichment of low p-values indicates batch-specific bias.

### 3. Evaluate Data Integration
After running integration (e.g., MNN, Harmony, or limma), use `cms` on the integrated embeddings or corrected counts.

```r
# Using integrated embeddings (e.g., MNN)
sce <- cms(sce, k = 30, group = "batch", dim_red = "MNN", res_name = "MNN")

# Using corrected counts (e.g., limma)
sce <- cms(sce, k = 30, group = "batch", assay_name = "limma_corrected", res_name = "limma")
```

### 4. Check Structural Preservation (ldfDiff)
Use `ldfDiff` to ensure integration hasn't distorted the local density of cells within their original batches.

```r
# Requires a list of SCE objects (one per batch) representing the pre-integrated state
sce_pre_list <- list("batch1" = sce[, sce$batch == "1"], "batch2" = sce[, sce$batch == "2"])

sce <- ldfDiff(sce_pre_list, sce_combined = sce, group = "batch", 
               k = 70, dim_red = "PCA", dim_combined = "MNN", res_name = "MNN")

# Visualize structural changes
visIntegration(sce, metric = "diff_ldf", metric_name = "ldfDiff")
```
*   **Interpretation**: `ldfDiff` scores should be centered around 0. Large deviations suggest the integration method has altered the data's internal structure.

### 5. Multi-Metric Evaluation
The `evalIntegration` wrapper allows running multiple metrics (ISI, entropy, CMS) simultaneously.

```r
sce <- evalIntegration(metrics = c("isi", "entropy", "cms"), 
                       sce, group = "batch", k = 30)

# Summary overview
visOverview(sce, group = "batch", metric = c("cms_smooth", "isi", "entropy"))
```

## Key Functions and Parameters

- **`cms(sce, k, group, dim_red, res_name, ...)`**: Main mixing score function.
    - `k`: Neighborhood size. Should not exceed the size of the smallest cell population.
    - `dim_red`: The reduced dimension slot to use (e.g., "PCA", "UMAP", "MNN").
- **`ldfDiff(sce_pre_list, sce_combined, group, ...)`**: Measures structural preservation.
    - `sce_pre_list`: List of SCE objects before integration, named by batch levels.
- **`visGroup()` / `visMetric()`**: Plotting functions for categorical (batch) and continuous (CMS) variables.
- **`visHist()`**: Plots p-value distributions. Essential for interpreting CMS results.
- **`visCluster()`**: Boxplots of metrics across clusters or cell types to identify specific populations that are poorly integrated.

## Tips for Success
- **Neighborhood Definition**: If cell populations are of very different sizes, consider using `k_min` or `batch_min` in `cms` to allow for dynamic neighborhood sizes.
- **Smoothing**: `cms` provides both `cms` (raw) and `cms_smooth` (weighted mean of neighborhood). `cms_smooth` is generally better for visualization.
- **Input Format**: Ensure the `group` variable is a factor in the `colData` of your `SingleCellExperiment`.

## Reference documentation
- [CellMixS](./references/CellMixS.md)