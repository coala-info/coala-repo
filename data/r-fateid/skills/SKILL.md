---
name: r-fateid
description: This tool quantifies and visualizes cell fate bias in multi-lineage single-cell transcriptome data. Use when user asks to determine differentiation probabilities of progenitor cells, identify genes associated with fate decisions, or reconstruct differentiation trajectories.
homepage: https://cran.r-project.org/web/packages/fateid/index.html
---


# r-fateid

name: r-fateid
description: Quantify and visualize cell fate bias in multi-lineage single-cell transcriptome data. Use this skill when analyzing single-cell RNA-seq datasets to determine the differentiation probabilities of progenitor cells toward specific mature lineages and to identify genes associated with fate decisions.

## Overview
The `FateID` package provides a framework for the quantification of fate bias in multipotent progenitors. It uses an iterative random forest classification approach to assign fate probabilities to cells based on their proximity to defined target clusters (mature cell types). This allows for the reconstruction of differentiation trajectories and the identification of early molecular markers for specific lineages.

## Installation
Install the package from CRAN:
```R
install.packages("FateID")
```

## Core Workflow

### 1. Data Preparation
FateID requires a normalized gene expression matrix and a clustering of the cells.
- **Expression Matrix**: Rows are genes, columns are cells.
- **Clustering**: A vector or list defining cell clusters (e.g., from RaceID or Seurat).

### 2. Defining Target Clusters
Identify the clusters representing the mature endpoints of differentiation.
```R
# Example: Clusters 1, 2, and 3 are mature lineages
target_clusters <- c(1, 2, 3)
```

### 3. Computing Fate Bias
The `get_fate_bias` function calculates the probability of each cell belonging to each of the target lineages.
```R
# x: expression matrix, y: cluster vector, tar: target clusters
fb <- get_fate_bias(x, y, tar = target_clusters)
```

### 4. Visualization
Visualize fate bias on a reduced dimension map (t-SNE or UMAP).
```R
# Plotting fate bias for a specific target lineage
plot_fate_bias(fb, dr, target = 1) 
# dr: coordinates from Rtsne or umap
```

### 5. Identifying Fate-Associated Genes
Identify genes whose expression correlates with the movement toward a specific fate.
```R
# Extract genes for a specific fate
genes <- extract_fate_genes(x, fb, target = 1, threshold = 0.5)

# Plot gene expression along the fate trajectory
plot_fate_genes(x, fb, genes$genes, target = 1)
```

## Key Functions
- `get_fate_bias()`: Main function to compute fate probabilities using random forest.
- `plot_fate_bias()`: Overlays fate probabilities onto dimensional reduction plots.
- `extract_fate_genes()`: Identifies genes significantly associated with a specific differentiation direction.
- `plot_fate_genes()`: Generates heatmaps or line plots of gene expression changes along fate bias gradients.
- `reorder_cells()`: Reorders cells based on their fate bias to visualize pseudo-temporal trends.

## Tips for Success
- **Normalization**: Ensure the input expression matrix is properly normalized (e.g., CPM or transcripts per cell) and log-transformed if necessary.
- **Target Selection**: The accuracy of FateID depends on correctly identifying the "endpoint" clusters. If endpoints are not well-defined, the bias calculation may be noisy.
- **Feature Selection**: While FateID can run on all genes, pre-filtering for highly variable genes can improve performance and reduce computation time.
- **Iteration**: The algorithm is iterative; ensure the number of iterations is sufficient for the classification to stabilize.

## Reference documentation
- [FateID Home Page](./references/home_page.md)