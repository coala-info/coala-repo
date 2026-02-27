---
name: bioconductor-qsmooth
description: The qsmooth package performs smooth quantile normalization to balance global distribution alignment with the preservation of biological differences between groups. Use when user asks to normalize gene expression data, account for biological group variability during normalization, or handle sample-specific GC-content bias.
homepage: https://bioconductor.org/packages/release/bioc/html/qsmooth.html
---


# bioconductor-qsmooth

## Overview

The `qsmooth` package implements **smooth quantile normalization**, a generalization of quantile normalization. Standard quantile normalization assumes that the statistical distribution of all samples should be identical, which can erase true biological differences between experimental groups (e.g., different tissues). 

`qsmooth` calculates a weight for every quantile that balances two assumptions:
1. All samples should have the same distribution (Global Quantile Normalization).
2. Samples should only have the same distribution within their biological groups (Quantile Normalization within groups).

The method "shrinks" group-level quantiles toward a global reference based on the ratio of between-group variability to within-group variability.

## Typical Workflow

### 1. Data Preparation
The input should be a matrix or data frame of expression values (rows = features/genes, columns = samples). It is common to filter out low-count features before normalization.

```r
library(qsmooth)

# Example: counts is a matrix of gene expression
# group_factor is a vector or factor defining biological groups (e.g., "Brain", "Liver")
groups <- factor(c(rep("GroupA", 8), rep("GroupB", 8)))
```

### 2. Running qsmooth
The primary function is `qsmooth()`.

```r
# Basic usage
qs_results <- qsmooth(object = counts, group_factor = groups)

# Extract the normalized data
normalized_counts <- qsmoothData(qs_results)

# Extract the weights calculated for each quantile
weights <- qsmoothWeights(qs_results)
```

### 3. Handling GC-Content Bias
If your data (like RNA-Seq) exhibits sample-specific GC-content bias, use `qsmoothGC`.

```r
# gc_vector contains GC content for each gene
qs_gc_results <- qsmoothGC(object = counts, 
                           gc = gc_vector, 
                           group_factor = groups)

normalized_gc_counts <- qsmoothData(qs_gc_results)
```

### 4. Visualization and Interpretation
Use the built-in plotting function to see how the weights vary across quantiles.

```r
# Plot weights: 1 = Global Quantile Norm, 0 = Within-group Quantile Norm
qsmoothPlotWeights(qs_results)
```
*   **Weights near 1:** Suggests standard quantile normalization is appropriate (no major distributional differences between groups).
*   **Weights near 0:** Suggests significant biological differences between groups; `qsmooth` is preserving these differences.

## Function Parameters

*   `object`: Matrix or data frame of numeric values.
*   `group_factor`: A factor or vector representing the biological groups.
*   `batch`: (Optional) A factor for batch effects. If provided, `ComBat` from the `sva` package is run internally before normalization.
*   `norm_factors`: (Optional) Scaling factors to apply before the `qsmooth` algorithm.
*   `window`: The window size for the rolling median (default is 0.05, or 5% of the number of rows).

## Tips for Success
*   **Log Transformation:** While `qsmooth` can be run on raw counts, visualization (boxplots/density plots) is usually performed on `log2(counts + 1)`.
*   **Filtering:** Always filter out genes with very low or zero counts across most samples before running `qsmooth` to avoid artifacts in the lower quantiles.
*   **Comparison:** Use the `quantro` package beforehand to test if there are global differences between groups that justify using `qsmooth` over standard quantile normalization.

## Reference documentation

- [The qsmooth user's guide](./references/qsmooth.md)