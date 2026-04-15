---
name: bioconductor-sdams
description: This tool performs differential abundance and expression analysis for metabolomics, proteomics, and single-cell RNA sequencing data using a two-part semi-parametric model. Use when user asks to identify differentially abundant features in data with many zeros, perform two-part semi-parametric tests, or analyze mass spectrometry and scRNA-seq datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SDAMS.html
---

# bioconductor-sdams

name: bioconductor-sdams
description: Differential abundance analysis for metabolomics and proteomics data (mass spectrometry) and differential expression analysis for single-cell RNA sequencing (scRNA-seq). Use this skill when analyzing data with a large fraction of zeros and non-normal distributions using a two-part semi-parametric model.

## Overview

SDAMS (Semi-parametric Differential Abundance analysis for Metabolomics and proteomics Systems) is designed to handle data containing many zero values and non-normally distributed non-zero values. It utilizes a two-part model:
1.  **Logistic regression** to model the probability of a value being zero (binary part).
2.  **Semi-parametric log-linear model** to model the non-zero values (continuous part).

The package is particularly effective for mass spectrometry-based proteomics/metabolomics and scRNA-seq TPM data.

## Data Preparation

SDAMS uses the `SummarizedExperiment` class. You can create these objects from CSV files or R matrices.

### From CSV Files
Requires two files: a feature matrix (features in rows, subjects in columns) and a group/phenotype file.
```r
library(SDAMS)
# path1: feature.csv, path2: group.csv
exampleSE <- createSEFromCSV(path1, path2)
```

### From Matrices
```r
# featureInfo: matrix of intensities/counts
# groupInfo: data.frame with grouping/covariate information
exampleSE <- createSEFromMatrix(feature = featureInfo, colData = groupInfo)
```

## Differential Analysis Workflow

The primary function is `SDA()`. It automatically performs the two-part semi-parametric analysis.

```r
# Perform analysis
results <- SDA(exampleSE)

# Access results
# Gamma: effects on the fraction of zero values (logistic part)
head(results$gamma)    # Point estimates
head(results$pv_gamma) # P-values
head(results$qv_gamma) # Q-values (FDR adjusted)

# Beta: effects on the non-zero abundance (log-linear part)
head(results$beta)     # Log fold change for non-zero values
head(results$pv_beta)  # P-values
head(results$qv_beta)  # Q-values

# Two-part test: overall effect (combined hypothesis)
head(results$pv_2part) # P-values for H0: gamma = 0 AND beta = 0
head(results$qv_2part) # Q-values
```

## Interpreting Hypotheses

SDAMS tests three distinct null hypotheses for each feature/gene:
1.  **H1 (Beta = 0):** Tests if the mean of the non-zero values differs between groups.
2.  **H2 (Gamma = 0):** Tests if the proportion of zeros (drop-outs) differs between groups.
3.  **H3 (Beta = 0 and Gamma = 0):** An overall test for any difference in either the zero proportion or the non-zero mean.

## Usage Tips
- **Input Values:** Data should be non-negative. For scRNA-seq, TPM (Transcripts Per Kilobase Million) values are typically used.
- **Covariates:** The first column of the `colData` (grouping information) is treated as the primary condition of interest. Additional columns can be included as covariates in the model.
- **FDR Adjustment:** The package uses the `qvalue` method to adjust for multiple comparisons across thousands of features.

## Reference documentation
- [SDAMS](./references/SDAMS.md)