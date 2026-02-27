---
name: bioconductor-verso
description: VERSO is an algorithmic framework that reconstructs phylogenetic models of viral evolution from variant profiles while accounting for genomic data noise. Use when user asks to produce phylogenetic trees from viral clonal variants, estimate optimal false positive and false negative error rates, or infer corrected genotypes from noisy genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/VERSO.html
---


# bioconductor-verso

## Overview

VERSO (Viral Evolution ReconStruction from Observation) is an algorithmic framework designed to process variant profiles from viral samples. It primarily performs Step 1 of the VERSO framework: producing phylogenetic models of viral evolution from clonal variants. It accounts for noise in genomic data by estimating optimal false positive (alpha) and false negative (beta) error rates through grid search and maximum likelihood inference.

## Installation

Install the package via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("VERSO")
library(VERSO)
```

## Core Workflow

### 1. Data Preparation
The input data `D` must be a matrix where rows are samples and columns are variants.
- `1`: Variant observed.
- `0`: Variant not observed.
- `NA`: Missing data (e.g., low coverage).

```r
data(variants) # Example dataset
```

### 2. Parameter Setup
Define ranges for error rates. VERSO will perform a grid search to find the best combination.

```r
alpha = c(0.01, 0.05) # False positive rates
beta = c(0.01, 0.05)  # False negative rates
```

### 3. Phylogenetic Inference
Use the `VERSO` function to perform the inference. For production runs, use higher values for `num_rs`, `num_iter`, and `n_try_bs` than shown in examples.

```r
set.seed(12345) # For reproducibility
inference = VERSO(D = variants, 
                  alpha = alpha, 
                  beta = beta, 
                  check_indistinguishable = TRUE, 
                  num_rs = 5, 
                  num_iter = 100, 
                  n_try_bs = 50, 
                  num_processes = 1, 
                  verbose = FALSE)
```

### 4. Interpreting Results
The inference object is a list containing:
- `B`: The maximum likelihood variants tree (inner nodes).
- `C`: Attachment of samples to genotypes.
- `phylogenetic_tree`: Combined tree (ape format) including variants and sample attachments.
- `corrected_genotypes`: The input matrix `D` corrected based on the inferred tree.
- `genotypes_prevalence`: Observed prevalence of each genotype.
- `log_likelihood`: Likelihood of the inferred model.
- `error_rates`: The estimated best alpha and beta values.

### 5. Visualization
The phylogenetic tree can be visualized using the `ape` package's plot function.

```r
library(ape)
plot(inference$phylogenetic_tree)
```

## Tips and Best Practices
- **Indistinguishable Variants**: Setting `check_indistinguishable = TRUE` helps collapse variants that provide redundant phylogenetic information, simplifying the model.
- **Parallelization**: For large datasets, increase `num_processes` to utilize multiple cores.
- **Convergence**: If the log-likelihood does not seem to stabilize, increase `num_iter` and `num_rs` (random starts) to better explore the tree space.

## Reference documentation

- [Introduction](./references/v1_introduction.md)
- [Running VERSO](./references/v2_running_VERSO.md)