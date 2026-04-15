---
name: bioconductor-veloviz
description: VeloViz creates RNA-velocity-informed 2D embeddings to visualize cell trajectories in single-cell transcriptomics data. Use when user asks to build a velocity-informed graph, generate 2D embeddings from current and projected transcriptional states, or visualize biological transitions in single-cell data.
homepage: https://bioconductor.org/packages/release/bioc/html/veloviz.html
---

# bioconductor-veloviz

name: bioconductor-veloviz
description: Create RNA-velocity-informed 2D embeddings for single-cell transcriptomics data. Use this skill when you have current and projected transcriptional states (e.g., from velocyto.R or scVelo) and need to visualize cell trajectories in a 2D space that accounts for velocity vectors.

# bioconductor-veloviz

## Overview
`veloviz` is an R package that generates 2D embeddings for single-cell data by incorporating RNA velocity information. Unlike standard dimensionality reduction (like UMAP or t-SNE) which only considers current expression, `veloviz` uses the predicted future state of cells to build a velocity-informed graph, ensuring that the resulting visualization reflects the underlying biological transitions.

## Installation
```R
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("veloviz")
```

## Typical Workflow

### 1. Prepare Input Data
The package requires two matrices:
- `curr`: Observed current transcriptional state (genes x cells).
- `proj`: Predicted future transcriptional state (genes x cells).

These are typically derived from RNA velocity tools like `velocyto.R` or `scVelo`.

### 2. Build the VeloViz Graph
Use the `buildVeloviz` function to create the embedding.

```R
library(veloviz)

# Example using internal data
data(vel)
curr <- vel$current
proj <- vel$projected

veloviz_res <- buildVeloviz(
  curr = curr, 
  proj = proj,
  normalize.depth = TRUE,
  use.ods.genes = FALSE,
  pca = TRUE, 
  nPCs = 10,
  center = TRUE, 
  scale = TRUE,
  k = 10, 
  similarity.threshold = -1,
  distance.weight = 1, 
  distance.threshold = 1,
  weighted = TRUE, 
  verbose = FALSE
)
```

### 3. Extract and Plot Coordinates
The 2D coordinates are stored in the `fdg_coords` slot of the returned object.

```R
# Extract coordinates
emb <- veloviz_res$fdg_coords

# Basic plot
plot(emb, pch = 16, main = "VeloViz Embedding")
```

## Key Parameters for `buildVeloviz`
- `nPCs`: Number of principal components to use for initial dimensionality reduction.
- `k`: Number of nearest neighbors to consider when building the graph.
- `similarity.threshold`: Minimum similarity required to keep an edge between cells.
- `normalize.depth`: Whether to normalize for sequencing depth.
- `weighted`: If TRUE, edges in the graph are weighted by the similarity between the projected state and the neighbor's current state.

## Tips for Success
- **Gene Selection**: While `buildVeloviz` can perform PCA, pre-filtering for highly variable genes or velocity-informative genes often improves the embedding quality.
- **Input Scale**: Ensure that `curr` and `proj` are in the same numerical scale (e.g., both log-transformed or both raw counts).
- **Graph Connectivity**: If the embedding looks like a "hairball," try increasing the `similarity.threshold` or decreasing `k`.

## Reference documentation
- [VeloViz Vignette](./references/vignette.md)