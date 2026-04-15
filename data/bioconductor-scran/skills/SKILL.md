---
name: bioconductor-scran
description: The scran package provides specialized methods for the low-level analysis of single-cell RNA-seq data, including normalization, variance modeling, and clustering. Use when user asks to normalize single-cell data via deconvolution, identify highly variable genes, denoise data through PCA, perform graph-based clustering, or detect marker genes.
homepage: https://bioconductor.org/packages/release/bioc/html/scran.html
---

# bioconductor-scran

## Overview

The `scran` package provides essential methods for the low-level analysis of single-cell RNA-seq data. It is designed to work seamlessly with the `SingleCellExperiment` class. Key functionalities include scaling normalization via deconvolution, identifying highly variable genes (HVGs) by decomposing variance into technical and biological components, denoising data through PCA, and performing graph-based clustering and marker gene detection.

## Typical Workflow

### 1. Normalization
`scran` uses a deconvolution strategy to calculate size factors, which is more robust to the high frequency of zeroes in scRNA-seq than standard bulk methods.

```r
library(scran)
# Pre-clustering helps avoid pooling cells across different types
clusters <- quickCluster(sce)
sce <- computeSumFactors(sce, clusters=clusters)
# Apply normalization (usually via scuttle)
sce <- scuttle::logNormCounts(sce)
```

### 2. Variance Modelling
Identify genes driving biological variation by fitting a trend to the technical noise.

```r
# Model variance without spike-ins
dec <- modelGeneVar(sce)

# Model variance using spike-ins (if available)
dec.spike <- modelGeneVarWithSpikes(sce, 'ERCC')

# Extract top Highly Variable Genes (HVGs)
top.hvgs <- getTopHVGs(dec, prop=0.1) # Top 10%
```

### 3. Dimensionality Reduction & Denoising
Use variance estimates to choose the number of Principal Components (PCs) that capture biological signal while discarding technical noise.

```r
# Denoise PCA based on the variance model
sce <- denoisePCA(sce, technical=dec)

# Alternatively, choose PCs based on cluster separation
pc.choice <- getClusteredPCs(reducedDim(sce, "PCA"))
npcs <- metadata(pc.choice)$chosen
```

### 4. Graph-Based Clustering
Construct a Shared Nearest Neighbor (SNN) graph and use `igraph` for community detection.

```r
# Build SNN graph from PCs
g <- buildSNNGraph(sce, use.dimred="PCA")
cluster.out <- igraph::cluster_walktrap(g)$membership
colLabels(sce) <- factor(cluster.out)
```

### 5. Marker Gene Identification
Identify genes that distinguish clusters using pairwise comparisons and various effect size summaries (AUC, Cohen's d, Log-fold change).

```r
# Compute marker statistics for all clusters
markers <- scoreMarkers(sce)

# Inspect markers for a specific cluster (e.g., Cluster 1)
# Sort by mean.AUC for robust markers
c1.markers <- markers[["1"]]
ordered.c1 <- c1.markers[order(c1.markers$mean.AUC, decreasing=TRUE), ]
```

## Advanced Tasks

- **Blocking Factors:** Use the `block=` argument in `modelGeneVar` or `correlatePairs` to account for uninteresting variation (e.g., batch or donor) during analysis.
- **Subclustering:** Use `quickSubCluster(sce, groups=colLabels(sce))` to perform a second round of HVG selection and clustering within specific cell populations.
- **Gene Correlations:** Use `correlatePairs()` to identify genes that are significantly co-expressed, helping to distinguish biological signal from stochastic noise.
- **Format Conversion:** Use `convertTo(sce, type="edgeR")` or `type="DESeq2"` to move data into other Bioconductor frameworks for differential expression.

## Reference documentation

- [Using scran to analyze single-cell RNA-seq data](./references/scran.md)
- [scran Rmd Vignette](./references/scran.Rmd)