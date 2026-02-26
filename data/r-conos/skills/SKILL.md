---
name: r-conos
description: r-conos integrates large collections of single-cell RNA-seq datasets by constructing a joint graph to identify homologous cell types across heterogeneous samples. Use when user asks to integrate multiple single-cell datasets, build a joint graph across samples, identify clusters in a multi-sample panel, or propagate cell labels across datasets.
homepage: https://cran.r-project.org/web/packages/conos/index.html
---


# r-conos

## Overview
`conos` (Clustering On Network of Samples) is an R package designed to wire together large collections of single-cell RNA-seq datasets. It establishes weighted inter-sample cell-to-cell links to create a joint graph, allowing for the identification of homologous cell types across heterogeneous samples (e.g., different patients, tissues, or technologies). It is particularly robust to inter-sample variation and scales well to atlas-level data.

## Installation
To install the stable version from CRAN:
```r
install.packages('conos')
```

To install the development version:
```r
devtools::install_github('kharchenkolab/conos')
```

## Core Workflow
The standard `conos` workflow follows an object-oriented approach using R6 classes.

### 1. Initialization
Create a `Conos` object from a list of pre-processed `pagoda2` or `Seurat` objects.
```r
library(conos)
# pl is a named list of processed single-cell objects
con <- Conos$new(pl, n.cores = 4)
```

### 2. Graph Construction
Build the joint graph by identifying inter-sample mappings.
```r
# space='PCA' is common; k and k.self control alignment strength
con$buildGraph(k = 15, k.self = 5, space = 'PCA', ncomps = 30)
```

### 3. Community Detection
Identify clusters across the entire panel.
```r
# Supports 'leiden', 'walktrap', 'multilevel', etc.
con$findCommunities(method = leiden.community, resolution = 1.0)
```

### 4. Embedding and Visualization
Generate a joint embedding (UMAP or t-SNE) for visualization.
```r
con$embedGraph(method = 'UMAP')

# Plot the joint graph colored by clusters
con$plotGraph(clustering = 'leiden')

# Plot the panel to see cluster distribution across samples
con$plotPanel(clustering = 'leiden', use.local.stacking = TRUE)
```

## Advanced Features

### Label Propagation
Propagate annotations from a labeled subset of cells to the rest of the joint graph.
```r
# labels is a named factor of cell annotations
con$propagateLabels(labels = labels, method = 'knn')
```

### RNA Velocity
To run RNA velocity on a `Conos` object, you must use `dropEst` for initial alignment to get spliced/unspliced counts and the `velocyto.R` package.
```r
library(velocyto.R)
# cms.list is a list of velocity matrices from dropEst
vi <- velocityInfoConos(cms.list = cms.list, con = con)
# Estimate and plot
vel.info <- gene.relative.velocity.estimates(vi$emat, vi$nmat, cell.dist = con$clusters$leiden$dist)
```

### Integration with Scanpy
To move data to Python/Scanpy, use the built-in export functions to save the graph and embeddings.
```r
# Export for Scanpy
con$saveConosForScanpy(dir = "conos_export/", clustering = 'leiden')
```

## Tips for Success
- **Uniform Pre-processing**: While `conos` is robust, it is recommended to process all input datasets (filtering, normalization) uniformly using `pagoda2` or `Seurat` before creating the `Conos` object.
- **Alignment Strength**: If samples are not aligning well, try increasing `k` in `buildGraph()`. If they are over-aligning (blurring distinct biology), decrease `k`.
- **Memory Management**: For very large datasets, ensure `n.cores` is set appropriately and consider using `space='CPCA'` for cross-dataset alignment.

## Reference documentation
- [conos README](./references/README.md)