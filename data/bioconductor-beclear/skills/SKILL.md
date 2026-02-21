---
name: bioconductor-beclear
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BEclear.html
---

# bioconductor-beclear

name: bioconductor-beclear
description: Detect and correct batch effects in DNA methylation data or other numeric matrices using Latent Factor Models. Use when an AI agent needs to identify batch-specific gene expression/methylation differences, calculate batch severity scores, or impute values to remove batch effects while preserving biological signal.

## Overview
BEclear is an R package designed to detect and correct batch effects in DNA methylation data (beta values), though it is applicable to any matrix of real numbers. It uses a non-parametric Kolmogorov-Smirnov test and median differences for detection, and a stochastic gradient descent-based Latent Factor Model for imputation of batch-affected values.

## Installation
Install the package via BiocManager:
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("BEclear")
library(BEclear)
```

## Data Preparation
The package requires two main inputs:
1. **Data Matrix**: A matrix or data.frame with features (e.g., genes/probes) as row names and samples as column names.
2. **Sample Metadata**: A data.frame where the first column is `sample_id` and the second column is `batch_id`.

```r
# Load example data
data("BEclearData")
# ex.data: matrix of beta values
# ex.samples: data.frame with sample_id and batch_id
```

## Detection Workflow
Identify which genes in which batches are significantly affected.

1. **Calculate Batch Effects**:
   Use `calcBatchEffects` to compute median differences and p-values (KS-test).
   ```r
   batchEffect <- calcBatchEffects(data = ex.data, samples = ex.samples, adjusted = TRUE, method = "fdr")
   mdifs <- batchEffect$med
   pvals <- batchEffect$pval
   ```

2. **Summarize Results**:
   Identify affected gene-batch combinations (default threshold: p <= 0.01 and median difference >= 0.05).
   ```r
   summary <- calcSummary(medians = mdifs, pvalues = pvals)
   ```

3. **Score Batches**:
   Quantify the severity of batch effects per batch.
   ```r
   score <- calcScore(ex.data, ex.samples, summary)
   ```

## Correction and Imputation Workflow
Correct batch effects by treating affected values as missing data and imputing them.

1. **Clear Affected Values**:
   Set batch-affected entries to `NA`.
   ```r
   cleared.data <- clearBEgenes(data = ex.data, samples = ex.samples, summary = summary)
   ```

2. **Impute Missing Data**:
   Use the Latent Factor Model to predict missing values. For large matrices, use block-based processing (e.g., 60x60).
   ```r
   corrected.data <- imputeMissingData(data = cleared.data, rowBlockSize = 60, colBlockSize = 60, epochs = 50)
   ```

3. **Post-processing**:
   For methylation data, ensure values remain within the [0, 1] boundary.
   ```r
   corrected.data.valid <- replaceOutsideValues(data = corrected.data)
   ```

## Simplified Workflow
Perform all detection and correction steps in a single call:
```r
result <- correctBatchEffect(data = ex.data, samples = ex.samples)
# result is a list containing medians, p-values, summary, score, and corrected data
```

## Visualization
Compare distributions before and after correction using boxplots.
```r
# Before correction
makeBoxplot(ex.data, ex.samples, score, bySamples = TRUE, main = "Original Data")

# After correction
makeBoxplot(corrected.data, ex.samples, score, bySamples = TRUE, main = "Corrected Data")
```

## Parallelization
Functions `calcBatchEffects`, `imputeMissingData`, and `correctBatchEffect` support parallel execution via the `BPPARAM` argument.
```r
library(BiocParallel)
result <- correctBatchEffect(data = ex.data, samples = ex.samples, BPPARAM = MulticoreParam(workers = 4))
```

## Reference documentation
- [Detecting and correcting batch effects with BEclear](./references/BEclear.md)
- [BEclear Tutorial (Rmd)](./references/BEclear.Rmd)