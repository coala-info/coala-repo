---
name: bioconductor-mfa
description: This tool performs Bayesian inference of bifurcating gene expression trajectories in single-cell data using Markov Chain Monte Carlo. Use when user asks to model branched biological processes, estimate pseudotime, assign cells to branches, or identify branch-specific differential expression.
homepage: https://bioconductor.org/packages/release/bioc/html/mfa.html
---

# bioconductor-mfa

name: bioconductor-mfa
description: Bayesian inference of bifurcating gene expression trajectories using Markov Chain Monte Carlo (MCMC). Use this skill when analyzing single-cell RNA-seq data to model branched biological processes, estimate pseudotime, and identify branch-specific differential expression.

# bioconductor-mfa

## Overview
The `mfa` package implements a Bayesian hierarchical model to estimate bifurcating trajectories in single-cell data. Unlike linear pseudotime methods, `mfa` explicitly models a decision point where cells transition from a common lineage into one of two distinct fates. It uses MCMC for parameter estimation, providing probabilistic assignments of cells to branches and uncertainty estimates for pseudotime.

## Installation
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mfa")
library(mfa)
```

## Core Workflow

### 1. Data Preparation
The input should be a gene-by-cell matrix of expression values (typically log-transformed and normalized). It is recommended to perform feature selection (e.g., using highly variable genes) before running MFA to reduce computational load.

```r
# x: matrix where rows are cells and columns are genes/features
# Example: 100 cells and 50 genes
m <- mfa(x, iter = 2000, thin = 1)
```

### 2. Model Parameters
- `iter`: Number of MCMC iterations.
- `thin`: Thinning interval.
- `pc_prior`: Prior probability of a cell belonging to the "common" trunk vs. a branch.
- `b`: Initial branch assignments (optional).

### 3. Extracting Results
After running the model, extract the MAP (Maximum A Posteriori) estimates for pseudotime and branch assignments.

```r
# Extract pseudotime
ps_time <- pseudotime(m)

# Extract branch assignments (1 = common, 2 = branch A, 3 = branch B)
branches <- assignments(m)

# Get uncertainty (posterior standard deviation of pseudotime)
ps_sd <- posterior_std(m)
```

### 4. Visualization
`mfa` provides built-in plotting functions to visualize the trajectory and branch uncertainty.

```r
# Plot the bifurcating trajectory
plot_mfa(m)

# Plot posterior branch probabilities
plot_mfa_autocor(m) # Check MCMC convergence
```

## Identifying Differential Expression
To find genes that drive the bifurcation, you can regress the expression of genes against the interaction of pseudotime and branch assignment.

```r
# Simple heuristic: compare gene expression across branches 2 and 3
# using the MAP assignments
```

## Tips for Success
- **Dimensionality Reduction**: While `mfa` can run on gene expression, it is often faster and more robust to run it on the first few Principal Components (PCs) of the data.
- **Convergence**: Always check MCMC convergence. If the trace plots look poor, increase `iter` or adjust the scaling of the input data.
- **Branch Labeling**: The branch labels (2 vs 3) are stochastic; inspect the expression of known marker genes to assign biological identities to the inferred branches.

## Reference documentation
- [mfa Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/mfa.html)