---
name: r-htscluster
description: The r-htscluster package implements Poisson mixture models to cluster genes from RNA-seq count data while accounting for experimental conditions and normalization. Use when user asks to cluster high-throughput sequencing data, fit Poisson mixture models to gene expression counts, or determine the optimal number of gene clusters using slope heuristics.
homepage: https://cran.r-project.org/web/packages/htscluster/index.html
---


# r-htscluster

## Overview
The `HTSCluster` package implements a Poisson mixture model specifically designed for clustering genes from RNA-seq data. It accounts for the discrete nature of sequencing counts and provides robust parameter estimation via EM (Expectation-Maximization) or CEM (Classification EM) algorithms. It includes built-in model selection using slope heuristics to determine the optimal number of clusters.

## Installation
```R
install.packages("HTSCluster")
```

## Core Workflow

### 1. Data Preparation
The input should be a matrix or data frame of raw counts. Normalization is handled via the `norm` parameter in the main function, typically using TMM (Trimmed Mean of M-values) from the `edgeR` package.

### 2. Model Fitting and Clustering
The primary function is `PoisMixClust`, which fits the Poisson mixture model for a fixed number of clusters $g$.

```R
library(HTSCluster)

# Example: Fit a model with g = 3 clusters
# counts: matrix of raw counts
# conds: vector of experimental conditions
run <- PoisMixClust(counts, g = 3, conds = conds, norm = "TMM")

# Access results
clusters <- run$labels
log_likelihood <- run$log.like
```

### 3. Model Selection (Choosing $g$)
To determine the optimal number of clusters, use `PoisMixClustWrapper` to run the model across a range of $g$ values, followed by `PoisMixMean` and slope heuristic analysis.

```R
# Run for a range of clusters (e.g., 1 to 10)
run_range <- PoisMixClustWrapper(counts, gmin = 1, gmax = 10, conds = conds)

# Calculate mean values for the selected models
# This is required before model selection
results <- PoisMixMean(run_range)

# Model selection using slope heuristics (requires 'capushe' package)
# DDSE and DERS are common criteria
best_model <- list(results, criterion = "DDSE")
```

## Key Functions
- `PoisMixClust`: Fit a Poisson mixture model for a specific number of clusters.
- `PoisMixClustWrapper`: Wrapper to run `PoisMixClust` for a range of cluster numbers.
- `PoisMixMean`: Calculate conditional means for each cluster (essential for visualization and selection).
- `plot.PoisMixClust`: Visualize clustering results, showing the evolution of log-likelihood or cluster profiles.

## Tips
- **Normalization**: Always ensure `norm = "TMM"` (default) or provide pre-calculated normalization factors. Clustering raw counts without normalization is generally not recommended.
- **Algorithm Choice**: Use `alg.type = "EM"` for standard estimation or `"CEM"` for a faster, classification-based approach.
- **Initialization**: The algorithm can be sensitive to starting points. The package uses a Small-EM initialization strategy by default to find better local maxima.
- **Filtering**: It is highly recommended to filter out genes with very low counts (e.g., using the `HTSFilter` package) before running `HTSCluster` to improve stability and biological relevance.

## Reference documentation
- [HTSCluster Home Page](./references/home_page.md)
- [HTSCluster README](./references/README.html.md)