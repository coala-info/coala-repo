---
name: bioconductor-suprahex
description: The supraHex package implements a self-organizing map algorithm to cluster, analyze, and visualize high-dimensional omics data using a supra-hexagonal grid. Use when user asks to train a supra-hexagonal map, cluster genes or samples, visualize expression patterns across map nodes, or perform meta-clustering of high-dimensional data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/supraHex.html
---

# bioconductor-suprahex

## Overview

The `supraHex` package implements a supra-hexagonal map—a giant hexagon consisting of smaller hexagonal lattices—to train, analyze, and visualize high-dimensional omics data. It uses a self-organizing map (SOM) algorithm to map high-dimensional input (e.g., thousands of genes) onto a 2D topology-preserving grid. This allows for simultaneous gene clustering and sample representation, where geographically close nodes on the map represent similar data patterns.

## Core Workflow

### 1. Data Preparation
Input data should be a numeric matrix or data frame with genes as rows and samples as columns.

```r
library(supraHex)
# Example: 1000 genes, 6 samples
data_matrix <- matrix(rnorm(1000*6), nrow=1000, ncol=6)
colnames(data_matrix) <- c("S1","S1","S1","S2","S2","S2")
```

### 2. The sPipeline (Ab Initio Training)
The `sPipeline` function is the primary entry point. It handles topology definition, initialization, and training (rough and fine-tune stages).

```r
# Run the complete training pipeline
sMap <- sPipeline(data=data_matrix)

# Write out gene-to-hexagon assignments (clustering)
clusters <- sWriteData(sMap=sMap, data=data_matrix, filename="gene_clusters.txt")
```

### 3. Visualization of Map Properties
Use `visHexMapping` to inspect the trained map's structure.

```r
# View hexagon indexes
visHexMapping(sMap, mappingType="indexes")

# View hit distribution (how many genes map to each hexagon)
visHexMapping(sMap, mappingType="hits")

# View map distance (topology preservation)
visHexMapping(sMap, mappingType="dist")
```

### 4. Pattern Visualization
Visualize the expression patterns (codebook vectors) associated with each map node.

```r
# Line plots of patterns across samples
visHexPattern(sMap, plotType="lines")

# Bar plots of patterns
visHexPattern(sMap, plotType="bars")
```

### 5. Meta-Clustering
Partition the map into larger, continuous clusters (gene meta-clusters).

```r
# Cluster the trained map nodes
sBase <- sDmatCluster(sMap=sMap, which_neigh=1, distMeasure="median", clusterLinkage="average")

# Visualize the clusters
visDmatCluster(sMap, sBase)

# Export IDs with both hexagon index and meta-cluster ID
output <- sWriteData(sMap, data_matrix, sBase, filename="meta_clusters.txt")
```

### 6. Sample Reordering and Comparison
To visualize sample relationships, reorder the component planes.

```r
# Reorder samples based on their expression profiles on the map
sReorder <- sCompReorder(sMap=sMap)

# Visualize reordered components (sample-specific maps)
visCompReorder(sMap=sMap, sReorder=sReorder)
```

## Advanced Configuration

### Neighborhood Kernels
The choice of `neighKernel` in `sPipeline` affects the map's topology:
- `gaussian` or `gamma`: Global influence, smoother transitions.
- `ep`: Local influence, emphasizes local topological relationships.
- `bubble` or `cutgaussian`: Balanced influence.

```r
# Example using a specific kernel
sMap_ep <- sPipeline(data=data_matrix, neighKernel="ep")
```

## Tips for Interpretation
- **Proximity**: Hexagons close to each other on the map contain genes with similar expression profiles.
- **Hexagon Size**: In "hits" view, larger hexagons represent higher data density in that region of the input space.
- **Component Planes**: Each sample's "plane" shows how genes are expressed in that specific condition across the entire map topology.

## Reference documentation
- [supraHex Vignette](./references/supraHex_vignettes.md)