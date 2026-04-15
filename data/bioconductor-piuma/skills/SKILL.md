---
name: bioconductor-piuma
description: This tool performs Topological Data Analysis on high-dimensional biological datasets using the Mapper algorithm to represent data as graph-based simplicial complexes. Use when user asks to create TDA objects, project data into low-dimensional spaces, generate simplicial complexes, assess network geometry, or perform geometry-guided community mining.
homepage: https://bioconductor.org/packages/release/bioc/html/PIUMA.html
---

# bioconductor-piuma

name: bioconductor-piuma
description: Perform Topological Data Analysis (TDA) on high-dimensional datasets, such as -omics and single-cell RNA-seq data, using the Mapper algorithm. Use this skill to create TDA objects, project data into low-dimensional spaces (UMAP, t-SNE, PCA), generate simplicial complexes (networks), assess network geometry (scale-free, small-world), and perform geometry-guided community mining.

## Overview

PIUMA (Phenotypes Identification Using Mapper from topological data Analysis) is a Bioconductor package designed to extract meaningful patterns from complex biological data. It implements the Mapper algorithm to represent high-dimensional data as a graph-based simplicial complex. Key features include automated network geometry prediction and "geometry-aware" clustering, which selects the best community detection algorithm (e.g., fast-greedy for scale-free networks, walktrap for small-world) based on the intrinsic topology of the data.

## Core Workflow

### 1. Initialization
Create a `TDAobj` from a data frame or a `SummarizedExperiment`.
```r
library(PIUMA)
# From data.frame (df_TDA) with metadata columns to be used as outcomes
tda_obj <- makeTDAobj(df_TDA, outcome_cols = c("stage", "zone"))

# From SummarizedExperiment (se)
tda_obj <- makeTDAobjFromSE(se, outcome_cols = "cell_type")
```

### 2. Preprocessing (Lensing and Distance)
Project the "point-cloud" into a lower dimension and compute the distance matrix.
```r
# Compute distance (euclidean, pearson, or gower)
tda_obj <- dfToDistance(tda_obj, distMethod = "euclidean")

# Project data (UMAP, TSNE, PCA, MDS, KPCA, ISOMAP)
tda_obj <- dfToProjection(tda_obj, projMethod = "UMAP", nComp = 2, umapNNeigh = 25)
```

### 3. Mapper Core
Partition data into overlapping bins and cluster within bins to create the network nodes.
```r
tda_obj <- mapperCore(tda_obj, nBins = 15, overlap = 0.3, clustMeth = "kmeans")
```

### 4. Network Construction and Assessment
Generate the Jaccard similarity matrix (edges) and predict the graph's topological class.
```r
tda_obj <- jaccardMatrix(tda_obj)
tda_obj <- setGraph(tda_obj)

# Predict geometry (SF: Scale-Free, WS: Small-World, RGG: Random Geometric, etc.)
tda_obj <- predict_mapper_class(tda_obj, verbose = TRUE)

# Check scale-free fit manually
net_stats <- checkScaleFreeModel(tda_obj, showPlot = TRUE)
```

### 5. Community Mining
Perform automated clustering based on the predicted geometry.
```r
# Automatically selects algorithm (e.g., fast-greedy for SF, walktrap for WS)
tda_obj <- autoClusterMapper(tda_obj, method = "automatic")

# Access results
obs_clusters <- tda_obj@clustering$obs_cluster  # Cell-to-cluster mapping
node_clusters <- tda_obj@clustering$nodes_cluster # Node-to-cluster mapping
```

## Integration with Seurat

PIUMA can be used to find sub-populations that standard SNN clustering might miss.
1. Preprocess in Seurat (Normalize, Scale, PCA, UMAP).
2. Convert to `SummarizedExperiment` then `TDAobj`.
3. Manually inject Seurat's UMAP coordinates into the `TDAobj@comp` slot to use them as the Mapper lens.
4. Run `mapperCore` and `autoClusterMapper`.
5. Add PIUMA clusters back to Seurat metadata: `pbmc@meta.data$PIUMA_clusters <- clusters_piuma`.

## Tips and Best Practices

- **Lens Selection**: UMAP is generally recommended for biological data as it preserves local and global structure well.
- **Hyperparameters**: `nBins` (resolution) and `overlap` (connectivity) are critical. Higher `nBins` creates a more granular graph; higher `overlap` creates more edges.
- **Node Enrichment**: Use `tdaDfEnrichment(tda_obj, data)` to calculate average feature values per node for visualization or downstream analysis.
- **Scale-Free Assessment**: Biological networks are often scale-free ($2 < \gamma < 3$). If `predict_mapper_class` returns "SF", modularity-based clustering is usually optimal.
- **Exporting**: Use `getJacc(tda_obj)` and `getNodeDataMat(tda_obj)` to export the network for visualization in Cytoscape.

## Reference documentation

- [The PIUMA package - Phenotypes Identification Using Mapper from topological data Analysis](./references/PIUMA_vignette.md)
- [Topology-based Clustering in Seurat](./references/VignetteSeurat.md)