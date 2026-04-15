---
name: bioconductor-gloscope
description: GloScope calculates statistical distances between scRNA-Seq samples by treating each sample as a distribution of cells in a low-dimensional embedding space. Use when user asks to compare scRNA-Seq samples, calculate a divergence matrix between patient samples, or visualize sample-level differences using MDS and heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/GloScope.html
---

# bioconductor-gloscope

## Overview

GloScope is a framework for comparing scRNA-Seq samples (e.g., patients or tissue types) by treating each sample as a distribution of cells in a low-dimensional embedding space. It calculates a divergence matrix representing the statistical distance between all pairs of samples, which can then be used for downstream clustering, visualization, and group-level inference.

## Core Workflow

### 1. Data Preparation
GloScope requires a low-dimensional embedding (PCA, scVI, etc.) and sample identifiers.

```r
library(GloScope)
# Example using SingleCellExperiment
data("example_SCE")

# Extract embeddings (rows = cells, cols = dimensions)
# Recommendation: Use 10-30 dimensions; too many can destabilize density estimation
embeddings <- SingleCellExperiment::reducedDim(example_SCE, "PCA")[, 1:10]

# Extract sample labels
sample_ids <- SingleCellExperiment::colData(example_SCE)$sample_id
```

### 2. Divergence Calculation
The `gloscope()` function is the primary entry point. It supports two density estimation methods:
*   **GMM (Default):** Fits Gaussian Mixture Models. Accurate but slower; uses Monte-Carlo approximation.
*   **KNN:** Non-parametric k-nearest neighbors. Faster; useful for large datasets.

```r
# Using KNN for speed
dist_mat <- gloscope(embeddings, sample_ids, dens = "KNN", dist_metric = "KL")

# Using GMM (default) with specific components
dist_mat_gmm <- gloscope(embeddings, sample_ids, 
                         dens = "GMM", 
                         num_components = c(5, 10, 15))
```

### 3. Visualization
Visualize the divergence matrix using Multidimensional Scaling (MDS) or Heatmaps.

```r
# Prepare sample-level metadata
metadata <- as.data.frame(unique(SingleCellExperiment::colData(example_SCE)[, c("sample_id", "phenotype")]))

# MDS Plot
mds_res <- plotMDS(dist_mat = dist_mat, metadata = metadata, 
                   sample_id = "sample_id", color_by = "phenotype")
mds_res$plot

# Heatmap
plotHeatmap(dist_mat, metadata = metadata, 
            sample_id = "sample_id", color_by = "phenotype")
```

### 4. Statistical Inference
Perform permutation tests or bootstrap confidence intervals to test for differences between groups.

```r
# Permutation test (anosim, adonis2, or silhouette)
perm_stats <- getMetrics(dist_mat = dist_mat, metadata = metadata, 
                         sample_id = "sample_id", group_vars = "phenotype", 
                         permuteTest = TRUE)

# Bootstrap Confidence Intervals
boot_res <- bootCI(dist_mat = dist_mat, metadata = metadata, 
                   sample_id = "sample_id", group_vars = "phenotype")
plotCI(boot_res)
```

## Technical Tips

*   **Parallelization:** Use the `BPPARAM` argument for speed. You must use the `BiocParallel::` prefix (e.g., `BPPARAM = BiocParallel::MulticoreParam()`).
*   **Reproducibility:** For GMM (which is stochastic), set the seed inside `BPPARAM`: `BiocParallel::SerialParam(RNGseed = 42)`.
*   **Distance Metrics:** While KL is the default, Jensen-Shannon (`dist_metric = "JS"`) is also available. The square root of JS divergence is a proper distance metric.
*   **Negative Values:** The KNN method may occasionally produce small negative divergence values for very similar samples; these are typically treated as zero or left as-is for MDS.

## Reference documentation

- [scRNA-Seq Population-level Analysis using GloScope (Rmd)](./references/GloScopeTutorial.Rmd)
- [scRNA-Seq Population-level Analysis using GloScope (Markdown)](./references/GloScopeTutorial.md)