---
name: bioconductor-randomwalkrestartmh
description: This package implements the Random Walk with Restart algorithm on multiplex and heterogeneous networks to rank nodes based on their proximity to seed nodes. Use when user asks to perform guilt-by-association analysis, integrate multiple biological networks, or rank genes and diseases using network-based data integration.
homepage: https://bioconductor.org/packages/3.8/bioc/html/RandomWalkRestartMH.html
---


# bioconductor-randomwalkrestartmh

## Overview

The `RandomWalkRestartMH` package implements the Random Walk with Restart (RWR) algorithm on various network architectures. It allows users to integrate multiple types of biological data (e.g., PPI, pathways, disease similarities) to rank nodes based on their proximity to a set of "seed" nodes. This is particularly useful for "guilt-by-association" approaches in bioinformatics.

## Core Workflows

### 1. Network Preparation
The package uses `igraph` objects as input. You must first wrap your networks into specialized objects.

```r
library(RandomWalkRestartMH)
library(igraph)

# For Monoplex/Multiplex:
# Pass one or more igraph objects
my_multiplex <- create.multiplex(network1, network2, Layers_Name=c("PPI", "PATH"))

# For Heterogeneous (linking two different node types):
# Requires a multiplex object, a second network, and a data frame of bipartite relations
my_het <- create.multiplexHet(my_multiplex, disease_network, bipartite_relations, c("Disease"))
```

### 2. Matrix Computation
Before running the algorithm, you must compute and normalize the transition matrices.

```r
# For Multiplex:
adj_matrix <- compute.adjacency.matrix(my_multiplex)
norm_matrix <- normalize.multiplex.adjacency(adj_matrix)

# For Heterogeneous/Multiplex-Heterogeneous:
tran_matrix <- compute.transition.matrix(my_het)
```

### 3. Running the Random Walk
Define your seeds (node names) and execute the RWR.

```r
# RWR on Multiplex
results_m <- Random.Walk.Restart.Multiplex(norm_matrix, my_multiplex, SeedGene = c("PIK3R1"))

# RWR on Multiplex-Heterogeneous
# You can provide seeds for both network types
results_mh <- Random.Walk.Restart.MultiplexHet(tran_matrix, my_het, 
                                               SeedGene = c("PIK3R1"), 
                                               SeedDisease = c("269880"))
```

### 4. Result Visualization and Extraction
The package provides utilities to extract the top-ranked nodes and create subgraphs for visualization.

```r
# Get top results
print(results_mh)

# Create an igraph of the top k results for visualization
top_net <- create.multiplexHetNetwork.topResults(results_mh, my_het, bipartite_relations, k=10)
plot(top_net)
```

## Key Parameters
- **r**: Restart probability (default is 0.7). A higher value keeps the walker closer to the seeds.
- **tau**: For multiplex networks, a vector of weights for each layer.
- **eta**: For heterogeneous networks, the probability of jumping between the two different network types.

## Tips for Success
- Ensure node names in your bipartite relations data frame match the node names in your `igraph` objects exactly.
- The package currently supports undirected and unweighted networks.
- When visualizing multiplex results, the `create.multiplexNetwork.topResults` function aggregates layers into a single view for clarity.

## Reference documentation
- [Random Walk with Restart on Multiplex and Heterogeneous Network](./references/RandomWalkRestartMH1.md)