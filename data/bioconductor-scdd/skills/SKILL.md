---
name: bioconductor-scdd
description: This tool identifies and classifies genes with differential expression distributions across two conditions in single-cell RNA-seq data using Bayesian mixture models. Use when user asks to detect differential distribution patterns, classify genes into categories like DE or DM, simulate multimodal scRNA-seq data, or visualize expression distributions with violin plots.
homepage: https://bioconductor.org/packages/release/bioc/html/scDD.html
---

# bioconductor-scdd

name: bioconductor-scdd
description: Identifying differential distributions in single-cell RNA-seq data using scDD. Use this skill to detect and classify genes into patterns (DE, DP, DM, DB, DZ) using Dirichlet Process Mixture models, simulate scRNA-seq data with multimodal patterns, and visualize expression distributions with violin plots.

## Overview

The `scDD` package is designed to identify genes with differential distributions (DD) across two biological conditions in single-cell RNA-seq data. Unlike traditional differential expression (DE) methods that focus on mean shifts, `scDD` uses a Bayesian non-parametric mixture model to characterize complex expression patterns, such as changes in modality or the proportion of cells in specific expression states.

## Core Workflow

### 1. Data Preparation
`scDD` requires input in the `SingleCellExperiment` format. The data should be normalized counts.

```r
library(scDD)
library(SingleCellExperiment)

# Create SCE object if starting from matrices
# condition should be a vector of 1s and 2s
sce <- SingleCellExperiment(assays=list(normcounts=cbind(matrix_cond1, matrix_cond2)),
                            colData=data.frame(condition=condition_vector))
```

### 2. Preprocessing and Filtering
Filter out genes with a high proportion of zeroes and ensure normalization.

```r
# Filter genes with > 50% zeroes and apply scran normalization
sce <- preprocess(sce, zero.thresh=0.5, scran_norm=TRUE)
```

### 3. Identifying and Classifying DD Genes
The `scDD` function performs the main analysis. It defaults to a fast Kolmogorov-Smirnov (KS) test. For higher power at the cost of speed, use the permutation-based Bayes Factor test.

```r
# Set robust prior parameters
prior_param <- list(alpha=0.01, mu0=0, s0=0.01, a0=0.01, b0=0.01)

# Run analysis (Fast KS test)
sce <- scDD(sce, prior_param=prior_param, testZeroes=TRUE)

# Run analysis (Permutation test - more powerful, slower)
# sce <- scDD(sce, prior_param=prior_param, permutations=1000)
```

### 4. Interpreting Results
Extract results using the `results()` function.

```r
RES <- results(sce)
# DDcategory column contains:
# DE: Differential Expression (unimodal)
# DP: Differential Proportion (multimodal)
# DM: Differential Modality
# DB: Differential Both (modality and mean)
# DZ: Differential Zero (dropout rate)
# NC: No Call (significant but doesn't fit patterns)
# NS: Not Significant
```

## Visualization
Use `sideViolin` to visualize the distribution of specific genes across conditions.

```r
# Plot the first gene in the dataset
sideViolin(normcounts(sce)[1,], sce$condition, title.gene=rownames(sce)[1])
```

## Simulation
Generate synthetic data to benchmark methods or test hypotheses.

```r
# Simulate 5 genes of each DD/ED category
simulated_sce <- simulateSet(sce_template, numSamples=100,
                             nDE=5, nDP=5, nDM=5, nDB=5, nEE=5, nEP=5,
                             sd.range=c(2,2), modeFC=4)
```

## Tips and Best Practices
- **Parallelization**: `scDD` uses `BiocParallel`. By default, it uses `n-2` cores. You can manually specify cores using the `param` argument (e.g., `param=MulticoreParam(workers=4)`).
- **Zero Values**: If `testZeroes=TRUE`, the package performs a Chi-square test on dropout rates.
- **Categorization**: If you only need p-values and not the pattern classification (DE, DP, etc.), set `categorize=FALSE` in the `scDD` call to save time.
- **Memory**: For very large datasets, ensure you have sufficient RAM as the mixture modeling step is computationally intensive.

## Reference documentation
- [Identifying differential distributions in single-cell RNA-seq experiments with scDD](./references/scDD.md)