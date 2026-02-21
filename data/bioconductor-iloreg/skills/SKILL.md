---
name: bioconductor-iloreg
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ILoReg.html
---

# bioconductor-iloreg

name: bioconductor-iloreg
description: Identification of cell populations from single-cell RNA-seq (scRNA-seq) data using the ILoReg package. Use this skill for high-resolution clustering, probabilistic feature extraction via Iterative Clustering Projection (ICP), and differential expression analysis in scRNA-seq workflows.

# bioconductor-iloreg

## Overview

ILoReg is a Bioconductor package designed for high-resolution cell population identification. Unlike standard pipelines that rely on feature selection (e.g., selecting highly variable genes), ILoReg uses a self-supervised learning algorithm called Iterative Clustering Projection (ICP). ICP performs probabilistic feature extraction to create a consensus matrix, which is then used for hierarchical clustering and visualization. This approach is particularly effective at identifying rare cell populations that might be missed by traditional PCA-based methods.

## Core Workflow

### 1. Data Preparation
ILoReg requires a log-transformed, normalized gene expression matrix. It is optimized for sparse data (`dgCMatrix`).

```R
library(ILoReg)
library(SingleCellExperiment)

# Create SCE object from normalized counts
sce <- SingleCellExperiment(assays = list(logcounts = normalized_matrix))

# Filter zero-expression genes and prepare for ILoReg
sce <- PrepareILoReg(sce)
```

### 2. Iterative Clustering Projection (ICP)
This is the most computationally intensive step. It runs ICP $L$ times to generate a joint probability matrix.

```R
set.seed(1)
sce <- RunParallelICP(
  object = sce, 
  k = 15,          # Initial clusters (increase for higher resolution)
  d = 0.3,         # Downsampling rate (0.2 to 0.3 recommended)
  L = 200,         # Number of ICP runs (default 200)
  C = 0.3,         # L1 regularization trade-off
  reg.type = "L1", # Lasso regression
  threads = 0      # 0 uses all available cores minus one
)
```

### 3. Consensus Matrix and Dimensionality Reduction
The probability matrices are merged and reduced via PCA, followed by t-SNE or UMAP for visualization.

```R
# PCA transformation
sce <- RunPCA(sce, p = 50, scale = FALSE)

# Optional: Check elbow plot to select p
PCAElbowPlot(sce)

# Nonlinear reduction
sce <- RunUMAP(sce)
sce <- RunTSNE(sce, perplexity = 30)
```

### 4. Clustering and Annotation
ILoReg uses Ward's hierarchical clustering on the consensus matrix.

```R
# Perform hierarchical clustering
sce <- HierarchicalClustering(sce)

# Extract K clusters (this overwrites previous manual clustering)
sce <- SelectKClusters(sce, K = 13)

# Rename clusters for biological interpretation
sce <- RenameAllClusters(sce, new.cluster.names = c("T-cells", "B-cells", ...))
```

### 5. Differential Expression (DE) Analysis
Identify marker genes for the identified clusters using the Wilcoxon rank-sum test.

```R
# Find markers for all clusters
gene_markers <- FindAllGeneMarkers(
  sce,
  log2fc.threshold = 0.25,
  min.pct = 0.25,
  only.pos = TRUE
)

# Select top markers
top10_markers <- SelectTopGenes(gene_markers, top.N = 10, criterion.type = "log2FC")

# DE between two specific groups
specific_markers <- FindGeneMarkers(
  sce,
  clusters.1 = "Cluster A",
  clusters.2 = "Cluster B"
)
```

## Visualization Functions

*   `ClusteringScatterPlot(sce, dim.reduction.type = "umap")`: Visualize clusters.
*   `GeneScatterPlot(sce, genes = c("CD3D"), dim.reduction.type = "tsne")`: Visualize specific gene expression.
*   `GeneHeatmap(sce, gene.markers = top10_markers)`: Heatmap of cluster markers.
*   `VlnPlot(sce, genes = c("CD3D"))`: Violin plots of gene expression across clusters.
*   `SilhouetteCurve(sce)`: Plot average silhouette values to estimate optimal $K$.

## Tips for Success
*   **Resolution Control**: To increase resolution (find more sub-populations), increase `k` in `RunParallelICP`. To decrease resolution, increase `d` (e.g., to 0.5).
*   **Reproducibility**: Always use `set.seed()` before `RunParallelICP` as the algorithm is stochastic.
*   **Memory**: Ensure data is in sparse format (`dgCMatrix`) to prevent excessive memory usage and long run times.
*   **Optimal K**: Use `CalcSilhInfo(sce, K.start = 2, K.end = 50)` to help determine the natural number of clusters in the data.

## Reference documentation
- [ILoReg package manual](./references/ILoReg.md)
- [ILoReg R Markdown Source](./references/ILoReg.Rmd)