---
name: bioconductor-kboost
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/KBoost.html
---

# bioconductor-kboost

name: bioconductor-kboost
description: Infer gene regulatory networks (GRNs) from gene expression data using kernel principal components regression and boosting. Use this skill to estimate transcription factor (TF) regulation probabilities, incorporate prior biological knowledge into network inference, and analyze human-specific regulatory networks using built-in ChIP-seq priors.

## Overview

KBoost is a gene regulatory network inference algorithm that utilizes kernel principal components regression and boosting. It estimates the probability that a specific transcription factor regulates a target gene. The package is particularly effective for high-dimensional gene expression data and allows for the integration of Bayesian priors to improve inference accuracy.

## Core Workflow

### 1. Data Preparation
The input expression data `X` must be a numerical matrix where:
- **Rows** represent observations (samples, patients, or experiments).
- **Columns** represent genes.

### 2. Basic Network Inference
For general datasets without specific prior knowledge:

```r
library(KBoost)
# X is your expression matrix
grn_results <- kboost(X)
# Access the probability matrix
network_matrix <- grn_results$GRN
```

### 3. Inference with Prior Knowledge
To include known interactions, provide a `prior_weights` matrix of size G (genes) x K (transcription factors).
- Use values > 0.5 for known interactions (recommended < 1.0 to avoid numerical errors).
- Use 0.5 for unknown interactions.

```r
# Example: Setting a prior for TF in column 2 regulating gene in row 91
priors <- matrix(0.5, nrow = ncol(X), ncol = length(TFs))
priors[91, 2] <- 0.8
grn_results <- kboost(X, prior_weights = priors)
```

### 4. Human-Specific Inference
Use `KBoost_human_symbol` for human cell lines. This function automatically incorporates priors from Gerstein et al. (2012) and TF lists from Lambert et al. (2018).

```r
# gen_names should be SYMBOL nomenclature
grn_human <- KBoost_human_symbol(X, gen_names = colnames(X))
```

## Analysis and Evaluation

### Summarizing the Network
Filter the network by a probability threshold and calculate centrality measures (Indegree, Outdegree, Closeness).

```r
# thr is the posterior probability threshold (e.g., 0.1)
summary <- net_summary_bin(grn_results$GRN, thr = 0.1)
# View sorted table of interactions
head(summary$GRN_table)
```

### Calculating Distances
Calculate the shortest path distances between TFs and genes based on high-probability edges.

```r
distances <- net_dist_bin(grn_results$GRN, TFs = 1:ncol(X), thr = 0.1)
```

### Performance Metrics
If a gold standard network (`G_mat`) is available, calculate AUROC and AUPR:

```r
metrics <- AUPR_AUROC_matrix(Net = grn_results$GRN, G_mat = gold_standard_matrix)
print(metrics$AUROC)
print(metrics$AUPR)
```

## Tips for Optimization
- **Hyperparameters**: The width parameter `g` (default 40) and shrinkage `v` (default 0.1) can be tuned. Use `grid_search_kboost` to find optimal values for specific benchmark datasets.
- **Refinement**: `net_refine(Net)` can be used as a post-processing step to multiply columns by their variance, which often improves accuracy in specific benchmarks.
- **Iterations**: The default `ite = 3` is usually sufficient for most applications; increasing it significantly increases computation time.

## Reference documentation
- [KBoost](./references/KBoost.md)
- [KBoost Vignette](./references/KBoost.Rmd)