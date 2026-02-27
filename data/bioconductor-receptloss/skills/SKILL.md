---
name: bioconductor-receptloss
description: The receptLoss package identifies and quantifies the loss of receptor expression in biological datasets using a statistical framework to distinguish biological loss from technical noise. Use when user asks to identify receptor loss, calculate loss scores for specific markers, determine expression thresholds, or visualize receptor downregulation across samples.
homepage: https://bioconductor.org/packages/release/bioc/html/receptLoss.html
---


# bioconductor-receptloss

name: bioconductor-receptloss
description: Analysis of receptor loss in biological samples using the receptLoss R package. Use this skill when a user needs to identify, quantify, or visualize the loss of specific receptors (such as protein or gene expression markers) across different conditions, cell types, or tissue samples within the Bioconductor ecosystem.

# bioconductor-receptloss

## Overview
The `receptLoss` package is designed to identify and quantify the loss of receptor expression in biological datasets. It is particularly useful in oncology and immunology contexts where the downregulation or complete loss of specific surface markers or receptors (e.g., HER2, ER, PR in breast cancer) has clinical or functional significance. The package provides a statistical framework to distinguish true biological loss from technical noise or baseline low expression.

## Installation
To use this skill, the package must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("receptLoss")
library(receptLoss)
```

## Typical Workflow

### 1. Data Preparation
The package typically operates on expression matrices (e.g., RNA-seq counts, TPM, or proteomics intensity data). Ensure your data is normalized appropriately before analysis.

```r
# Load your expression data (rows = genes/receptors, cols = samples)
exp_data <- read.table("expression_matrix.txt")
```

### 2. Identifying Receptor Loss
The core functionality involves calculating a "loss score" or identifying samples that fall below a statistically defined threshold for a specific receptor.

```r
# Example: Calculate loss for a specific receptor across samples
# Replace 'ReceptorName' with the actual gene symbol or ID
results <- calculateLoss(exp_data, receptor = "ESR1")
```

### 3. Statistical Thresholding
`receptLoss` uses distribution-based methods to determine the cutoff for what constitutes "loss."

- **Automatic Thresholding**: The package can estimate the background noise level to set a cutoff.
- **Manual Thresholding**: Users can provide known clinical cutoffs if available.

### 4. Visualization
Visualize the distribution of receptor expression and the identified "loss" group.

```r
# Plot the expression distribution with the loss threshold indicated
plotReceptorDistribution(results)

# Heatmap of multiple receptors showing loss patterns
plotLossHeatmap(exp_data, receptors = c("ESR1", "PGR", "ERBB2"))
```

## Main Functions
- `calculateLoss()`: The primary function to determine loss status for a given receptor.
- `getLossThreshold()`: Retrieves or calculates the expression value used as the boundary for loss.
- `summarizeLoss()`: Provides a summary table of the percentage of samples exhibiting loss across different groups.

## Tips for Success
- **Normalization**: Always perform log-transformation or VST (Variance Stabilizing Transformation) if working with raw sequencing counts, as the package assumes a continuous distribution.
- **Batch Effects**: Correct for batch effects before running `receptLoss` to avoid false positives in loss detection.
- **Control Samples**: Including known "positive" (high expression) and "negative" (known loss) samples helps validate the calculated thresholds.

## Reference documentation
- [receptLoss Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/receptLoss.html)