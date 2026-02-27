---
name: bioconductor-methylimp2
description: methyLImp2 is an R package designed for the imputation of missing values in DNA methylation profiles from Illumina 450k and EPIC arrays. Use when user asks to impute missing DNA methylation data, perform parallelized methylation imputation, or evaluate imputation performance using error metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/methyLImp2.html
---


# bioconductor-methylimp2

## Overview

`methyLImp2` is an R package designed for the imputation of missing values in DNA methylation profiles. It improves upon the original `methyLImp` by parallelizing computations over chromosomes and implementing a mini-batch approach for large sample sizes. It is specifically optimized for Illumina 450k and EPIC arrays.

## Core Workflow

### 1. Data Preparation
The package accepts two primary input formats:
- **Numeric Matrix**: Samples in rows, probes (CpGs) in columns ("tidy" format).
- **SummarizedExperiment**: Probes in rows, samples in columns (standard Bioconductor format).

```r
library(methyLImp2)
library(SummarizedExperiment)
library(BiocParallel)

# Load example data
data(beta, package = "methyLImp2")
# If using SummarizedExperiment, ensure probes are in rows
# beta_SE <- SummarizedExperiment(assays = SimpleList(beta = t(beta_matrix)))
```

### 2. Imputation with methyLImp2
The main function is `methyLImp2()`. While it only requires the input and the array type, several parameters allow for optimization.

```r
# Basic usage
imputed_data <- methyLImp2(input = beta_matrix, type = "EPIC")

# Advanced usage with parallelization and mini-batching
imputed_SE <- methyLImp2(
    input = beta_SE, 
    type = "EPIC",
    minibatch_frac = 0.5,              # Use 50% of samples for mini-batch
    BPPARAM = SnowParam(workers = 4, exportglobals = FALSE),
    overwrite_res = TRUE               # Overwrite the assay in SE to save memory
)
```

**Key Arguments:**
- `type`: Set to `"450k"`, `"EPIC"`, or `"user"`.
- `minibatch_frac`: Fraction of samples (0 to 1) to use for imputation. Lower values speed up processing for very large datasets.
- `group`: (Optional) A vector specifying sample groups. Imputation is performed independently per group for better accuracy.
- `annotation`: Required if `type = "user"`. A data frame with `cpg` and `chr` columns.

### 3. Performance Evaluation
If you are benchmarking or using artificial missing data, use `evaluatePerformance()` to calculate error metrics (RMSE, MAE, PCC, MAPE).

```r
# Assuming 'beta' is the ground truth and 'na_positions' are known
performance <- evaluatePerformance(
    true_data = beta, 
    imputed_data = t(assay(imputed_SE)), 
    na_pos = na_positions
)
print(performance)
```

## Tips for Large Datasets
- **Parallelization**: The package parallelizes by chromosome. Setting `workers` higher than the number of chromosomes (e.g., >24) provides no additional benefit.
- **Memory Management**: Use `overwrite_res = TRUE` when working with `SummarizedExperiment` objects to avoid duplicating large matrices in memory.
- **Mini-batching**: For datasets with hundreds of samples, a `minibatch_frac` between 0.1 and 0.5 can significantly reduce runtime with minimal impact on accuracy.

## Reference documentation
- [methyLImp2 vignette](./references/methyLImp2_vignette.md)
- [methyLImp2 vignette source](./references/methyLImp2_vignette.Rmd)