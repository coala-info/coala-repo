---
name: bioconductor-destiny
description: bioconductor-destiny implements Diffusion Maps and Diffusion Pseudo Time for the analysis of single-cell gene expression data. Use when user asks to perform non-linear dimension reduction, identify developmental branching points, calculate pseudotime metrics, or find gene relevance in single-cell datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/destiny.html
---

# bioconductor-destiny

name: bioconductor-destiny
description: Analysis of single-cell gene expression data using Diffusion Maps and Diffusion Pseudo Time (DPT). Use this skill to perform non-linear dimension reduction, identify developmental branching/bifurcations, calculate pseudotime metrics, and find gene relevance in single-cell qPCR or RNA-seq datasets.

# bioconductor-destiny

## Overview

The `destiny` package implements Diffusion Maps for single-cell analysis. It is specifically designed to handle the noise characteristics of single-cell data, such as drop-outs (censoring) and missing values. It excels at arranging cells along developmental trajectories and identifying branching points where cell fate decisions occur.

## Core Workflow

### 1. Data Preparation
`destiny` accepts `matrix`, `data.frame`, or Bioconductor `ExpressionSet` / `SingleCellExperiment` objects.
- **qPCR data**: Usually already on a log (Ct) scale.
- **RNA-seq data**: Should be variance-stabilized (e.g., log-transformed counts).
- **Large datasets**: For >5,000 cells, use `k` (nearest neighbors) to limit memory usage.

### 2. Creating a Diffusion Map
The primary function is `DiffusionMap()`.

```r
library(destiny)
# Basic usage
dm <- DiffusionMap(data)

# With noise modeling for censored values (e.g., Ct > 28)
dm <- DiffusionMap(data, censor_val = 15, censor_range = c(15, 40))

# For scRNA-seq, often beneficial to use PCA first
dm <- DiffusionMap(sce_object, n_pcs = 50)
```

### 3. Visualization
The `plot()` function for `DiffusionMap` objects returns a ggplot2 object.

```r
# 3D plot (default)
plot(dm)

# 2D plot of specific components
plot(dm, 1:2, col_by = 'cell_type')

# Using ggplot2 directly
library(ggplot2)
ggplot(dm, aes(DC1, DC2, color = factor(stage))) + geom_point()
```

### 4. Diffusion Pseudo Time (DPT)
DPT calculates a metric based on transition probabilities to order cells.

```r
# Create DPT from DiffusionMap
dpt <- DPT(dm)

# Plotting branches and paths
plot(dpt, col_by = 'branch')
plot(dpt, root = 2, paths_to = c(1, 3))
```

### 5. Gene Relevance
Identify which genes drive the diffusion components.

```r
rel <- gene_relevance(dm)
plot(rel)
```

### 6. Prediction (Projection)
Project new data into an existing diffusion map.

```r
pred <- dm_predict(dm_old, new_data)
plot(dm_old, new_dcs = pred)
```

## Key Parameters
- `sigma`: The kernel width. Use `'local'` (default) for per-cell estimation or `'global'` for a heuristic-based fixed value.
- `k`: Number of nearest neighbors. Reducing `k` speeds up computation for large datasets.
- `distance`: Metric for the transition matrix (e.g., `'euclidean'`, `'cosine'`, `'rankcor'`).

## Reference documentation

- [Diffusion Pseudo Time (DPT)](./references/DPT.md)
- [Diffusion Map Quickstart](./references/Diffusion-Map-recap.md)
- [Main Diffusion Maps Vignette](./references/Diffusion-Maps.md)
- [Gene Relevance Analysis](./references/Gene-Relevance.md)
- [Gaussian Kernel Width (Sigma)](./references/Global-Sigma.md)
- [Tidyverse and GGPlot Integration](./references/tidyverse.md)