---
name: bioconductor-fabia
description: This tool extracts biclusters from high-dimensional data using sparse matrix factorization. Use when user asks to perform biclustering on microarrays, identify overlapping gene sets and sample sets, or rank biclusters by information content.
homepage: https://bioconductor.org/packages/release/bioc/html/fabia.html
---


# bioconductor-fabia

name: bioconductor-fabia
description: Factor Analysis for Bicluster Acquisition (FABIA). Use this skill to extract biclusters from high-dimensional data (like microarrays) using sparse matrix factorization. It supports various FABIA models (Laplace prior, projection-based, sparse data) and provides tools for ranking biclusters by information content and visualizing results.

# bioconductor-fabia

## Overview

The `fabia` package implements Factor Analysis for Bicluster Acquisition, a generative model for extracting biclusters from large data sets. It represents biclustering as a sparse matrix factorization problem where both the loadings (gene sets) and factors (sample sets) are sparse. This allows for overlapping biclusters and provides a ranking mechanism based on the information content each bicluster conveys about the data.

## Core Workflow

### 1. Data Preparation
Data should be centered and, if weak signals are of interest, normalized.
```R
library(fabia)
# Load your data matrix X
# Standard preprocessing is handled internally by the 'center' and 'norm' arguments
```

### 2. Running FABIA
The primary function is `fabia()`. It uses a Laplace prior to enforce sparseness.
```R
# p: number of biclusters, alpha: sparseness, cyc: iterations
res <- fabia(X, p=10, alpha=0.01, cyc=500)
```

**Alternative Models:**
- `fabias()`: Uses sparseness projection (Hoyer's method) instead of a Laplace prior.
- `spfabia()`: Optimized for very large, sparse data sets (reads from file).
- `fabiap()`: Standard FABIA followed by a post-processing projection step.

### 3. Analyzing Results
The output is a `Factorization` object.
```R
# Summary of biclusters and information content
summary(res)

# Extract hard memberships for genes and samples
# thresL: threshold for loadings, thresZ: threshold for factors
rb <- extractBic(res, thresL=0.1, thresZ=0.5)

# Access specific bicluster members
rb$bic[1,] # Members of bicluster 1
```

### 4. Visualization
```R
# Plot statistics and information content
show(res)

# Plot the reconstructed matrix vs original
extractPlot(res, ti="FABIA Result")

# Biplot of factors (e.g., bicluster 1 vs bicluster 2)
plot(res, dim=c(1,2))

# Plot a specific bicluster's heatmap
plotBicluster(rb, 1)
```

## Key Parameters

- `p`: Number of hidden factors (biclusters). It is often better to over-estimate `p` and let the model rank them.
- `alpha`: Sparseness weight for loadings. Lower values (e.g., 0.01) are more sparse for `fabia`; higher values (e.g., 0.6) for `fabias`.
- `cyc`: Number of EM iterations. 500-1000 is typical for convergence.
- `center`: 1 (mean), 2 (median), 3 (mode). Default is 2.
- `norm`: 1 (quantile normalization), 2 (variance=1). Default is 1.

## Tips for Success

- **Ranking:** Use `res@avini` to see the information content of each bicluster. Biclusters with higher values are more significant.
- **Initialization:** By default, loadings are initialized randomly. For deterministic results or better starting points, use `random=0` to initialize via SVD.
- **Memory:** For extremely large datasets, use `spfabia` which processes data in a memory-efficient sparse format.
- **Non-negativity:** If your data is strictly non-negative (e.g., counts), consider using `nmfsc` or setting `non_negative=1` in `spfabia`.

## Reference documentation

- [FABIA: Factor Analysis for Bicluster Acquisition](./references/fabia.md)