---
name: bioconductor-fdrame
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/fdrame.html
---

# bioconductor-fdrame

name: bioconductor-fdrame
description: FDR adjustments for Microarray Experiments using the fdrame package. Use this skill to perform multiple hypothesis testing adjustments on gene expression data, specifically applying Benjamini-Hochberg (BH) linear step-up, adaptive two-stage FDR, and resampling-based FDR procedures.

# bioconductor-fdrame

## Overview
The `fdrame` package provides tools to adjust p-values in microarray experiments to control the False Discovery Rate (FDR). It is particularly useful for identifying differentially expressed genes while managing the expected proportion of false positives. The package supports both theoretical distribution-based adjustments and resampling-based methods that account for inter-gene correlations.

## Core Workflow

### 1. Data Preparation
The package typically operates on a matrix of expression values where rows represent genes and columns represent samples/arrays. You also need a vector defining the classes (groups) for the samples.

```r
library(fdrame)
# Example: expr_data is a matrix, groups is a factor or numeric vector
```

### 2. Computing Adjusted P-values
The primary function is `fdr.ame()`. It computes p-values and applies the selected FDR adjustment method.

```r
# Basic usage for two-group comparison
results <- fdr.ame(x = expr_data, cl = groups, method = "BH")

# For multi-class comparison (ANOVA)
results_anova <- fdr.ame(x = expr_data, cl = groups, method = "BH", type = "f")
```

### 3. Adjustment Methods
Choose the `method` argument based on the experimental design and dependency structure:
- `"BH"`: Standard Benjamini-Hochberg linear step-up procedure.
- `"TST"`: Adaptive Two-Stage procedure (more power by estimating the number of true null hypotheses).
- `"resamp"`: Resampling-based adjustment (best for data with high inter-gene correlations).

### 4. Resampling Options
When using `method = "resamp"`, you can specify the estimation type:
- `resamp.adj = "point"`: BH point estimate using resampled p-values.
- `resamp.adj = "local"`: FDR local estimator (conservative on the mean).
- `resamp.adj = "upper"`: FDR upper limit (bounds FDR with 95% probability).

```r
# Resampling with 1000 iterations
res_resamp <- fdr.ame(expr_data, groups, method = "resamp", 
                      resamp.adj = "point", iterations = 1000)
```

## Visualizing Results
The package provides plotting functions to diagnose the preprocessing and select FDR thresholds.

```r
# Plot adjusted p-values vs. rank
plot(results)

# Plot adjusted p-values vs. estimated differences
# (Only applicable for two-class comparisons)
plot(results, v = "diff")
```

## Tips for Success
- **Class Labels**: For two-class comparisons, ensure `cl` contains exactly two levels (e.g., 0 and 1). For ANOVA, ensure `cl` contains multiple levels.
- **Iteration Count**: For resampling, the default is often low for testing. Increase `iterations` (e.g., 1000+) for publication-quality results, though this increases computation time.
- **Interpretation**: An adjusted p-value (q-value) of 0.05 means that if you reject all hypotheses with values below this threshold, the expected proportion of false discoveries is 5%.

## Reference documentation
- [FDR adjustments of Microarray Experiments (FDR-AME)](./references/fdrame.md)