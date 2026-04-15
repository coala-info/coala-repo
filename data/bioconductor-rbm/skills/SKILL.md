---
name: bioconductor-rbm
description: This tool performs resampling-based empirical Bayes analysis to identify differentially expressed features in high-throughput genomic data. Use when user asks to identify differential features using moderated t-statistics, perform permutation or bootstrap resampling on microarray data, or conduct two-group and multi-group genomic comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/RBM.html
---

# bioconductor-rbm

name: bioconductor-rbm
description: Use this skill to perform resampling-based empirical Bayes analysis on high-throughput genomic data (such as gene expression or methylation microarrays). This skill should be used when a user needs to identify differentially expressed features using moderated t-statistics combined with permutation or bootstrap resampling methods. It supports two-group comparisons (RBM_T) and multi-group or time-course designs (RBM_F).

# bioconductor-rbm

## Overview
The RBM package implements a resampling-based empirical Bayes approach for identifying differential features in high-throughput data. It builds upon the moderated t-statistics from the `limma` package but calculates p-values through permutation or bootstrap resampling rather than relying on distributional assumptions. This approach is particularly useful for data that may not meet standard parametric assumptions.

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("RBM")
library(RBM)
```

## Core Functions

### RBM_T: Two-Group Comparisons
Use `RBM_T` for simple study designs comparing a treatment group to a control group.

**Parameters:**
- `aData`: A matrix of data with features in rows and samples in columns.
- `vec_trt`: A vector of group labels (e.g., 0 for control, 1 for treatment).
- `repetition`: Number of resamples (e.g., 100 or 1000).
- `alpha`: Significance level.

**Example Workflow:**
```R
# Prepare data and design
data_matrix <- matrix(rnorm(1000*6), 1000, 6)
design <- c(0, 0, 0, 1, 1, 1)

# Execute RBM_T
results <- RBM_T(data_matrix, design, repetition = 100, alpha = 0.05)

# Access p-values
perm_p <- results$permutation_p
boot_p <- results$bootstrap_p

# Apply Benjamini-Hochberg adjustment
adj_p <- p.adjust(perm_p, method = "BH")
significant_features <- which(adj_p <= 0.05)
```

### RBM_F: Multi-Group and Complex Designs
Use `RBM_F` for designs with more than two groups or when specific pairwise comparisons (contrasts) are required.

**Parameters:**
- `aData`: Data matrix.
- `vec_trt`: Group labels (e.g., 0, 1, 2).
- `aContrast`: A character vector of pairwise comparisons. Use the prefix "X" before group labels (e.g., `c("X1-X0", "X2-X0")`).
- `repetition`: Number of resamples.
- `alpha`: Significance level.

**Example Workflow:**
```R
# Prepare data for 3 groups
data_f <- matrix(rnorm(1000*9), 1000, 9)
design_f <- c(0, 0, 0, 1, 1, 1, 2, 2, 2)
contrasts <- c("X1-X0", "X2-X1", "X2-X0")

# Execute RBM_F
results_f <- RBM_F(data_f, design_f, contrasts, repetition = 100, alpha = 0.05)

# Results for the first contrast (X1-X0)
perm_p_con1 <- results_f$permutation_p[, 1]
adj_p_con1 <- p.adjust(perm_p_con1, method = "BH")
```

## Interpreting Results
Both functions return a list containing:
- `ordfit_t`: The original moderated t-statistics from `limma`.
- `ordfit_pvalue`: The p-values from the standard `limma` empirical Bayes approach.
- `permutation_p`: P-values calculated via permutation resampling.
- `bootstrap_p`: P-values calculated via bootstrap resampling.

**Note:** Resampling-based p-values of `0` indicate that the observed statistic was more extreme than all resampled statistics.

## Tips for Success
1. **Data Format**: Ensure input data is a numeric matrix. If using a data frame, convert it using `as.matrix()`.
2. **Resampling Count**: For publication-quality results, increase `repetition` (e.g., 1000), though this increases computation time.
3. **Multiple Testing**: Always apply `p.adjust` to the resulting permutation or bootstrap p-values to control the False Discovery Rate (FDR).
4. **Missing Values**: Check for and handle NAs in your data matrix before running RBM functions, as they can interfere with the underlying linear modeling.

## Reference documentation
- [RBM](./references/RBM.md)