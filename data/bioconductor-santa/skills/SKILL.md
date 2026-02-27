---
name: bioconductor-santa
description: bioconductor-santa quantifies the functional content of molecular networks by measuring the clustering of phenotypes using an adapted Ripley's K-function. Use when user asks to measure the strength of association between a network and a phenotype, identify functional enrichment in gene sets, or prioritize genes based on their proximity to high-weight nodes.
homepage: https://bioconductor.org/packages/release/bioc/html/SANTA.html
---


# bioconductor-santa

name: bioconductor-santa
description: Quantify the functional content of molecular networks by measuring the clustering of phenotypes (hits or continuous weights) using Ripley's K-function adapted for networks. Use when analyzing gene sets or phenotypes on biological networks to identify functional enrichment, prioritize genes, or compare network informativeness across different conditions or data sources.

## Overview

SANTA (Spatial Analysis of NeTwork Association) applies spatial statistics—specifically Ripley’s K-function—to biological networks. It operates on the "guilt-by-association" principle to determine if a set of genes (hits) or a continuous phenotype (e.g., expression, essentiality) clusters more significantly on a network than would be expected by chance.

The package provides two primary metrics:
1. **Knet**: Measures the strength of association between a whole network and a phenotype.
2. **Knode**: Ranks individual nodes based on their proximity to high-weight vertices, useful for gene prioritization.

## Core Workflow

### 1. Prepare the Network
SANTA uses `igraph` objects. Networks should ideally be undirected. Edge weights can be converted to distances (where smaller values indicate stronger interactions).

```r
library(SANTA)
library(igraph)

# Create or load an igraph object
# Example: converting correlation to distance
E(g)$distance <- -log10(abs(E(g)$weight))
```

### 2. Define Vertex Weights
Weights represent the phenotype. These can be binary (1 for hit, 0 for non-hit) or continuous (e.g., -log10 p-values). Use `NA` for vertices with missing data to exclude them from permutation testing.

```r
# Binary hits
V(g)$phenotype <- as.numeric(V(g)$name %in% hit_list)

# Continuous weights
V(g)$phenotype <- rnai_scores
```

### 3. Pre-compute Distances (Optional but Recommended)
For large networks or multiple runs, pre-compute the distance matrix and bins to save time.

```r
# Compute distance matrix (shortest.paths, diffusion, or mfpt)
D <- DistGraph(g, dist.method="shortest.paths")

# Discretize distances into bins
B <- BinGraph(D)
```

### 4. Run Knet Analysis
`Knet` calculates the clustering significance via permutations.

```r
# Run with pre-computed bins B
res <- Knet(g, nperm=1000, vertex.attr="phenotype", edge.attr="distance", B=B)

# Access p-value and observed Area Under the K-curve (AUK)
print(res$pval)
print(res$obs)
```

### 5. Prioritize Genes with Knode
`Knode` identifies genes that are "close" to the functional cluster, even if they weren't initial hits.

```r
node_scores <- Knode(g, vertex.attr="phenotype", dist.method="shortest.paths")
# Higher scores indicate closer proximity to high-weight clusters
head(sort(node_scores, decreasing=TRUE))
```

## Key Functions and Parameters

- **Distance Methods**:
  - `"shortest.paths"`: Standard graph distance (default).
  - `"diffusion"`: Incorporates multiple paths via a diffusion kernel.
  - `"mfpt"`: Mean First-Passage Time; based on random walks.
- **`Knet()` Parameters**:
  - `nperm`: Number of permutations for p-value calculation (use $\ge 1000$ for publication).
  - `vertex.attr`: Name of the vertex attribute containing weights.
  - `edge.attr`: Name of the edge attribute containing distances.
- **`Compactness()`**: A simpler alternative to `Knet` that measures the mean distance between hits. Unlike `Knet`, it does not handle continuous weights or account for vertex degree distributions.

## Tips for Success

- **Vertex Degree**: `Knet` is superior to simple compactness because it accounts for the global distribution of vertices and node degrees, preventing high-degree hubs from biasing the clustering significance.
- **Missing Data**: Always set missing phenotypes to `NA`. SANTA will exclude these nodes from the permutation process, ensuring they don't dilute the significance.
- **Edge Distances**: If your network has "strengths" (like confidence scores), convert them to distances (e.g., $1/score$ or $-log(score)$) before running `Knet`.
- **Visualization**: Use `plot(res)` on a `Knet` result object to visualize the observed K-curve against the null distribution of permuted curves.

## Reference documentation

- [Introduction to SANTA](./references/SANTA-vignette.md)
- [Introduction to SANTA (RMarkdown)](./references/SANTA-vignette.Rmd)