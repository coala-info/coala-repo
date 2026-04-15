---
name: bioconductor-yeastexpdata
description: This package provides curated yeast gene expression and protein-protein interaction datasets for graph-based analysis. Use when user asks to access yeast cell-cycle expression data, analyze protein-protein interaction networks, or test the correlation between transcriptome clusters and the interactome.
homepage: https://bioconductor.org/packages/release/data/experiment/html/yeastExpData.html
---

# bioconductor-yeastexpdata

name: bioconductor-yeastexpdata
description: Access and analyze curated yeast gene expression and protein-protein interaction (PPI) data. Use this skill to explore the relationship between transcriptome clusters and the interactome, perform graph-based analysis of yeast data, and conduct node-label permutation tests for network intersections.

## Overview

The `yeastExpData` package provides curated datasets from Ge et al. (2001), integrating yeast cell-cycle expression data (Cho et al., 1998) with literature-curated protein-protein interaction (PPI) and yeast two-hybrid data. The package is primarily used to study the correlation between gene expression clusters and physical protein interactions using graph-theoretic approaches.

## Data Objects

The package contains several key datasets:
- `ccyclered`: A data frame containing cell-cycle gene expression data for 2885 genes.
- `litG`: A `graphNEL` object representing literature-curated protein-protein interactions.
- `y2hG`: A `graphNEL` object representing yeast two-hybrid interactions.
- `nPdist`: A pre-computed null distribution for edge permutation tests.

## Typical Workflow

### 1. Loading Data and Creating Graphs
Load the package and the reduced cell-cycle data to create a cluster graph.

```r
library(yeastExpData)
library(graph)
library(RBGL)

data(ccyclered)
# Split genes by their expression cluster
clusts = split(ccyclered[["Y.name"]], ccyclered[["Cluster"]])
clusters = lapply(clusts, as.character)

# Create a clusterGraph where edges exist between genes in the same cluster
cg1 = new("clusterGraph", clusters = clusters)
```

### 2. Analyzing Interaction Networks
Load the literature-curated interaction graph and identify connected components.

```r
data(litG)
# Find connected components in the PPI graph
ccLit = connComp(litG)
cclens = sapply(ccLit, length)

# Identify large complexes (components with more than 1 protein)
ccL2 = ccLit[cclens > 1]

# Extract a subgraph for a specific component
sG1 = subGraph(ccL2[[1]], litG)
```

### 3. Testing Transcriptome-Interactome Correlation
Determine if the number of shared edges between the expression clusters (`cg1`) and the interaction network (`litG`) is statistically significant.

```r
# Find the intersection of the two graphs
commonG = intersection(litG, cg1)
num_shared_edges = numEdges(commonG)

# Compare against the pre-computed null distribution (nPdist)
data(nPdist)
plot(table(nPdist), main="Null Distribution of Shared Edges")
abline(v = num_shared_edges, col="red")
```

## Tips and Best Practices
- **Graph Dependencies**: This package relies heavily on the `graph` and `RBGL` packages for network manipulation and component analysis.
- **Node Consistency**: The datasets are pre-filtered to 2885 genes common to all experiments, ensuring that graph intersections are valid.
- **Permutation Testing**: Generating a custom null distribution using node label permutation (`sample(nodes(g))`) is computationally expensive; use the provided `data(nPdist)` for quick comparisons unless a custom background is required.
- **Visualization**: Use `Rgraphviz` (if available) or convert to `igraph` for advanced plotting of the interaction subgraphs.

## Reference documentation
- [Using graphs to relate expression data and protein-protein interaction data](./references/yeastExample.md)