---
name: bioconductor-suitor
description: SUITOR selects the optimal number of mutational signatures and extracts their profiles and activities using unsupervised cross-validation. Use when user asks to estimate the correct number of mutational signatures, perform cross-validation for signature rank selection, or extract signature profiles and activities from cancer genomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/SUITOR.html
---


# bioconductor-suitor

name: bioconductor-suitor
description: Selecting the optimal number of mutational signatures and extracting signature profiles/activities using unsupervised cross-validation. Use when analyzing cancer genomics data to determine the correct rank for de novo mutational signature analysis and to perform non-negative matrix factorization (NMF) with the ECM algorithm.

# bioconductor-suitor

## Overview

SUITOR (Selecting the number of mUTational signatures via cross-validatOR) is a Bioconductor package designed to solve the critical problem of estimating the correct number of mutational signatures in cancer genomics. It uses an unsupervised cross-validation approach and the Expectation Conditional Maximization (ECM) algorithm to provide a robust, data-driven selection of signature ranks.

## Installation and Loading

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("SUITOR")

library(SUITOR)
```

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or data frame where:
- **Columns**: Individual tumors or samples.
- **Rows**: Mutation types (typically 96 trinucleotide categories).
- **Values**: Non-negative mutation counts.

### 2. Selecting the Number of Signatures
Use the `suitor()` function to perform cross-validation across a range of ranks.

```r
# Define options for the search
# n.starts should be higher (e.g., 30) for final analysis
OP <- list(min.rank = 1, max.rank = 10, k.fold = 10, n.starts = 10)

# Run cross-validation
results <- suitor(data = my_mutational_catalog, op = OP)

# Identify the optimal rank
optimal_rank <- results$rank
print(optimal_rank)

# View summary of errors
print(results$summary)
```

### 3. Extracting Profiles and Activities
Once the optimal rank is determined, extract the signature profiles ($W$) and activities ($H$).

```r
# Extract signatures based on the optimal rank
extraction <- suitorExtractWH(data = my_mutational_catalog, rank = optimal_rank)

# Signature profiles (96 types x rank)
W_matrix <- extraction$W

# Signature activities (rank x samples)
H_matrix <- extraction$H
```

## Key Parameters (Options List)

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `min.rank` | Minimum number of signatures to test | 1 |
| `max.rank` | Maximum number of signatures to test | 10 |
| `k.fold` | Number of folds for cross-validation | 10 |
| `n.starts` | Number of random initializations to avoid local optima | 30 |
| `em.eps` | Convergence tolerance for the ECM algorithm | 1e-5 |
| `max.iter` | Maximum iterations for the ECM algorithm | 2000 |

## Downstream Analysis Tips

- **Two-Stage Approach**: Run `suitor()` with default settings first to find a plausible range, then narrow the `min.rank` and `max.rank` while increasing `n.starts` and `max.iter` for a more precise estimate.
- **Visualization**: By default, `suitor()` produces a cross-validation error plot. Look for the rank that minimizes the prediction error.
- **MutationalPatterns Integration**: Use the `MutationalPatterns` package to visualize the extracted $W$ matrix using `plot_96_profile(extraction$W)` or compare against COSMIC signatures using `cos_sim_matrix()`.

## Reference documentation

- [SUITOR: selecting the number of mutational signatures](./references/vignette.md)
- [SUITOR: selecting the number of mutational signatures (Rmd source)](./references/vignette.Rmd)