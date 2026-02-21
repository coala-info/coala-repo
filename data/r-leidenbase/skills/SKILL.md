---
name: r-leidenbase
description: "An R to C/C++ interface that runs the Leiden community     detection algorithm to find a basic partition (). It runs the     equivalent of the 'leidenalg' find_partition() function, which is     given in the 'leidenalg' distribution file     'leiden/src/functions.py'. This package includes the     required source code files from the official 'leidenalg'     distribution and functions from the R 'igraph'     package."
homepage: https://cloud.r-project.org/web/packages/leidenbase/index.html
---

# r-leidenbase

name: r-leidenbase
description: Expert guidance for using the 'leidenbase' R package to perform community detection using the Leiden algorithm. Use this skill when a user needs to find partitions in networks/graphs, optimize modularity or CPM, or requires a high-performance R/C++ implementation of the Leiden find_partition() function.

# r-leidenbase

## Overview
The `leidenbase` package provides R and C++ wrappers for the Leiden community detection algorithm, specifically the `find_partition()` functionality from the official `leidenalg` distribution. It is designed to find well-connected communities in graphs provided as `igraph` objects.

## Installation
```r
install.packages("leidenbase")
```

## Core Workflow

### 1. Prepare the Graph
The package requires an `igraph` object.
```r
library(leidenbase)
library(igraph)

# Example: Create a random graph or load an edgelist
g <- sample_gnm(n = 100, m = 500)
```

### 2. Run Community Detection
The primary function is `leiden_find_partition()`.

```r
res <- leiden_find_partition(
  igraph = g,
  partition_type = "CPMVertexPartition",
  resolution_parameter = 0.5,
  seed = 12345
)
```

### 3. Inspect Results
The function returns a named list containing:
- `membership`: 1-based community indices for each node.
- `quality`: The quality value of the partition.
- `modularity`: The modularity of the partition.
- `significance`: The significance value.

```r
# Get community assignment for the first 10 nodes
head(res$membership, 10)

# Find nodes in community 1
nodes_comm_1 <- which(res$membership == 1)
```

## Function Parameters

| Parameter | Description |
| :--- | :--- |
| `igraph` | An R `igraph` object. |
| `partition_type` | One of: "CPMVertexPartition" (default), "ModularityVertexPartition", "RBConfigurationVertexPartition", "RBERVertexPartition", "SignificanceVertexPartition", "SurpriseVertexPartition". |
| `initial_membership` | Optional 1-based numeric vector for starting positions. |
| `edge_weights` | Optional numeric vector of weights. |
| `node_sizes` | Optional numeric vector of node sizes (default is 1). |
| `resolution_parameter` | Numeric > 0. Ignored for Modularity, Significance, and Surprise types. |
| `num_iter` | Number of iterations (default is 2). |
| `seed` | Numeric seed (> 0) for reproducibility. |

## Tips and Best Practices
- **Resolution Parameter**: For `CPMVertexPartition`, higher values lead to more, smaller communities; lower values lead to fewer, larger communities.
- **Reproducibility**: Always set the `seed` parameter if you need consistent results across runs, as the algorithm is stochastic.
- **Performance**: `leidenbase` is often faster than other R implementations because it wraps the C++ `leidenalg` source directly without requiring a Python environment.
- **Weights**: If your graph has an `edge.attr` called "weight", you must explicitly pass it to the `edge_weights` argument; it is not automatically pulled from the `igraph` object.

## Reference documentation
- [leidenbase Vignette](./references/leidenbase.Rmd)