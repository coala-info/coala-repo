---
name: bioconductor-netsmooth
description: netSmooth implements a network-smoothing framework that uses graph-based diffusion to reduce noise and dropout effects in omics datasets. Use when user asks to smooth single-cell RNA-seq data using protein-protein interaction networks, optimize diffusion parameters for clustering, or identify robust cell populations.
homepage: https://bioconductor.org/packages/release/bioc/html/netSmooth.html
---


# bioconductor-netsmooth

## Overview

`netSmooth` is an R package that implements a network-smoothing framework for omics datasets, particularly single-cell RNA-seq. It uses a graph-based diffusion process where gene expression values are smoothed based on their neighbors in a provided network (like a PPI). The intuition is that genes connected in a network should have predictive expression patterns for one another. This process helps overcome the "dropout" effect and high noise levels typical in single-cell data.

## Core Workflow

### 1. Prepare Input Data
You need two primary inputs:
- **Expression Matrix**: A genes-by-samples matrix (or a `SingleCellExperiment` object).
- **Adjacency Matrix**: A square matrix representing the network, where row and column names match the gene IDs in the expression matrix.

### 2. Basic Smoothing
Use the `netSmooth()` function to perform the diffusion.

```r
library(netSmooth)
library(SingleCellExperiment)

# Load example data
data(smallPPI)
data(smallscRNAseq)

# Smooth with a fixed alpha (0 = no smoothing, 1 = maximum diffusion)
smoothed_exp <- netSmooth(smallscRNAseq, smallPPI, alpha=0.5)

# Result is a SummarizedExperiment; convert to SCE if needed
sce_smoothed <- SingleCellExperiment(
    assays=list(counts=assay(smoothed_exp)),
    colData=colData(smoothed_exp)
)
```

### 3. Optimizing Alpha
The `alpha` parameter controls the diffusion distance. You can let the package find an optimal value automatically based on robust clustering performance.

```r
# Automated alpha optimization
smoothed_auto <- netSmooth(smallscRNAseq, smallPPI, alpha='auto')
```

### 4. Robust Clustering
The package provides `robustClusters()` which uses the `clusterExperiment` framework to find stable cell populations.

```r
# Cluster the smoothed data
clustering_results <- robustClusters(smoothed_auto, 
                                     makeConsensusMinSize=2, 
                                     makeConsensusProportion=0.9)

# Access cluster assignments (-1 indicates unassigned/noise)
clusters <- clustering_results$clusters
```

### 5. Dimensionality Reduction Selection
Different datasets respond better to different DR methods (PCA, t-SNE, UMAP). `netSmooth` can pick the best one by calculating the entropy of the 2D embedding.

```r
# Calculate embeddings
library(scater)
sce <- runPCA(smallscRNAseq, ncomponents=2)
sce <- runTSNE(sce, ncomponents=2)

# Pick the method with the highest information content (entropy)
best_dr <- pickDimReduction(sce)
```

## Building Networks from StringDB
If you do not have a pre-computed adjacency matrix, you can build one using `STRINGdb`:

1.  Retrieve the graph for your species (e.g., 9606 for Human).
2.  Filter for high-confidence edges (e.g., top 10% of `combined_score`).
3.  Convert the graph to an adjacency matrix using `igraph::as_adjacency_matrix()`.
4.  Map Protein IDs to Gene IDs (Ensembl) using `biomaRt` to match your expression data.

## Tips and Troubleshooting
- **Gene Mismatch**: If genes in your expression matrix are missing from the network, `netSmooth` will keep the original values for those genes and attach them to the smoothed matrix.
- **Performance**: For large datasets, ensure R is linked against optimized BLAS libraries (like openBLAS) to speed up matrix operations.
- **Data Scale**: It is common to visualize results using `log2(assay(sce) + 1)` for heatmaps after smoothing.

## Reference documentation
- [Building PPIs from StringDB](./references/buildingPPIsFromStringDB.md)
- [Introduction to netSmooth package](./references/netSmoothIntro.md)