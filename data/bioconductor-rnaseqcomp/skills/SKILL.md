---
name: bioconductor-rnaseqcomp
description: The rnaseqcomp package provides a framework for comparing and evaluating the performance of multiple RNA-seq quantification pipelines through data calibration and statistical benchmarking. Use when user asks to compare RNA-seq quantification pipelines, calibrate expression signals across different units, evaluate replicate consistency, or assess differential expression sensitivity.
homepage: https://bioconductor.org/packages/release/bioc/html/rnaseqcomp.html
---


# bioconductor-rnaseqcomp

## Overview

The `rnaseqcomp` package provides a framework for comparing multiple RNA-seq quantification pipelines. It evaluates performance through two main steps: data calibration (to handle different units like TPM, FPKM, or RPKM) and statistical evaluation of benchmarks including replicate consistency, non-expression specificity, and differential expression sensitivity.

## Core Workflow

### 1. Data Preparation
Input data must be a list of $m \times n$ matrices (features by samples), where each list element represents a different pipeline.

```r
library(rnaseqcomp)
data(simdata)

# Define metadata
condInfo <- factor(simdata$samp$condition)
repInfo <- factor(simdata$samp$replicate)
evaluationFeature <- rep(TRUE, nrow(simdata$meta))
calibrationFeature <- simdata$meta$house & simdata$meta$chr == 'chr1'

# Calibrate signals
dat <- signalCalibrate(
    simdata$quant, 
    condInfo, 
    repInfo, 
    evaluationFeature,
    calibrationFeature, 
    unitReference = 1
)
```

### 2. Evaluating Specificity
Specificity is measured by consistency between technical replicates and the handling of non-expressed features.

*   **Replicate Variation**: Use `plotSD(dat)` to visualize standard deviations stratified by expression levels. Lower curves indicate higher specificity.
*   **Non-expression**: Use `plotNE(dat)` to analyze the proportion of features expressed in one replicate but not the other.
*   **Transcript Ratios**: For genes with exactly two transcripts, use `plot2TX(dat, genes = gene_vector)` to evaluate the stability of isoform proportions.

### 3. Evaluating Sensitivity
Sensitivity focuses on the ability of a pipeline to correctly identify differential expression.

*   **ROC Curves**: Use `plotROC(dat, positive, fcsign)` to calculate partial Area Under the Curve (pAUC) based on known true differentials.
*   **Fold Change Distribution**: Use `plotFC(dat, positive, fcsign)` to visualize the distribution of estimated fold changes against true signals.

## Key Functions

*   `signalCalibrate`: The entry point that creates an `rnaseqcomp` S4 object. It performs filtering and maps all pipeline signals to a reference unit.
*   `plotSD`: Plots standard deviation of replicates vs. average expression.
*   `plotNE`: Plots "Negative-Express" (NE) vs "Negative-Negative" (NN) proportions.
*   `plotROC`: Generates Receiver Operating Characteristic curves for differential expression.
*   `plotFC`: Summarizes estimated fold changes for truly differentially expressed features.

## Tips for Success

*   **Unit Reference**: Set `unitReference` to the index of the pipeline that uses your preferred units (e.g., TPM). All other pipelines will be detrended to match this scale.
*   **Calibration Features**: Use stable features like house-keeping genes for the `calibrationFeature` argument to ensure robust cross-pipeline comparison.
*   **On/Off Patterns**: When using `plotFC`, consider setting the true fold change sign to `NA` for transcripts that transition from zero to a signal ("off-on"), as infinite fold changes can skew the distribution visualization.

## Reference documentation

- [The rnaseqcomp user's guide](./references/rnaseqcomp.Rmd)
- [The rnaseqcomp user's guide](./references/rnaseqcomp.md)