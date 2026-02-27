---
name: bioconductor-pickgene
description: This package identifies differentially expressed genes in microarray data using a robust, adaptive approach that estimates variability as a function of mRNA abundance. Use when user asks to identify significant genes in microarray experiments, perform rank-based normalization, or estimate robust variance using smoothing splines.
homepage: https://bioconductor.org/packages/release/bioc/html/pickgene.html
---


# bioconductor-pickgene

## Overview

The `pickgene` package provides a robust, adaptive approach to identifying differentially expressed genes in microarray data. Unlike methods that assume constant variance across all expression levels, `pickgene` estimates variability as a function of mRNA abundance. It uses a normal-scores transformation (rank-based) to achieve normality without discarding negative values and employs smoothing splines to estimate the center and spread of gene contrasts. This makes it particularly effective for detecting significant low-abundance signals while controlling for genome-wide false positives using Bonferroni-style corrections.

## Core Workflow

### 1. Data Preparation
The input should be a data frame or matrix of microarray measurements (e.g., PM - MM values or background-adjusted intensities), where columns represent different experimental conditions or replicates.

```R
library(pickgene)

# Example: data is a matrix with genes as rows and arrays as columns
# result <- pickgene(data)
```

### 2. Picking Differentially Expressed Genes
The primary function `pickgene()` performs the normalization, calculates contrasts, estimates robust variance, and identifies significant genes.

```R
# Basic usage with default polynomial contrasts
result <- pickgene(data, geneID = rownames(data))

# Customizing the analysis:
# renorm: used to scale contrasts (e.g., sqrt(2) for log-ratio style)
# rankbased: TRUE (default) uses normal scores; FALSE uses log-transform
result <- pickgene(data, 
                   geneID = probes, 
                   renorm = sqrt(2), 
                   rankbased = TRUE)
```

### 3. Interpreting Results
The output of `pickgene()` is a list containing two main components:
- `pick`: A list (one per contrast) containing the probe names, average intensity ($a$), fold change, and Bonferroni-adjusted p-values for significant genes.
- `score`: A list containing the average intensity ($a$), standardized score ($T$), and the lower/upper Bonferroni limits.

```R
# View significant genes for the first contrast
print(result$pick[[1]])

# Access standardized scores
scores <- result$score[[1]]
```

### 4. Visualizing Distributions
The `pickedhist()` function helps visualize the mixture density of non-changing and differentially expressed genes.

```R
# p1: initial estimate of the proportion of differentially expressed genes
# bw: bandwidth for density estimation
pickedhist(result, p1 = 0.05, bw = NULL)
```

## Key Functions

- `pickgene()`: The main wrapper for the entire pipeline (normalization, robust scaling, and gene picking).
- `model.pickgene()`: Handles the generation of orthonormal contrasts between conditions.
- `robustscale()`: Slices data by average intensity and uses smoothing splines to estimate $m(a)$ (center) and $s(a)$ (spread).
- `pickedhist()`: Plots a histogram of standardized scores with an overlaid density estimate of the "changing" genes.

## Tips for Analysis

- **Contrasts**: By default, the package uses `contr.poly`. If you have specific comparisons in mind (e.g., Treatment vs. Control), ensure your data columns are ordered correctly or provide a custom contrast matrix.
- **Normalization**: The rank-based normal-scores transformation is highly robust to outliers and avoids the "log(0)" problem. Use `rankbased = TRUE` unless you have a specific reason to prefer a standard log-transform.
- **Significance Thresholds**: The package uses a conservative Zidak/Bonferroni correction. If the histogram from `pickedhist` shows a significant "bump" outside the [-3, 3] range that isn't being "picked," consider exploring genes with standardized scores $|T| > 3$ for downstream clustering.

## Reference documentation

- [Adaptive Gene Picking for Microarray Expression Data Analysis](./references/pickgene.md)