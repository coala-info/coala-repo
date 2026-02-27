---
name: bioconductor-mosbi
description: This tool implements a modular ensemble biclustering framework to integrate and stabilize results from multiple biclustering algorithms. Use when user asks to run multiple biclustering algorithms on a single dataset, compute similarity networks between biclusters, extract robust ensemble biclusters from communities, or visualize bicluster networks with metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/mosbi.html
---


# bioconductor-mosbi

name: bioconductor-mosbi
description: Modular ensemble biclustering for integrating results from multiple algorithms. Use when Claude needs to perform biclustering analysis in R, specifically for: (1) Running multiple biclustering algorithms (Fabia, ISA, Plaid, QUBIC) on a single dataset, (2) Computing similarity networks between biclusters, (3) Extracting robust ensemble biclusters from communities of similar results, or (4) Visualizing bicluster networks with sample metadata.

# bioconductor-mosbi

## Overview

The `mosbi` package implements a modular ensemble biclustering framework. It addresses the variability and instability of individual biclustering algorithms by combining results from multiple methods into a unified similarity network. By identifying communities of similar biclusters, `mosbi` extracts robust "ensemble biclusters" that are more likely to represent true biological signals.

## Core Workflow

### 1. Data Preparation
Input data must be a numeric matrix. Standard preprocessing includes log-transformation and z-scoring (usually by row/feature).

```r
# Example preprocessing
data_matrix <- log2(as.matrix(raw_data))
data_matrix <- t(apply(data_matrix, 1, function(x) (x - mean(x)) / sd(x)))
```

### 2. Running Biclustering Algorithms
`mosbi` provides wrappers for several popular algorithms. Run multiple algorithms and combine their results into a single list.

```r
library(mosbi)

# Run different algorithms
fb <- run_fabia(data_matrix)
BCisa <- run_isa(data_matrix)
BCplaid <- run_plaid(data_matrix)
BCqubic <- run_qubic(data_matrix)

# Merge results
all_bics <- c(fb, BCisa, BCplaid, BCqubic)
```

### 3. Computing the Bicluster Network
Construct a similarity network where nodes are biclusters and edges represent similarity. The function uses an error model with randomizations to estimate a significance cut-off.

```r
bic_net <- bicluster_network(
  all_bics, 
  data_matrix, 
  n_randomizations = 5, 
  metric = 4, # Fowlkes–Mallows index
  MARGIN = "both"
)
```

### 4. Extracting Communities
Identify clusters of highly similar biclusters using the Louvain algorithm.

```r
coms <- get_louvain_communities(
  bic_net, 
  min_size = 3, 
  bics = all_bics
)
```

### 5. Generating Ensemble Biclusters
Convert the identified communities into final ensemble biclusters. Use `row_threshold` and `col_threshold` to control the stringency of inclusion (e.g., a feature must appear in 10% of the community's biclusters).

```r
ensemble_bics <- ensemble_biclusters(
  coms, 
  all_bics, 
  data_matrix, 
  row_threshold = 0.1, 
  col_threshold = 0.1
)
```

## Visualization and Interpretation

*   **Network Plot**: Use `plot(bic_net)` to see the overall structure.
*   **Algorithm Distribution**: `plot_algo_network(bic_net, all_bics)` shows which algorithms contributed to which parts of the network.
*   **Metadata Integration**: Use `plot_piechart_bicluster_network` to visualize how sample groups (e.g., treatment, timepoint) are distributed within the biclusters.

```r
# Example: Color network by sample groups
plot_piechart_bicluster_network(
  bic_net, 
  all_bics, 
  groups = sample_metadata, 
  group_cols = c("red", "blue")
)
```

## Tips for Success

*   **Metric Selection**: The Fowlkes–Mallows index (metric 4) is often preferred for its balance in handling different bicluster sizes.
*   **Algorithm Diversity**: The ensemble approach is most powerful when combining algorithms with different underlying assumptions (e.g., distribution-based vs. search-based).
*   **Memory Management**: For very large datasets or many algorithms, the number of biclusters can grow quickly. Use `bicluster_histo(all_bics)` to inspect the distribution before building the network.

## Reference documentation

- [Example workflow](./references/example-workflow.md)
- [Similarity Metrics Evaluation](./references/similarity-metrics-evaluation.md)