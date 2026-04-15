---
name: bioconductor-m3c
description: Bioconductor-m3c performs Monte Carlo reference-based consensus clustering to identify the optimal number of clusters in genome-wide expression data. Use when user asks to determine the optimal number of clusters, reject the null hypothesis of a single cluster, or compare cluster stability against a random model using Monte Carlo simulations.
homepage: https://bioconductor.org/packages/release/bioc/html/M3C.html
---

# bioconductor-m3c

name: bioconductor-m3c
description: Monte Carlo Reference-based Consensus Clustering (M3C) for identifying the optimal number of clusters (K) in genome-wide expression data. Use this skill when you need to perform robust consensus clustering, reject the null hypothesis (K=1), or compare cluster stability against a random model using Monte Carlo simulations.

## Overview

M3C (Monte Carlo Reference-based Consensus Clustering) is an R package designed to address the bias in traditional consensus clustering (like the Monti algorithm). As K increases, consensus matrices naturally appear more stable by chance. M3C solves this by comparing real stability scores (PAC or Entropy) against a null distribution generated via Monte Carlo simulation. It provides p-values and the Relative Cluster Stability Index (RCSI) to objectively determine the optimal K and decide if any significant structure exists (K > 1).

## Core Workflow

### 1. Data Preparation
Input data should be a matrix or data frame of normalized continuous expression data (e.g., VST, rlog, log2(TPM)).
- **Rows**: Features (genes/proteins)
- **Columns**: Samples
- **Filtering**: Use `featurefilter` to reduce dimensionality and remove low-variance noise.

```r
library(M3C)
# Filter for the top 10% most variable features using Median Absolute Deviation (MAD)
filtered_data <- featurefilter(mydata, percentile=10, method='MAD')$filtered_data
```

### 2. Running M3C
The primary function is `M3C()`. It supports two main methods:
- **Method 1 (Monte Carlo)**: Default. Best for p-value generation and rejecting K=1.
- **Method 2 (Regularized)**: Faster; uses a penalty term (lambda) to find K without p-values.

```r
# Standard Monte Carlo run (Objective: 'entropy' is default, 'PAC' is optional)
res <- M3C(filtered_data, 
           iters = 25,        # Monte Carlo iterations (reduce to 5-15 for speed)
           repsreal = 100,    # Inner replications for consensus clustering
           des = my_metadata, # Optional annotation data frame
           removeplots = FALSE)
```

### 3. Interpreting Results
The output object contains scores, p-values, and plots.
- **RCSI (Relative Cluster Stability Index)**: Higher is better. The peak indicates the optimal K.
- **P-value**: If p < 0.05 for a specific K, you can reject the null hypothesis (K=1).
- **res$scores**: A data frame containing PAC, RCSI, and p-values for each K.

```r
# View numerical results
res$scores

# Access specific plots
res$plots[[3]] # P-value plot
res$plots[[4]] # RCSI plot
```

### 4. Extracting Cluster Assignments
Once an optimal K is chosen (e.g., K=4), extract the ordered data and cluster labels for downstream analysis or heatmaps.

```r
k_opt <- 4
clusters <- res$realdataresults[[k_opt]]$ordered_annotation
consensus_matrix <- res$realdataresults[[k_opt]]$consensus_matrix
```

## Visualization Tools

M3C includes wrappers for common visualization tasks to verify cluster structure:
- **PCA**: `pca(mydata, labels=clusters$consensuscluster)`
- **t-SNE**: `tsne(mydata, labels=clusters$consensuscluster)`
- **UMAP**: `umap(mydata, labels=clusters$consensuscluster)`

## Tips for Success
- **Sample Size**: Recommended for datasets with 60–1000 samples. Not ideal for single-cell RNA-seq (use SC3 or Spectrum instead).
- **Objective Functions**: 'entropy' is generally preferred as it doesn't require a subjective window, unlike 'PAC'.
- **Outliers**: Always run `pca()` before clustering to identify and remove extreme outliers that might drive artificial clusters.
- **Batch Effects**: Ensure data is corrected for batch effects before running M3C, as clustering will otherwise pick up technical variation.

## Reference documentation
- [M3C: Monte Carlo Reference-based Consensus Clustering](./references/M3Cvignette.md)