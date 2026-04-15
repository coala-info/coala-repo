---
name: bioconductor-imcrtools
description: This tool performs spatial analysis and processing of highly multiplexed imaging data such as Imaging Mass Cytometry. Use when user asks to read segmentation outputs, perform spillover correction, construct spatial graphs, detect cellular neighborhoods, or perform neighborhood permutation testing for cell-cell interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/imcRtools.html
---

# bioconductor-imcrtools

name: bioconductor-imcrtools
description: Analysis of Imaging Mass Cytometry (IMC) and highly multiplexed imaging data. Use this skill to read segmentation outputs (steinbock, CellProfiler), perform spillover correction, construct spatial graphs, detect cellular neighborhoods/communities, and perform neighborhood permutation testing for cell-cell interactions.

# bioconductor-imcrtools

## Overview
The `imcRtools` package is designed for the processing and spatial analysis of highly multiplexed imaging data, particularly Imaging Mass Cytometry (IMC). It bridges the gap between image segmentation pipelines (like steinbock or CellProfiler) and downstream single-cell analysis in R using `SpatialExperiment` or `SingleCellExperiment` objects. Key capabilities include spillover compensation, spatial graph construction, neighborhood aggregation, and statistical testing of spatial relationships.

## Core Workflows

### 1. Data Import
Load single-cell data and metadata from common segmentation pipelines.

```r
library(imcRtools)

# From steinbock output
spe <- read_steinbock(path = "path/to/steinbock_folder")

# From CellProfiler output
spe <- read_cpout(path = "path/to/cpout_folder", 
                  graph_file = "Object_relationships.csv")

# From raw .txt files (Hyperion) into CytoImageList
images <- readImagefromTXT(path = "path/to/raw_txt")
```

### 2. Spillover Correction
Correct for signal leakage between adjacent mass channels.

```r
# 1. Read single-metal spots
sce_spill <- readSCEfromTXT(path = "path/to/spillover_txts")

# 2. QC and Filter pixels (using CATALYST)
library(CATALYST)
sce_spill <- assignPrelim(sce_spill, bc_key = as.numeric(unique(sce_spill$sample_mass)))
sce_spill <- applyCutoffs(estCutoffs(sce_spill))
sce_spill <- filterPixels(sce_spill)

# 3. Compute and apply matrix
sce_spill <- computeSpillmat(sce_spill)
sm <- metadata(sce_spill)$spillover_matrix
# Apply to main data using CATALYST::compCytof
```

### 3. Spatial Graph Construction
Build graphs where cells are nodes and spatial proximity defines edges.

```r
# Expansion: radius-based (e.g., 20um)
spe <- buildSpatialGraph(spe, img_id = "sample_id", type = "expansion", threshold = 20)

# KNN: k-nearest neighbors
spe <- buildSpatialGraph(spe, img_id = "sample_id", type = "knn", k = 5)

# Delaunay triangulation
spe <- buildSpatialGraph(spe, img_id = "sample_id", type = "delaunay")
```

### 4. Spatial Analysis & Clustering
Identify cellular neighborhoods (CN) and spatial contexts (SC).

```r
# Aggregate neighbor phenotypes
spe <- aggregateNeighbors(spe, colPairName = "knn_interaction_graph", 
                          aggregate_by = "metadata", count_by = "celltype")

# Detect Spatial Context (SC) - higher level organization
spe <- detectSpatialContext(spe, entry = "aggregatedNeighborhood", threshold = 0.9)

# Detect Spatial Communities (Louvain/Walktrap)
spe <- detectCommunity(spe, colPairName = "expansion_interaction_graph")
```

### 5. Interaction Testing
Test if cell types interact more (attraction) or less (avoidance) than expected by chance.

```r
# Permutation testing
out <- testInteractions(spe, 
                        group_by = "sample_id", 
                        label = "celltype", 
                        method = "classic", 
                        colPairName = "knn_interaction_graph",
                        iter = 1000)

# Visualize results
plotInteractions(out, spe, group_by = "sample_id", label = "celltype")
```

### 6. Visualization
Visualize cells and graphs in spatial coordinates.

```r
plotSpatial(spe, 
            img_id = "sample_id", 
            node_color_by = "celltype", 
            draw_edges = TRUE, 
            colPairName = "knn_interaction_graph")
```

## Tips and Best Practices
- **Object Types**: Functions primarily return `SpatialExperiment` objects. Access spatial coordinates via `spatialCoords(spe)`.
- **Border Cells**: Use `findBorderCells()` to flag cells near the edge of an image to avoid edge-effect artifacts in spatial statistics.
- **Patch Detection**: Use `patchDetection()` to identify contiguous regions of specific cell types (e.g., tumor nests).
- **Distances**: Use `distToCells()` to calculate the distance of every cell to the nearest cell of a specific class (e.g., distance of T-cells to the nearest tumor patch).

## Reference documentation
- [Tools for IMC data analysis](./references/imcRtools.Rmd)
- [imcRtools Vignette](./references/imcRtools.md)