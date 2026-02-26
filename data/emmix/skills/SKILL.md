---
name: emmix
description: The emmix tool performs clustering of high-dimensional multivariate data using finite mixture models with component-wise factor analyzers. Use when user asks to cluster high-dimensional data, fit mixture of factor analyzers, perform robust clustering with t-distributions, or visualize data in a reduced factor space.
homepage: https://github.com/suren-rathnayake/EMMIXmfa
---


# emmix

## Overview
The `emmix` (EMMIXmfa) skill provides a specialized workflow for clustering multivariate data by adopting component-wise factor analyzers. This approach is particularly effective for high-dimensional datasets where traditional clustering methods struggle with the "curse of dimensionality." By using the Expectation-Maximization (EM) algorithm, the tool fits finite mixture models that represent the covariance structure of each component through a smaller number of latent factors.

## Installation and Setup
To use the tool within an R environment, install it directly from GitHub:

```r
library(devtools)
install_github("suren-rathnayake/EMMIXmfa")
library(EMMIXmfa)
```

## Core Clustering Functions

### Mixture of Factor Analyzers (MFA)
Use `mfa` when you want to fit a Gaussian mixture model where each component has its own factor loading matrix.

```r
# Y: data matrix, g: number of clusters, q: number of factors
mfa_fit <- mfa(Y = data_matrix, g = 3, q = 2, sigma_type = "common", D_type = "common")
```

### Mixture of Common Factor Analyzers (MCFA)
Use `mcfa` when you assume that the clusters share a common factor space, which further reduces the number of parameters.

```r
set.seed(42) # Recommended for EM initialization
mcfa_fit <- mcfa(Y = data_matrix, g = 3, q = 2)
```

### Robust Clustering (t-distributions)
For datasets with heavy tails or outliers, use the t-distribution variants to improve model robustness:
*   **MTFA**: `mtfa(Y, g, q, ...)`
*   **MCTFA**: `mctfa(Y, g, q, ...)`

## Post-Estimation Analysis

### Visualization
Visualize the groupings in the reduced q-dimensional factor space:

```r
plot_factors(mcfa_fit)
```

### Performance Metrics
If ground-truth labels are available, evaluate the clustering quality using the Adjusted Rand Index (ARI) or the number of misallocations:

```r
# Adjusted Rand Index (closer to 1 is better)
ari_score <- ari(mcfa_fit$clust, true_labels)

# Number of misallocations
error_count <- minmis(mcfa_fit$clust, true_labels)
```

### Factor Scores and Data Generation
*   **Factor Scores**: Estimate latent factor scores using `factor_scores(fit)`.
*   **Data Generation**: Generate synthetic data from a fitted model using `rmix(n, model)`.

## Expert Tips and Best Practices
*   **Initialization**: The EM algorithm is sensitive to starting values. Always use `set.seed()` before running `mcfa` or `mfa` to ensure reproducible results.
*   **Model Selection**: If the optimal number of clusters (`g`) or factors (`q`) is unknown, iterate through a range of values and compare models using information criteria (though not explicitly in the basic CLI, this is standard practice for EMMIX models).
*   **Sigma Type**: In `mfa`, adjusting `sigma_type` between "common" and "unconstrained" allows you to control whether components share the same diagonal error variance matrix.

## Reference documentation
- [EMMIXmfa Main Repository](./references/github_com_suren-rathnayake_EMMIXmfa.md)
- [R Source Structure](./references/github_com_suren-rathnayake_EMMIXmfa_tree_master_R.md)