---
name: bioconductor-bus
description: This tool computes similarities using correlation or mutual information to identify molecular interactions or associations with external traits. Use when user asks to reconstruct gene regulatory networks, identify gene-gene interactions, or correlate molecular activity with clinical and phenotypic data.
homepage: https://bioconductor.org/packages/release/bioc/html/BUS.html
---


# bioconductor-bus

name: bioconductor-bus
description: Tools for computing similarities (correlation and mutual information) to identify interactions among molecules (unsupervised) or associations between molecules and external traits (supervised). Use this skill when analyzing gene expression data to reconstruct gene regulatory networks or to correlate molecular activity with clinical, anagraphical, or phenotypic data.

## Overview

The BUS package provides a framework for similarity analysis in high-throughput biological data. It supports two primary modes:
1.  **Unsupervised (U):** Identifies similarities among molecules (e.g., gene-gene interactions) to build adjacency matrices and predicted networks.
2.  **Supervised (S):** Identifies similarities between molecules and external traits (e.g., gene-clinical trait associations).

It utilizes either Correlation or Mutual Information (MI) as distance metrics and provides robust statistical validation through permutation-based p-value corrections.

## Core Workflow

The primary interface is the `BUS()` wrapper function, which handles similarity computation, p-value estimation, and network trimming.

### 1. Unsupervised Analysis (Gene-Gene Network)
Use this mode to identify how genes interact with each other based on expression profiles.

```r
library(BUS)
library(minet)

# Data should be an MxN matrix (M = molecules/genes, N = samples)
data(copasi)
mat <- as.matrix(copasi)[1:10, ] 

# Run Unsupervised Analysis
result <- BUS(EXP = mat, 
              measure = "MI",      # "MI" or "corr"
              nflag = 1,           # 1 = Unsupervised
              net.trim = "aracne", # "aracne", "clr", or "mrnet"
              n.replica = 400,     # Number of permutations
              thresh = 0.05)       # P-value threshold for network prediction

# Access results
# result$similarity        - Raw similarity matrix
# result$multi.perm.p.value - Corrected p-values
# result$net.pred.permut    - Predicted adjacency matrix
```

### 2. Supervised Analysis (Gene-Trait Association)
Use this mode to find associations between gene expression and external variables (e.g., miRNA levels, clinical scores).

```r
# Requires two datasets: EXP (MxN) and trait (TxN)
data(tumors.mRNA)
data(tumors.miRNA)

exp_mat <- as.matrix(tumors.mRNA)[1:5, ]
trait_mat <- as.matrix(tumors.miRNA)[1:5, ]

# Run Supervised Analysis
result_s <- BUS(EXP = exp_mat, 
                trait = trait_mat, 
                measure = "MI", 
                nflag = 2) # 2 = Supervised

# Access results
# result_s$similarity        - Gene-Trait association table
# result_s$single.perm.p.value - Individual p-values
```

## Key Parameters and Functions

### Distance Metrics (`measure`)
*   **"corr"**: Uses R's built-in correlation. P-values are calculated using exact distributions (`cor.test`).
*   **"MI"**: Uses Mutual Information. P-values are estimated via permutations. For extreme p-values (near 0), a beta distribution is fitted using the method of moments.

### Network Trimming (`net.trim`)
When using MI in unsupervised mode, the package integrates with `minet` for network inference:
*   **aracne**: Removes the least significant edge in every triplet (Data Processing Inequality).
*   **clr**: Context Likelihood of Relatedness.
*   **mrnet**: Maximum Relevance Minimum Redundancy.

### Statistical Significance
*   **single.perm.p.value**: The p-value for a single gene/trait pair.
*   **multi.perm.p.value**: Corrected p-values for multiple hypothesis testing.
*   **method.permut**: In supervised mode, controls correction:
    *   `1`: Correct for multiple traits.
    *   `2`: Correct for multiple genes (default).
    *   `3`: Correct for both.

## Interpretation Tips
*   **P-values**: Lower values (approaching 0) indicate stronger statistical evidence for an interaction or association.
*   **Similarity**: Higher values in the similarity matrix (or 1 in the predicted network matrix) indicate strong links.
*   **Missing Data**: The package automatically handles missing values using smooth bootstrapping.

## Reference documentation
- [BUS Vignette](./references/bus.md)