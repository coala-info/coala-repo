---
name: bioconductor-sseq
description: This tool performs differential expression analysis for RNA-Seq data using a shrinkage-based approach to estimate dispersion. Use when user asks to perform exact tests for gene expression differences, analyze small sample sizes with shrinkage regularization, or conduct paired experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/sSeq.html
---


# bioconductor-sseq

name: bioconductor-sseq
description: Differential expression analysis for RNA-Seq data using the sSeq package. Use this skill to perform exact tests for gene expression differences between two conditions, including simple comparisons and paired experimental designs. It is particularly useful for small sample sizes as it employs a shrinkage approach to regularize dispersion estimates.

# bioconductor-sseq

## Overview
The `sSeq` package provides a robust method for discovering differentially expressed (DE) genes in RNA-Seq experiments. It uses a shrinkage-based approach to estimate per-gene dispersion parameters, regularizing them toward a common target to reduce variability and bias, especially when replicates are limited. It supports both simple two-condition comparisons and complex paired-design experiments.

## Core Workflow

### 1. Data Preparation
The input should be a matrix or data frame of raw transcript counts where rows are genes and columns are samples.

```R
library(sSeq)
# Example data
data(Hammer2months) 
# countsTable is the matrix of counts
# conds.Hammer is a vector of condition labels (e.g., c("A", "A", "B", "B"))
```

### 2. Simple Two-Condition Comparison
Use `nbTestSH` to estimate dispersion and perform exact tests.

```R
# Perform exact test
res <- nbTestSH(countsTable, conds.Hammer, "A", "B")

# res contains:
# - rawMeanA, rawMeanB: Mean counts per condition
# - rawLog2FoldChange: Log2 fold change
# - dispMM: Method of moments dispersion
# - dispSH: Shrinkage dispersion (used for the test)
# - pval: P-values for differential expression
```

### 3. Paired Experimental Design
For experiments where samples are paired (e.g., tumor vs. normal from the same patient), use the `coLevels` and `pairedDesign` arguments.

```R
# Define conditions and pairing
conds <- c("normal", "normal", "normal", "tumor", "tumor", "tumor")
coLevels <- data.frame(subjects = c(1, 2, 3, 1, 2, 3))

# Run paired test
res_paired <- nbTestSH(countsTable, conds, "normal", "tumor", 
                       coLevels = coLevels, 
                       pairedDesign = TRUE, 
                       pairedDesign.dispMethod = "pooled")
```

## Visualization and Diagnostics

### Dispersion and Variance Plots
To inspect the shrinkage effect and mean-variance relationship:

```R
# Get dispersion estimates only
disp <- nbTestSH(countsTable, conds.Hammer, "A", "B", SHonly = TRUE, plotASD = TRUE)

# Plot dispersion vs mean
plotDispersion(disp, legPos = "bottomright")

# Manual Variance Plot
mu <- rowMeans(countsTable)
SH.var <- (disp$SH * mu^2 + mu)
smoothScatter(log(rowVars(countsTable)) ~ log(mu))
points(log(SH.var) ~ log(mu), col = "black", pch = 16)
```

### Result Inspection
Generate MA plots, Volcano plots, and ECDF curves to evaluate test sensitivity and specificity.

```R
# MA and Volcano plots
drawMA_vol(countsTable, conds.Hammer, res$pval, cutoff = 0.05)

# ECDF plot for p-value distribution
# Compares p-values from between-condition vs within-condition (null)
dd <- data.frame(Between = res$pval, Within = res_null$pval)
ecdfAUC(dd, drawRef = TRUE)
```

## Advanced Configuration
- **Manual Shrinkage Target**: Use `shrinkTarget = value` to set a specific target instead of the automatically estimated one.
- **Quantile Target**: Use `shrinkQuantile = 0.975` to set the target as a specific quantile of the method of moment estimates.

## Reference documentation
- [sSeq: A Simple and Shrinkage Approach of Differential Expression Analysis for RNA-Seq experiments](./references/sSeq.md)