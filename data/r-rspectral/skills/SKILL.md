---
name: r-rspectral
description: The r-rspectral package implements the Spectral Modularity graph clustering method to identify community structures in networks. Use when user asks to detect communities in igraph or GraphNEL objects, perform spectral clustering on networks, or find modularity-based clusters in R.
homepage: https://cran.r-project.org/web/packages/rspectral/index.html
---

# r-rspectral

## Overview
The `rspectral` package implements the Spectral Modularity graph clustering method. It is designed to be compatible with major R graph frameworks, primarily `igraph` and `graph` (GraphNEL). The package is particularly useful for identifying community structures in networks by leveraging the eigenvalues of the modularity matrix.

## Installation
To install the stable version from CRAN:
```R
install.packages("rspectral")
```

To install the development version from GitHub:
```R
# install.packages("devtools")
devtools::install_github("cmclean5/rSpectral")
```

## Main Functions
The package provides high-level wrappers for different graph object types:

- `spectral_igraph_communities(graph, fix_neig = 0, Cn_min = 1)`: The primary function for `igraph` objects.
- `spectral_graphNEL_communities(graph, fix_neig = 0, Cn_min = 1)`: The primary function for `GraphNEL` objects.

### Parameters
- `graph`: The input graph object (igraph or GraphNEL).
- `fix_neig`: Numeric (0 or 1). If set to 1, the algorithm attempts to fix neighboring nodes found in the same community to improve stability.
- `Cn_min`: Minimum community size. The algorithm will stop splitting communities when they reach this threshold.

## Workflow Example
The following workflow demonstrates community detection using the classic Karate Club dataset:

```R
library(rspectral)
library(igraph)
data(karate, package="igraphdata")

# 1. Run spectral clustering
# Returns an igraph "communities" object
comm <- rSpectral::spectral_igraph_communities(karate, fix_neig = 1, Cn_min = 5)

# 2. Extract membership
mem <- igraph::membership(comm)

# 3. Visualize results
l <- layout_nicely(karate)
palette <- rainbow(max(as.numeric(mem)))
plot(karate, vertex.color = palette[mem], layout = l)
```

## Tips and Best Practices
- **Object Conversion**: If you have a graph format other than `igraph` or `GraphNEL`, use the `intergraph` package to convert your data into an `igraph` object before processing.
- **Large Graphs**: Spectral methods are computationally efficient, but for extremely large graphs, consider adjusting `Cn_min` to prevent over-segmentation of the network.
- **Stability**: If the community boundaries seem unstable across runs, try setting `fix_neig = 1` to encourage neighboring nodes to remain in the same cluster.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.Rmd.md](./references/README.Rmd.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [cran-comments.md](./references/cran-comments.md)
- [home_page.md](./references/home_page.md)