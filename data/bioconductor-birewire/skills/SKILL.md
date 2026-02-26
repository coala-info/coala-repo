---
name: bioconductor-birewire
description: BiRewire randomizes bipartite, undirected, or directed signed networks while preserving the degree distribution of nodes using an efficient switching algorithm. Use when user asks to randomize biological networks, create null models from binary event matrices, estimate the number of steps for network randomization, or calculate similarity between original and rewired graphs.
homepage: https://bioconductor.org/packages/release/bioc/html/BiRewire.html
---


# bioconductor-birewire

## Overview

BiRewire is a specialized R package for the randomization of networks (bipartite, undirected, or directed signed) while strictly preserving the degree distribution of the nodes. It implements an efficient version of the Switching Algorithm (SA) in C-code. This is particularly useful in bioinformatics for creating null models from Binary Event Matrices (BEMs)—such as sample-gene mutation matrices—to test the statistical significance of patterns like mutual exclusivity or co-occurrence.

## Core Workflows

### 1. Bipartite Network Rewiring
Bipartite graphs are often represented as incidence matrices (e.g., rows = samples, columns = genes).

```r
library(BiRewire)

# Load data (incidence matrix)
data(BRCA_binary_matrix)

# 1. Analysis: Estimate the number of steps (N) to reach maximum randomness
# Returns a list: $N (analytical bound), $data (similarity scores)
analysis <- birewire.analysis.bipartite(BRCA_binary_matrix, step=5000, n.networks=5)
n_steps <- analysis$N

# 2. Rewire: Generate a randomized version of the matrix
rewired_matrix <- birewire.rewire.bipartite(BRCA_binary_matrix, verbose=FALSE)

# 3. Similarity: Check Jaccard Index between original and rewired
similarity <- birewire.similarity(BRCA_binary_matrix, rewired_matrix)
```

### 2. Directed Signed Graphs (DSG)
DSGs encode interactions with signs (positive/negative). BiRewire treats these as two independent bipartite networks.

```r
# Load a SIF (Simple Interaction File) formatted DSG
# Format: Source, Sign (+ or -), Target
data(test_dsg)

# Convert SIF to bipartite list (B+ and B-)
dsg_list <- birewire.induced.bipartite(test_dsg, delimitators=list(negative='-', positive='+'))

# Rewire the DSG
rewired_dsg_list <- birewire.rewire.dsg(dsg=dsg_list)

# Rebuild SIF format
new_sif <- birewire.build.dsg(rewired_dsg_list, delimitators=list(negative='-', positive='+'))
```

### 3. Generating Null Model Samplers
To generate a large collection (K) of randomized networks for statistical testing:

```r
# Generates K networks and saves them to a directory
birewire.sampler.bipartite(BRCA_binary_matrix, K=100, path='null_models_folder')
```

## Key Functions

- `birewire.analysis.bipartite` / `birewire.analysis.undirected`: Calculates the analytical bound $N$ for the number of switching steps required to reach the maximum level of randomness.
- `birewire.rewire.bipartite` / `birewire.rewire.undirected`: Performs the actual rewiring. Accepts either an incidence/adjacency matrix or an `igraph` object.
- `birewire.visual.monitoring.bipartite`: Uses t-SNE to visualize the Markov Chain trajectory of the switching algorithm, helping to verify if the chain has reached a plateau.
- `birewire.similarity`: Computes the Jaccard Index between two networks.

## Tips for Usage

- **Analytical Bound**: Always use the analytical bound $N$ provided by the analysis functions. This is more efficient than empirical rules of thumb.
- **Matrix vs. Igraph**: Functions are optimized for matrices. If you have an `igraph` object, you can pass it directly, but for very large datasets, working with sparse matrices (via the `Matrix` package) is recommended.
- **NAs in Matrices**: Since version 3.6.0, the Switching Algorithm can handle matrices with `NA` values; the positions of `NA`s will be preserved during the rewiring process.
- **Exact Flag**: Use `exact=TRUE` in rewiring functions to ensure exactly $N$ successful switching steps are performed.

## Reference documentation
- [BiRewire](./references/BiRewire.md)