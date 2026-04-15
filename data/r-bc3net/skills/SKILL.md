---
name: r-bc3net
description: This tool infers gene regulatory networks from large-scale gene expression data using the BC3NET algorithm. Use when user asks to infer gene-gene interactions, perform bagging-based network inference, or generate a consensus gene regulatory network from expression datasets.
homepage: https://cran.r-project.org/web/packages/bc3net/index.html
---

# r-bc3net

name: r-bc3net
description: Gene Regulatory Network (GRN) inference using the BC3NET algorithm. Use this skill to infer high-confidence gene-gene interactions from large-scale gene expression data using bagging (bootstrap aggregating) and the C3NET algorithm.

## Overview

bc3net implements the Bagging C3NET algorithm for gene regulatory network inference. It enhances the C3NET (Conditional 3-node Network) method by applying bootstrap aggregating to improve the statistical robustness and consistency of the inferred network. The algorithm is designed to handle large-scale gene expression datasets and outputs a consensus network where edges are statistically significant across bootstrap replicates.

## Installation

To install the package from CRAN:

```R
install.packages("bc3net")
```

## Core Functions

- `bc3net(dataset, boot=100, ...)`: The main function to perform network inference. It handles bootstrapping, C3NET inference for each replicate, and aggregation.
- `c3net(dataset, ...)`: Performs a single C3NET inference (the base learner).
- `mim(dataset, estimator, disc)`: Computes the Mutual Information Matrix (MIM) for the input dataset.
- `get_ensemble_network(net_list, ...)`: Aggregates a list of networks into a consensus ensemble network.

## Workflow: Inferring a Network

The standard workflow involves preparing a gene expression matrix and running the ensemble inference.

### 1. Data Preparation
Input data should be a matrix or data frame where rows represent genes and columns represent samples/experiments.

```R
library(bc3net)

# Example: Random expression data (100 genes, 50 samples)
data_matrix <- matrix(rnorm(5000), nrow=100, ncol=50)
rownames(data_matrix) <- paste0("Gene", 1:100)
```

### 2. Network Inference
Run the `bc3net` function. The `boot` parameter controls the number of bootstrap replicates (default is 100).

```R
# Infer the network
# estimator: "spearman" (default), "pearson", "kendall", or "infotheo"
# alpha: significance level for edge testing
bc3_net <- bc3net(data_matrix, boot=100, estimator="spearman", alpha1=0.05)
```

### 3. Analysis and Visualization
The output is an `igraph` object, which can be analyzed using standard network metrics or visualized.

```R
library(igraph)

# Get number of edges
ecount(bc3_net)

# Plot the network
plot(bc3_net, vertex.size=5, vertex.label=NA)

# Export as adjacency matrix
adj_matrix <- as_adjacency_matrix(bc3_net)
```

## Tips and Best Practices

- **Bootstraps**: While the default is 100, increasing the number of bootstrap replicates (e.g., 500 or 1000) can improve the stability of the inferred edges at the cost of computation time.
- **Mutual Information**: The choice of `estimator` in `mim()` is crucial. For continuous data, "spearman" is often a robust choice. If using "infotheo", ensure the data is properly discretized using the `disc` parameter.
- **Parallelization**: BC3NET can be computationally intensive. Consider running it on a high-performance cluster if the number of genes is very large (>5000).
- **Significance**: The `alpha1` and `alpha2` parameters control the stringency of the edge selection during the C3NET step and the ensemble aggregation step, respectively.

## Reference documentation

- [bc3net: Gene Regulatory Network Inference with Bc3net](./references/home_page.md)