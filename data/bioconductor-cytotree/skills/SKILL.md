---
name: bioconductor-cytotree
description: CytoTree is an R package for analyzing multidimensional flow and mass cytometry data using clustering and trajectory inference. Use when user asks to analyze cytometry data, perform SOM clustering, run dimensionality reduction, construct trajectory trees, or estimate pseudotime.
homepage: https://bioconductor.org/packages/3.12/bioc/html/CytoTree.html
---

# bioconductor-cytotree

## Overview
CytoTree is a comprehensive R package for the analysis of multidimensional flow and mass cytometry data. It utilizes an S4 object (CYT) to manage workflows including data preprocessing, clustering (SOM), dimensionality reduction (PCA, tSNE, UMAP, Diffusion Maps), and trajectory inference using Minimum Spanning Trees (MST). It is particularly effective for time-course experiments where pseudotime estimation and intermediate state evaluation are required.

## Core Workflow

### 1. Data Import and Object Creation
The workflow begins by merging FCS files or extracting expression data into a matrix, then initializing the CYT object.

```r
library(CytoTree)

# Merge multiple FCS files
fcs.path <- system.file("extdata", package = "CytoTree")
fcs.files <- list.files(fcs.path, pattern = '.FCS$', full = TRUE)
fcs.data <- runExprsMerge(fcs.files, comp = FALSE, transformMethod = "none")

# Create CYT object
cyt <- createCYT(raw.data = fcs.data, normalization.method = "log")
```

### 2. Trajectory Construction
CytoTree uses a sequential pipeline to cluster cells and build a tree structure.

```r
# Pipeline approach using magrittr pipes
cyt <- cyt %>% 
  runCluster() %>% 
  processingCluster() %>% 
  buildTree()

# Optional: Add dimensionality reduction
cyt <- cyt %>% 
  runFastPCA() %>% 
  runTSNE() %>% 
  runUMAP()
```

### 3. Pseudotime and Analysis
For time-course data, define root and leaf nodes to calculate trajectory paths.

```r
# Identify differentially expressed genes across branches
diff.list <- runDiff(cyt)

# Define root/leaf based on cluster IDs
cyt <- defRootCells(cyt, root.cells = c(32, 26))
cyt <- runPseudotime(cyt)
cyt <- defLeafCells(cyt, leaf.cells = c(30))
cyt <- runWalk(cyt)
```

## Visualization Functions
CytoTree provides specialized plotting functions for different stages of analysis:

*   **2D Projections**: `plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"), color.by = "cluster.id")`
*   **Tree Structures**: `plotTree(cyt, color.by = "pseudotime")` or `plotPieTree(cyt)`
*   **Heatmaps**: `plotClusterHeatmap(cyt)` or `plotBranchHeatmap(cyt)`
*   **Distribution**: `plotViolin(cyt, marker = "CD45RA", color.by = "cluster.id")`
*   **Pseudotime**: `plotPseudotimeDensity(cyt)` and `plotPseudotimeTraj(cyt)`

## Tips and Best Practices
*   **Downsampling**: CytoTree automatically performs cluster-dependent downsampling during the `runCluster` and `processingCluster` steps to maintain computational efficiency while preserving rare populations.
*   **Root Selection**: Pseudotime accuracy depends heavily on the correct definition of `root.cells`. Use prior biological knowledge of the earliest developmental stage in your experiment.
*   **Marker Selection**: When creating the CYT object, ensure only relevant phenotypic markers are included in the "markers" vector to avoid noise in clustering and MST construction.

## Reference documentation
- [Quick start of CytoTree](./references/Tutorial.md)
- [Tutorial RMarkdown](./references/Tutorial.Rmd)