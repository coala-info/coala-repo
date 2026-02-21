---
name: bioconductor-flowsom
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/FlowSOM.html
---

# bioconductor-flowsom

name: bioconductor-flowsom
description: Expert guidance for analyzing high-dimensional cytometry data using the FlowSOM R package. Use this skill when you need to perform unsupervised clustering, visualization (Self-Organizing Maps and Minimal Spanning Trees), and metaclustering on flow or mass cytometry data (.fcs files).

# bioconductor-flowsom

## Overview
FlowSOM is a Bioconductor package designed to analyze high-dimensional cytometry data using a Self-Organizing Map (SOM) followed by a Minimal Spanning Tree (MST) and metaclustering. It is highly efficient for identifying cell populations and visualizing marker expression patterns across clusters.

## Core Workflow

### 1. Data Preprocessing
Before running FlowSOM, data should be compensated and transformed. For flow cytometry, use `logicleTransform`; for CyTOF, use `arcsinh`.

```r
library(flowCore)
library(FlowSOM)

# Load data
ff <- read.FCS("path/to/file.fcs")

# Compensation (if SPILL matrix exists)
comp <- keyword(ff)[["SPILL"]]
ff <- compensate(ff, comp)

# Transformation
trans <- estimateLogicle(ff, channels = colnames(comp))
ff <- transform(ff, trans)
```

### 2. The Wrapper Function (The Easy Way)
The `FlowSOM` function combines reading, SOM building, MST building, and metaclustering into one call.

```r
set.seed(42)
fSOM <- FlowSOM(ff,
                compensate = FALSE, transform = FALSE, scale = TRUE,
                colsToUse = c("CD3", "CD4", "CD8", "CD19"), # Markers for clustering
                xdim = 10, ydim = 10,                       # SOM grid size
                nClus = 10)                                 # Number of metaclusters
```

### 3. Step-by-Step Implementation
For more control, execute the pipeline sequentially:

*   **Read Input:** `ReadInput(ff, compensate = TRUE, transform = TRUE, scale = TRUE)`
*   **Build SOM:** `BuildSOM(fSOM, colsToUse = ...)`
*   **Build MST:** `BuildMST(fSOM)`
*   **Metaclustering:** `metaClustering_consensus(fSOM$map$codes, k = 10)`

### 4. Visualization
FlowSOM provides several ways to visualize the resulting clusters:

*   **Star Plots:** Shows marker expression for every node.
    `PlotStars(fSOM, backgroundValues = fSOM$metaclustering)`
*   **Marker Plots:** Shows the expression of a single marker across the tree.
    `PlotMarker(fSOM, "CD4")`
*   **Pie Plots:** If manual gating is available, compare clusters to gates.
    `PlotPies(fSOM, cellTypes = manual_labels)`
*   **2D Scatters:** View specific nodes in traditional biaxial plots.
    `Plot2DScatters(fSOM, channelpairs = list(c("CD4", "CD8")), clusters = list(c(1, 2)))`

## Extracting Results
To map the clustering results back to individual cells:

```r
# Get cluster assignment (1 to xdim*ydim)
cluster_labels <- GetClusters(fSOM)

# Get metacluster assignment
metacluster_labels <- GetMetaclusters(fSOM)
```

## Group Comparisons
To compare different experimental groups (e.g., Stimulated vs. Unstimulated):

1.  Build a single FlowSOM tree on a concatenated set or representative sample.
2.  Use `GetFeatures` to calculate percentages or MFI per file.
3.  Use `GroupStats` to calculate fold changes and p-values between groups.
4.  Visualize differences using `PlotVariable` or by coloring the background of `PlotStars` based on fold change.

## Tips for Success
*   **Seed:** Always use `set.seed()` before running `FlowSOM` or `BuildSOM` to ensure reproducibility.
*   **Columns:** Only include lineage markers in `colsToUse`. Exclude "state" markers (e.g., cytokines, phosphorylation) if you want to see how those markers behave across defined populations.
*   **Grid Size:** A 10x10 grid (100 nodes) is standard for most datasets. Increase for very high-dimensional or complex data.
*   **Scaling:** Scaling (`scale = TRUE`) is generally recommended to ensure all markers contribute equally to the clustering distance.

## Reference documentation
- [FlowSOM](./references/FlowSOM.md)