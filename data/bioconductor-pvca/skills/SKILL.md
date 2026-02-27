---
name: bioconductor-pvca
description: This tool estimates the source and magnitude of batch effects in high-dimensional data by combining principal component analysis and variance component analysis. Use when user asks to assess data quality, partition variance into specific factors, or quantify batch effects in gene expression sets.
homepage: https://bioconductor.org/packages/release/bioc/html/pvca.html
---


# bioconductor-pvca

## Overview

The `pvca` package provides a method to estimate the source and magnitude of "batch effects" in high-dimensional data, such as microarray gene expression sets. It combines Principal Component Analysis (PCA) to reduce data dimensionality with Variance Component Analysis (VCA) using mixed linear models. This allows researchers to partition the total variance into specific factors of interest (e.g., treatment, batch, preparation date) and their interactions, helping to assess data quality before and after batch normalization.

## Core Workflow

The primary function in this package is `pvcaBatchAssess`. It typically operates on an `ExpressionSet` object.

### 1. Data Preparation
Ensure your data is in an `ExpressionSet` format and that the `pData` (phenotype data) contains the factors you wish to test for batch effects.

```r
library(pvca)
library(Biobase)

# Example using Golub_Merge from golubEsets
# data(Golub_Merge) 
```

### 2. Running PVCA
To run the assessment, you must define a threshold for the cumulative proportion of variance explained by principal components and specify the factors to analyze.

```r
# Define factors to test (must exist in pData)
batch.factors <- c("Batch", "Condition", "Source")

# Set threshold (e.g., 0.6 to include PCs explaining 60% of variance)
pct_threshold <- 0.6

# Perform assessment
pvcaObj <- pvcaBatchAssess(your_expression_set, batch.factors, pct_threshold)
```

### 3. Interpreting and Visualizing Results
The output is an object containing the weighted average proportion of variance for each effect and their interactions.

```r
# The proportions are stored in $dat
# The labels are stored in $label
print(pvcaObj$dat)

# Create a bar chart of the variance components
bp <- barplot(pvcaObj$dat, 
              xlab = "Effects", 
              ylab = "Weighted average proportion variance", 
              ylim = c(0, 1.1), 
              col = "blue", 
              las = 2,
              main = "PVCA Estimation")

# Add labels and values
axis(1, at = bp, labels = pvcaObj$label, cex.axis = 0.5, las = 2)
text(bp, pvcaObj$dat, labels = round(pvcaObj$dat, 3), pos = 3, cex = 0.8)
```

## Key Parameters

- `abatch`: An instance of `ExpressionSet` or `ExonFeatureSet`.
- `batch.factors`: A character vector of factors in the phenotype data to be included in the mixed model.
- `threshold`: The percentile value (0 to 1) of the cumulative variance explained by the eigenvalues. PCs are selected until this threshold is met.

## Usage Tips

- **Interaction Terms**: The package automatically tests for two-way interactions between the specified `batch.factors`.
- **Residuals**: A "Residual" component is always calculated, representing the variance not captured by the specified factors or the selected principal components.
- **Normalization Check**: Run PVCA before and after applying batch correction methods (like ComBat) to visualize the reduction in variance attributed to the "Batch" factor.
- **Memory/Time**: For very large datasets, the mixed model fitting (via `lme4`) can be computationally intensive.

## Reference documentation

- [Estimating batch effect in Microarray data with PVCA](./references/pvca.md)