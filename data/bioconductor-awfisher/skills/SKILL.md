---
name: bioconductor-awfisher
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/AWFisher.html
---

# bioconductor-awfisher

name: bioconductor-awfisher
description: Perform adaptively weighted Fisher's meta-analysis on p-values from multiple independent studies. Use this skill to combine summary statistics from genomic or clinical studies, identify biomarkers differentially expressed in one or more studies, and characterize study-specific contributions via optimal weights.

## Overview

AWFisher implements the Adaptively Weighted (AW) Fisher's method for meta-analysis. Unlike the standard Fisher's method which treats all studies equally, AWFisher assigns binary weights (0 or 1) to each study for every biomarker. This approach increases statistical power and provides biological interpretability by identifying which specific studies contribute to a meta-analysis result.

## Core Workflow

### 1. Input Preparation
The primary input is a $p$-value matrix where rows represent biomarkers (e.g., genes) and columns represent independent studies.

```r
library(AWFisher)

# Example: pmatrix is a matrix of p-values from K studies
# Rows = Genes, Columns = Studies
res <- AWFisher_pvalue(pmatrix)
```

### 2. Interpreting Results
The `AWFisher_pvalue` function returns a list containing:
- `pvalue`: The meta-analysis p-values for each biomarker.
- `weights`: A binary matrix of the same dimension as the input, indicating if a study contributed (1) or not (0) to the optimal AW-Fisher statistic.

```r
# Adjust for multiple testing
qvalue <- p.adjust(res$pvalue, "BH")

# Identify significant genes (FDR < 0.05)
significant_genes <- which(qvalue < 0.05)

# Check study contributions for the first few genes
head(res$weights)
```

### 3. Meta-Pattern Detection
To categorize biomarkers based on their expression patterns across studies, use the `biomarkerCategorization` function. This requires a list of study data and a function to perform differential expression (DE) analysis.

```r
# 'studies' is a list where each element is a list(data=matrix, label=vector)
# 'function_limma' is a wrapper for DE analysis (e.g., using limma)
result <- biomarkerCategorization(studies, function_limma, B=100)

# result$dissimilarity: A dissimilarity matrix for clustering
# result$varibility: Variability index for each biomarker
```

### 4. Clustering and Visualization
Use the dissimilarity matrix with clustering algorithms (like `tightClust`) to find modules of genes with similar meta-patterns.

```r
library(tightClust)
tightClustResult <- tight.clust(result$dissimilarity, target=4, k.min=15)

# Visualize a specific cluster across studies using heatmaps
# Filter data for genes in cluster 1 and plot
```

## Tips for Success
- **Independence**: Ensure that the input studies are independent.
- **P-value Distribution**: Input p-values should be well-calibrated (uniformly distributed under the null).
- **Permutations**: When using `biomarkerCategorization`, set the number of permutations `B` to at least 1,000 for publication-quality results.
- **Standardization**: When visualizing meta-patterns via heatmaps, standardize the expression data (mean=0, sd=1) for each gene within each study to ensure comparability.

## Reference documentation

- [AW Fisher tutorial](./references/AWFisher.md)
- [AWFisher R Markdown Source](./references/AWFisher.Rmd)