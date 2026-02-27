---
name: bioconductor-conclus
description: Bioconductor-conclus performs robust consensus clustering and marker gene identification for single-cell RNA-seq data. Use when user asks to perform scRNA-seq clustering, generate t-SNE ensembles, run DBSCAN across multiple parameters, or identify and visualize cluster-specific marker genes.
homepage: https://bioconductor.org/packages/3.13/bioc/html/conclus.html
---


# bioconductor-conclus

name: bioconductor-conclus
description: Robust clustering and positive marker feature selection for single-cell RNA-seq (scRNA-seq) data using consensus clustering. Use this skill when you need to perform scRNA-seq analysis in R, specifically for identifying rare cell populations, generating t-SNE ensembles, running DBSCAN clustering across multiple parameters, and identifying/visualizing marker genes.

# bioconductor-conclus

## Overview

CONCLUS is a Bioconductor package designed for robust scRNA-seq clustering. It addresses the stochastic nature of t-SNE and clustering by using a consensus approach: it generates multiple t-SNE plots with varying parameters, applies DBSCAN clustering to each, and combines the results into a cell similarity matrix to define stable "consensus" clusters. It is particularly effective for identifying rare cell populations in mouse and human datasets.

## Typical Workflow

### 1. Data Initialization
CONCLUS requires a raw count matrix (genes in rows, cells in columns) and metadata.

```R
library(conclus)

# Load data
countMatrix <- loadDataOrMatrix(file="counts.tsv", type="countMatrix")
columnsMetaData <- loadDataOrMatrix(file="metadata.tsv", type="coldata", columnID="cell_ID")

# Create the scRNA-seq object
scr <- singlecellRNAseq(experimentName="MyExperiment", 
                        countMatrix=countMatrix, 
                        species="mouse", 
                        outputDirectory=tempdir())
```

### 2. Normalization and Filtering
The package uses `scran` and `scater` for normalization.

```R
scr <- normaliseCountMatrix(scr, coldata=columnsMetaData)
# Access normalized data via getSceNorm(scr)
```

### 3. Consensus Clustering Pipeline
The core workflow involves generating t-SNE coordinates, running DBSCAN, and calculating similarity.

```R
# Generate ensemble of t-SNEs (default 14 plots)
scr <- generateTSNECoordinates(scr, cores=2)

# Run DBSCAN with range of epsilon and minPoints (default 84 solutions)
scr <- runDBSCAN(scr, cores=2)

# Calculate cell similarity and define consensus clusters
scr <- clusterCellsInternal(scr, clusterNumber=10)

# Calculate cluster similarity
scr <- calculateClustersSimilarity(scr)
```

### 4. Marker Gene Identification
Identify genes that characterize each consensus cluster.

```R
# Rank genes by significance
scr <- rankGenes(scr)

# Retrieve top markers (e.g., top 10)
scr <- retrieveTopClustersMarkers(scr, removeDuplicates=TRUE)
topMarkers <- getClustersMarkers(scr)

# Optional: Fetch functional annotation from NCBI/UniProt
scr <- retrieveGenesInfo(scr)
```

### 5. Visualization
CONCLUS provides specific plotting functions for its results.

```R
# Plot t-SNE colored by consensus clusters
plotClusteredTSNE(scr, columnName="clusters")

# Plot Cell Similarity Heatmap (shows cluster stability)
plotCellSimilarity(scr)

# Plot Marker Gene Heatmap
plotCellHeatmap(scr, orderClusters=TRUE, orderGenes=TRUE)

# Plot expression of a specific gene on t-SNE
plotGeneExpression(scr, "GeneSymbol", tSNEpicture=1)
```

## Advanced Usage: Supervised Clustering
If the cluster similarity matrix suggests that certain clusters are redundant, they can be merged manually.

```R
# Retrieve current assignments
clustCellsDf <- retrieveTableClustersCells(scr)

# Merge cluster 2 into cluster 1
clustCellsDf$clusters[which(clustCellsDf$clusters == 2)] <- 1

# Update the object
scrUpdated <- addClustering(scr, clusToAdd=clustCellsDf)
```

## Tips for Success
- **Cell Count**: CONCLUS is recommended for datasets with at least 100 cells.
- **Species**: Currently supports "mouse" and "human".
- **Reproducibility**: Use `set.seed(42)` or the default seed in `generateTSNECoordinates` to ensure consistent t-SNE results.
- **Parameter Tuning**: Use `testClustering()` to check if default DBSCAN epsilon values are appropriate for your data (look for the "knee" in the k-NN distance plot).

## Reference documentation
- [ScRNA-seq workflow CONCLUS: from CONsensus CLUSters to a meaningful CONCLUSion](./references/conclus_vignette.md)