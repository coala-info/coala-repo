---
name: r-diffcorr
description: This tool analyzes and visualizes differential correlations in biological networks to identify pattern changes between two experimental conditions. Use when user asks to identify changes in correlation networks, calculate correlation matrices, perform Fisher's z-tests, or identify eigen-molecules.
homepage: https://cran.r-project.org/web/packages/diffcorr/index.html
---


# r-diffcorr

name: r-diffcorr
description: Analyze and visualize differential correlations in biological networks (transcriptomics, metabolomics) using the diffcorr R package. Use this skill to identify pattern changes in correlation networks between two experimental conditions, calculate correlation matrices, perform Fisher's z-tests, and identify eigen-molecules.

## Overview
The `diffcorr` package provides tools to identify changes in correlation relationships among molecules (genes, metabolites, etc.) between two experimental conditions. It moves beyond simple mean-level changes to explore how cellular regulatory networks reorganize. Key features include calculating correlation matrices, identifying first principal component-based "eigen-molecules," and testing differential correlation using Fisher's z-test with FDR correction.

## Installation
```R
# Install dependencies from CRAN and Bioconductor
install.packages(c("igraph", "fdrtool", "pcaMethods", "multtest"))
# Install diffcorr
install.packages("diffcorr")
```

## Main Functions and Workflow

### 1. Data Preparation
Data should typically be in a matrix or data frame format where rows are samples and columns are variables (e.g., metabolites). You need two separate datasets representing the two conditions.

### 2. Calculating Differential Correlations
The core function `comp.2.cc.fdr` compares two correlation matrices and calculates the significance of the differences.

```R
# Example workflow
library(diffcorr)

# Calculate differential correlation and FDR
# data1 and data2 are matrices for condition 1 and 2
result <- comp.2.cc.fdr(data1, data2, method = "pearson", log.p = FALSE)

# The function returns a data frame containing:
# - cor1, cor2: Correlation coefficients for each pair
# - z1, z2: Fisher z-transformed values
# - p: p-values from the comparison
# - fdr: False Discovery Rate adjusted p-values
```

### 3. Identifying Eigen-molecules
To simplify complex networks, `diffcorr` can identify "eigen-molecules" based on the first principal component of clusters.

```R
# Get eigen-molecules for a specific module/cluster
# data: your expression/metabolite matrix
# module: a vector indicating module membership
eigen_mols <- get.ave.cor(data, module)
```

### 4. Visualization
The package integrates with `igraph` for network visualization.

```R
# Generate a differential correlation network
# 'diff.cor' is the output from comp.2.cc.fdr
g <- cluster.one(diff.cor, fdr.th = 0.05)
plot(g)
```

## Tips for Analysis
- **Correlation Methods**: While Pearson is the default, consider Spearman if your data is not normally distributed.
- **FDR Thresholding**: Use a stringent FDR threshold (e.g., 0.05 or 0.01) when dealing with high-dimensional omics data to minimize false positives.
- **Scaling**: Ensure data is properly normalized and scaled before calculating correlations, as outliers can significantly skew Pearson coefficients.
- **Biological Context**: Differential correlations often highlight "rewiring" of metabolic or signaling pathways that mean-level analysis might miss.

## Reference documentation
- [README](./references/README.html.md)
- [DiffCorr Home Page](./references/home_page.md)