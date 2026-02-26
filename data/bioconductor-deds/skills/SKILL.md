---
name: bioconductor-deds
description: This tool integrates multiple differential expression statistics into a single ranking to identify robustly differentially expressed genes in microarray data. Use when user asks to integrate multiple statistical measures, rank genes by differential expression, or perform distance synthesis for microarray analysis.
homepage: https://bioconductor.org/packages/3.6/bioc/html/DEDS.html
---


# bioconductor-deds

name: bioconductor-deds
description: Differential Expression via Distance Synthesis (DEDS) for microarray data analysis. Use this skill to integrate multiple differential expression statistics (t-statistics, fold change, SAM, etc.) into a single ranking. This approach helps identify robustly differentially expressed genes by borrowing strength across different statistical measures and avoiding the arbitrary choice of a single ranking statistic.

# bioconductor-deds

## Overview

The DEDS package implements a novel ranking scheme that assesses differential expression (DE) via distance synthesis of different related measures. Instead of relying on a single statistic (like a t-test or Fold Change), DEDS combines multiple statistics to provide a more robust ranking of genes. It supports common statistics including Fold Change (FC), t-statistics, SAM, F-statistics, B-statistics, and moderated versions from the limma framework.

## Core Workflow

The typical DEDS analysis involves preparing an expression matrix, defining class labels, running the synthesis function, and extracting the top-ranked genes.

### 1. Data Preparation
DEDS requires a matrix of expression levels (rows = genes, columns = samples) and a vector of class labels.
- **Labels**: Must be integers starting from 0 (e.g., 0 for control, 1 for treatment).

```R
library(DEDS)
# X is your expression matrix
# L is your label vector: c(0, 0, 0, 1, 1, 1)
```

### 2. Running DEDS Synthesis
Use `deds.stat.linkC` for most applications as it is implemented in C for speed.

```R
# Basic usage with default tests (t, FC, and SAM)
deds.results <- deds.stat.linkC(X, L, B=400, nsig=100)

# Customizing statistics and adjustment
# tests: "t", "f", "fc", "sam", "modt", "modF", "B"
deds.results <- deds.stat.linkC(X, L, 
                               B=500, 
                               tests=c("t", "fc", "sam", "modt"),
                               adj="fdr", 
                               nsig=200)
```

### 3. Extracting Results
Use `topgenes` to view the synthesized rankings and individual statistics.

```R
# View top 20 genes
topgenes(deds.results, number=20, genelist=gene_names_vector)
```

## Visualization

DEDS provides specialized plotting methods to visualize the relationship between different statistics and identify outliers (DE genes).

```R
# Scatter matrix of synthesized statistics
# Highlights top genes based on a threshold
pairs(deds.results, thresh=0.01, legend=FALSE)

# QQ-plots for the statistics
qqnorm(deds.results, thresh=0.01)
```

## Individual Statistics

If you need to compute individual statistics using the DEDS framework without synthesis, use `comp.stat` or specific constructor functions.

```R
# Using the wrapper
t_stats <- comp.stat(X, L, test="t")

# Using the functional approach (allows more parameter control)
t_func <- comp.t(L=L, var.equal=TRUE)
t_stats <- t_func(X)
```

## Parameters and Tips

- **B**: Number of permutations. Higher values (e.g., 400-1000) provide more precise p-values but increase computation time.
- **tail**: Specify the rejection region: `"abs"` (default), `"higher"`, or `"lower"`.
- **adj**: Type of multiple testing adjustment. Use `"fdr"` for q-values (False Discovery Rate) or `"adjp"` for adjusted p-values (Family-Wise Error Rate).
- **nsig**: When using `adj="fdr"`, set `nsig` to the number of top genes to calculate. Calculating q-values for the entire genome is computationally expensive; DEDS approximates the rest to 1.

## Reference documentation

- [DEDS](./references/DEDS.md)