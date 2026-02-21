---
name: bioconductor-emdomics
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/EMDomics.html
---

# bioconductor-emdomics

name: bioconductor-emdomics
description: Analyzing differences in genomics data (gene expression) between groups using Earth Mover's Distance (EMD), Kolmogorov-Smirnov (K-S), and Cramer von Mises (CVM) distribution comparison tests. Use this skill when you need to perform non-parametric distribution comparisons across two or more sample groups to identify significantly differentially expressed genes.

# bioconductor-emdomics

## Overview

The `EMDomics` package provides a quantitative framework for comparing gene expression distributions across different sample groups. Unlike methods that focus solely on mean expression (like t-tests), EMDomics accounts for the entire distribution shape, making it sensitive to changes in multi-modal distributions or subtle shifts that traditional metrics might miss. It supports two-class and multi-class (3+ groups) analyses and provides permutation-based q-values for significance testing.

## Core Workflow

### 1. Data Preparation
The package requires a gene expression matrix and a named vector of group labels.

```r
# Matrix: rows = genes, columns = samples
data_matrix <- matrix(rnorm(10000), nrow=100, ncol=100)
rownames(data_matrix) <- paste0("gene", 1:100)
colnames(data_matrix) <- paste0("sample", 1:100)

# Labels: named vector mapping sample IDs to groups
labels <- c(rep("A", 50), rep("B", 50))
names(labels) <- colnames(data_matrix)
```

### 2. Calculating Significance
The primary function is `calculate_emd`. It performs the EMD calculation and runs permutations to generate q-values.

```r
library(EMDomics)

# nperm: number of permutations (100+ recommended for research)
# parallel: set to TRUE for faster processing on multi-core systems
results <- calculate_emd(data_matrix, labels, nperm=100, parallel=TRUE)

# Access results
emd_stats <- results$emd
head(emd_stats) # Columns: emd, q-value
```

### 3. Alternative Distribution Tests
If EMD is not desired, the package provides identical syntax for K-S and CVM tests:
- `calculate_ks(data, labels, ...)`
- `calculate_cvm(data, labels, ...)`

### 4. Multi-class Analysis
In experiments with >2 groups, the EMD score is the average of all pairwise EMD scores. To see specific group differences, check the pairwise table:

```r
# View pairwise comparisons (e.g., A vs B, A vs C, B vs C)
pairwise_table <- results$pairwise.emd.table
```

## Visualization

`EMDomics` includes built-in plotting functions to interpret results:

- **Distribution Comparison**: `plot_emd_density(results, "gene_name")` - Visualizes the density of each group for a specific gene.
- **Permutation Distribution**: `plot_emdperms(results)` - Shows a histogram of all calculated EMD scores.
- **Null Distribution**: `plot_emdnull(results)` - Plots the calculated EMD vs. the median of permuted EMDs to visualize significance.

## Tips and Best Practices
- **Sample Names**: Ensure the `names()` of your labels vector exactly match the `colnames()` of your data matrix.
- **Permutations**: For publication-quality results, use at least 100-1000 permutations.
- **Single Gene Analysis**: Use `calculate_emd_gene(expression_vector, labels, sample_names)` for quick testing of a single feature.
- **Interpretation**: A higher EMD score indicates a greater "work" required to transform one distribution into another, signifying a larger difference in expression patterns.

## Reference documentation
- [EMDomics](./references/EMDomics.md)