---
name: bioconductor-lace
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/LACE.html
---

# bioconductor-lace

name: bioconductor-lace
description: Longitudinal Analysis of Cancer Evolution (LACE) for processing single-cell somatic mutation profiles. Use this skill to infer longitudinal models of cancer evolution, perform Boolean Matrix Factorization with phylogenetic constraints, and visualize clonal trees and prevalences from single-cell data collected at multiple time points.

# bioconductor-lace

## Overview
LACE is an algorithmic framework designed to reconstruct the evolutionary history of cancer using single-cell sequencing data from longitudinal experiments. It solves a Boolean Matrix Factorization problem to identify the maximum likelihood clonal tree, cell-to-clone attachments, and false positive/negative error rates. It is particularly effective for analyzing how clonal populations shift over time or in response to treatment.

## Installation
Install LACE via BiocManager:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("LACE")
```

## Core Workflow

### 1. Data Preparation
LACE requires a list of binary mutation matrices, where each element in the list represents a different time point.
```r
library(LACE)
data(longitudinal_sc_variants)
# longitudinal_sc_variants is a list of matrices (e.g., T1, T2, T3, T4)
```

### 2. Parameter Setup
Define weights for each time point (usually proportional to sample size) and error rate priors (alpha for false positives, beta for false negatives).
```r
# Example weights for 4 time points
lik_weights = c(0.23, 0.25, 0.27, 0.25)

# Define error rates (can be a list for grid search)
alpha = list(c(0.02, 0.01, 0.01, 0.01), c(0.10, 0.05, 0.05, 0.05))
beta = list(c(0.10, 0.05, 0.05, 0.05))
```

### 3. Inference
The `LACE` function performs the main MCMC-based inference.
```r
inference = LACE(D = longitudinal_sc_variants, 
                 lik_w = lik_weights, 
                 alpha = alpha, 
                 beta = beta, 
                 num_rs = 5,      # Number of restarts
                 num_iter = 100,  # Number of MCMC iterations
                 seed = 12345)
```

### 4. Interpreting Results
The output is a list containing:
- `B`: The maximum likelihood longitudinal clonal tree (adjacency matrix).
- `C`: Cell attachments to clones.
- `corrected_genotypes`: The denoised mutation matrix.
- `clones_prevalence`: Estimated prevalence of each clone across time points.
- `error_rates`: The best estimated alpha and beta values.

### 5. Visualization
Use `longitudinal.tree.plot` to generate the evolutionary model.
```r
clone_labels = c("GeneA", "GeneB", "GeneC")
longitudinal.tree = longitudinal.tree.plot(inference = inference, 
                                           labels_show = "clones", 
                                           clone_labels = clone_labels)
```

## Interactive Interface
LACE provides a Shiny-based GUI for users who prefer an interactive workflow for project management, variant filtering (using Annovar/Samtools), and result exploration.
```r
LACEview()
```

## Best Practices
- **Downscaling for Testing**: When first running the code, use low `num_rs` and `num_iter` to verify the pipeline, then increase them for final publication-quality results.
- **Error Rates**: If error rates are unknown, provide a list of possible values to `alpha` and `beta`; LACE will perform a grid search to find the most likely rates.
- **Parallelization**: For large datasets, set `num_processes` to use multiple cores during the MCMC search.

## Reference documentation
- [Introduction](./references/v1_introduction.md)
- [Running LACE](./references/v2_running_LACE.md)
- [LACE-interface](./references/v3_LACE_interface.md)