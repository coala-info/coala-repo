---
name: bioconductor-sscore
description: This tool performs probe-level comparative analysis of Affymetrix GeneChip data using the S-Score algorithm to identify differential gene expression. Use when user asks to perform pairwise comparisons of GeneChips, calculate significance scores from probe intensities, or identify differentially expressed genes without a separate normalization step.
homepage: https://bioconductor.org/packages/3.5/bioc/html/sscore.html
---


# bioconductor-sscore

name: bioconductor-sscore
description: Analysis of Affymetrix GeneChip data using the S-Score algorithm. Use this skill to perform probe-level comparative analysis between two conditions (with or without replicates) to identify differential gene expression. It is particularly useful when users want to bypass the expression summary step and work directly with probe intensities to calculate significance scores that follow a standard normal distribution.

## Overview

The `sscore` package implements the S-Score algorithm, which provides a statistical method for comparing two GeneChips (or two groups of chips) directly from probe-level data. Unlike other methods that require a separate normalization and summarization step (like RMA or MAS5), the S-Score produces a value that follows a standard normal distribution ($N(0,1)$) under the null hypothesis of no differential expression.

## Core Workflow

### 1. Data Preparation
The package operates on `AffyBatch` objects. You must have the original `.CEL` files available in your working directory or a specified path, as the algorithm accesses them to handle outliers and masking.

```R
library(sscore)
library(affy)

# Load .CEL files into an AffyBatch object
# Ensure .CEL files are in the current directory or specify celfile.path
data <- ReadAffy()
```

### 2. Single Pairwise Comparison
To compare two specific chips, use the `SScore` function.

```R
# Basic comparison of the first two samples
# SF (Scale Factor) and SDT (Standard Difference Threshold) 
# are calculated automatically if not provided.
results <- SScore(data[, 1:2])

# Extract S-Score values
scores <- exprs(results)
```

### 3. Multi-chip (Replicate) Comparison
For comparisons involving replicates (two-class comparison), use the `classlabel` parameter.

```R
# Compare 3 chips in class 0 vs 3 chips in class 1
labels <- c(0, 0, 0, 1, 1, 1)
results_multi <- SScore(data, classlabel = labels)
```

### 4. Batch Pairwise Comparisons
To perform multiple specific pairwise comparisons at once, use `SScoreBatch` with a comparison matrix.

```R
# Define pairs: (1 vs 2) and (1 vs 3)
compare_mat <- matrix(c(1, 2, 1, 3), ncol = 2, byrow = TRUE)
batch_results <- SScoreBatch(data, compare = compare_mat)
```

## Interpreting Results

Since S-Scores follow a standard normal distribution:
- **Significance:** An absolute S-Score > 2 (approx. $p < 0.05$) or > 3 (approx. $p < 0.003$) is typically considered significant.
- **Direction:** Positive scores indicate increased expression in the second condition; negative scores indicate decreased expression.

```R
# Calculate p-values from S-Scores
sscores <- exprs(results)
p_values_two_sided <- 2 * (1 - pnorm(abs(sscores)))

# Identify significant genes (S-Score > 3)
significant_genes <- featureNames(results)[abs(sscores) >= 3]
```

## Key Parameters

- `celfile.path`: Directory where `.CEL` files are located (required for outlier detection).
- `SF`, `SDT`: Scale Factor and Standard Difference Threshold. It is recommended to provide these from MAS5/GCOS metrics if available to save computation time.
- `rm.extra`, `rm.outliers`, `rm.mask`: Logical flags to exclude problematic probes based on `.CEL` file metadata.
- `digits`: Number of decimal places for output (default is full precision).

## Reference documentation

- [sscore](./references/sscore.md)