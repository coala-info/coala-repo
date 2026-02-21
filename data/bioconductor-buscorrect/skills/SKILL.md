---
name: bioconductor-buscorrect
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BUScorrect.html
---

# bioconductor-buscorrect

name: bioconductor-buscorrect
description: Batch effects correction with unknown subtypes using the BUScorrect R package. Use this skill to fit Bayesian hierarchical models that simultaneously correct technical artifacts (batch effects) and identify biological heterogeneity (subtypes) in high-throughput genomic data.

## Overview

The `BUScorrect` package implements the Batch-effects-correction-with-Unknown-Subtypes (BUS) model. Unlike standard correction methods that require predefined groups (e.g., "case" vs "control"), BUS is designed for discovery phases where subtype information is unknown. It performs four tasks simultaneously:
1. Corrects batch effects (location and scale).
2. Clusters samples into biological subtypes.
3. Identifies "intrinsic genes" that differentiate these subtypes.
4. Provides adjusted expression values for downstream analysis.

## Data Preparation

The package accepts two primary input formats:

### 1. R List Format
A list where each element is a matrix (genes in rows, samples in columns) representing a specific batch.
```r
# Example: 3 batches
Data <- list(batch1_matrix, batch2_matrix, batch3_matrix)
```

### 2. SummarizedExperiment Format
A single object where `assays(Data)$GE_matr` contains the expression matrix and `colData(Data)$Batch` contains the batch indicators.
```r
library(SummarizedExperiment)
# GE_matr: rows=genes, cols=samples
# Batch: vector indicating batch ID for each sample
BUSdata_SumExp <- SummarizedExperiment(assays=list(GE_matr=GE_matr), colData=DataFrame(Batch=Batch))
```

## Core Workflow

### 1. Model Fitting
Use `BUSgibbs` to run the Gibbs sampler. You must specify the number of subtypes (`n.subtypes`).
```r
library(BUScorrect)
set.seed(123) # Highly recommended for reproducibility
BUSfits <- BUSgibbs(Data = Data, 
                    n.subtypes = 3, 
                    n.iterations = 300, 
                    showIteration = FALSE)
summary(BUSfits)
```

### 2. Extracting Results
Extract estimated parameters using dedicated accessor functions:
* **Subtypes**: `Subtypes(BUSfits)` returns a list of subtype assignments per batch.
* **Batch Effects**: `location_batch_effects(BUSfits)` and `scale_batch_effects(BUSfits)`.
* **Subtype Effects**: `subtype_effects(BUSfits)` (relative to the first subtype).

### 3. Identifying Intrinsic Genes
Identify genes that drive the differences between subtypes by controlling the False Discovery Rate (FDR).
```r
# 1. Find posterior probability threshold for a specific FDR (e.g., 0.01)
thr0 <- postprob_DE_thr_fun(BUSfits, fdr_threshold = 0.01)

# 2. Estimate Intrinsic Gene (IG) indicators
est_L <- estimate_IG_indicators(BUSfits, postprob_DE_threshold = thr0)

# 3. Get indices of intrinsic genes
intrinsic_gene_indices <- IG_index(est_L)
```

### 4. Data Adjustment and Visualization
Obtain the batch-corrected matrix and visualize the results.
```r
# Get adjusted values
adjusted_data <- adjusted_values(BUSfits, Data)

# Visualize original vs adjusted (e.g., first 100 genes)
visualize_data(Data, title_name = "Original", gene_ind_set = 1:100)
visualize_data(adjusted_data, title_name = "Adjusted", gene_ind_set = 1:100)
```

## Model Selection (Determining K)

If the number of subtypes is unknown, fit the model across a range of values and select the one with the minimum Bayesian Information Criterion (BIC).

```r
BIC_values <- sapply(2:5, function(k) {
  fit <- BUSgibbs(Data = Data, n.subtypes = k, n.iterations = 300, showIteration = FALSE)
  return(BIC_BUS(fit))
})
# The optimal K is which.min(BIC_values) + 1 (if starting at 2)
```

## Tips and Best Practices
* **Reference Batch**: The first batch in your list (or the first level of your Batch factor) is treated as the reference batch (location effect = 0, scale effect = 1).
* **Reference Subtype**: The first subtype is treated as the baseline for calculating subtype effects.
* **Iterations**: For publication-quality results, increase `n.iterations` (e.g., 1000-2000). The first half is automatically discarded as burn-in.
* **Scaling**: BUScorrect handles both location (mean) and scale (variance) batch effects.

## Reference documentation
- [BUScorrect User's Guide](./references/BUScorrect_user_guide.md)