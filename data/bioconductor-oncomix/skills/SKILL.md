---
name: bioconductor-oncomix
description: This tool identifies potential oncogenes by modeling mRNA expression distributions as two-component Gaussian mixtures to find genes overexpressed in tumor subgroups. Use when user asks to identify oncogene candidates from RNA-seq data, analyze mRNA expression in large cohorts, or calculate the Selectivity Index and Oncomix Score for genes.
homepage: https://bioconductor.org/packages/release/bioc/html/oncomix.html
---


# bioconductor-oncomix

name: bioconductor-oncomix
description: Identify oncogene candidates from RNA-seq data using 2-component Gaussian mixture models. Use this skill when analyzing mRNA expression data from large cohorts (e.g., TCGA) to find genes overexpressed in a subset of tumors compared to normal tissue.

# bioconductor-oncomix

## Overview

The `oncomix` package identifies potential oncogenes by modeling mRNA expression distributions as 2-component Gaussian mixtures. Unlike traditional differential expression (DE) methods that look for shifts in the mean expression across all samples, `oncomix` specifically searches for "oncogenic" patterns: genes that are lowly expressed in normal tissue but highly expressed in a specific subgroup of tumor samples. It calculates a Selectivity Index (SI) and an Oncomix Score to rank candidates that best fit this biological profile.

## Core Workflow

### 1. Data Preparation
The package requires two dataframes (or matrices) where rows are genes/isoforms and columns are samples.
- `exprTumIsof`: Tumor sample expression data.
- `exprNmlIsof`: Adjacent normal sample expression data.

```r
library(oncomix)
data(exprNmlIsof, exprTumIsof, package="oncomix")
```

### 2. Parameter Estimation
Use `mixModelParams` to fit the mixture models and calculate scores. This is the primary computational step.

```r
# This returns a dataframe sorted by 'score'
mmParams <- mixModelParams(exprNmlIsof, exprTumIsof)
head(mmParams)
```

### 3. Filtering Candidates
You can identify top candidates by taking the top N rows or by applying specific thresholds using `topGeneQuants`.

```r
# Filter by specific thresholds
# deltMu2Thr: threshold for difference in high-expression means
# siThr: threshold for Selectivity Index (0 to 1)
topGenes <- topGeneQuants(mmParams, deltMu2Thr=99, deltMu1Thr=10, siThr=.99)

# Or simply take the top 10 by score
top10 <- mmParams[1:10, ]
```

## Visualization

### Histogram of Expression
Visualize the mixture model fit for a specific gene to see the tumor subgroups (teal) vs normal tissue (red).

```r
isof <- "uc002jxc.2"
plotGeneHist(mmParams, exprNmlIsof, exprTumIsof, isof)
```

### Scatter Plots
The `scatterMixPlot` helps visualize the relationship between `deltaMu1` and `deltaMu2`. Ideal oncogenes typically appear in the upper right quadrant.

```r
# Basic scatter plot
scatterMixPlot(mmParams)

# Highlight genes with high Selectivity Index
scatterMixPlot(mmParams, selIndThresh=.99)

# Label specific genes of interest
scatterMixPlot(mmParams, geneLabels=c("uc002jxc.2", "uc004cmb.2"))
```

## Key Metrics
- **SI (Selectivity Index)**: Proportion of normal samples with expression below the threshold defined by the tumor mixture components. Values closer to 1 indicate better selectivity.
- **deltaMu2**: The difference between the "high expression" tumor component mean and the "high expression" normal component mean.
- **score**: A composite metric used to rank genes, incorporating SI, the differences in means (deltaMu), and variances.

## Reference documentation
- [Oncomix Vignette](./references/oncomix.md)