---
name: bioconductor-spaniel
description: Spaniel visualizes spatial transcriptomics data by overlaying gene expression, quality control metrics, and clusters onto histological tissue images. Use when user asks to import 10X Visium data into a SingleCellExperiment object, visualize spatial gene expression, perform spatial quality control, or map clusters onto tissue images.
homepage: https://bioconductor.org/packages/release/bioc/html/Spaniel.html
---

# bioconductor-spaniel

## Overview

Spaniel is a Bioconductor package designed for the visualization of Spatial Transcriptomics experiments. It bridges the gap between transcriptomic data and histology by allowing users to overlay metrics (counts, gene expression, clusters) directly onto the tissue image. It utilizes the `SingleCellExperiment` (SCE) framework, making it compatible with standard single-cell analysis workflows in Bioconductor (e.g., `scater`, `scran`).

## Core Workflows

### 1. Data Import (10X Visium)
Spaniel simplifies the loading of 10X Genomics Visium data processed via the Space Ranger pipeline.

```r
library(Spaniel)

# Path to the 'outs' directory from Space Ranger
pathToTenXOuts <- "path/to/spaceranger/outs"

# Create SingleCellExperiment object with image data
sce <- createVisiumSCE(tenXDir = pathToTenXOuts, resolution = "Low")

# Access spatial metadata
colData(sce)[, c("Barcode", "pixel_x", "pixel_y")]
metadata(sce)$ImgDims
```

### 2. Spatial Quality Control
Visualizing QC metrics on the tissue image helps identify experimental artifacts or background contamination.

```r
# Define a filter (e.g., spots with at least 1 detected gene)
filter_pass <- sce$detected > 0

# Plot QC metric (Number of Genes) with filter overlay
spanielPlot(object = sce,
            plotType = "NoGenes",
            showFilter = filter_pass,
            techType = "Visium",
            ptSizeMax = 3)

# Subset the object to keep only passing spots
sce <- sce[, filter_pass]
```

### 3. Visualizing Gene Expression
After normalization (typically using `scater::logNormCounts`), specific genes can be mapped to the tissue.

```r
library(scater)
sce <- logNormCounts(sce)

# Plot expression of a specific gene
spanielPlot(object = sce,
            plotType = "Gene",
            gene = "ENSMUSG00000024843",
            techType = "Visium",
            ptSizeMax = 3)
```

### 4. Spatial Clustering Visualization
Clusters derived from standard single-cell pipelines (like SNN graphing) can be projected back onto the histology.

```r
# Assuming clusters are stored in colData(sce)$clust
spanielPlot(object = sce,
            plotType = "Cluster",
            clusterRes = "clust",
            techType = "Visium",
            ptSizeMax = 2,
            customTitle = "Spatial Clusters")
```

## Key Functions Reference

- `createVisiumSCE()`: Imports Space Ranger output into an SCE object.
- `spanielPlot()`: The primary visualization engine. 
    - `plotType`: Can be "NoGenes" (QC), "Gene" (Expression), or "Cluster".
    - `showFilter`: A logical vector to highlight specific spots.
    - `techType`: Set to "Visium" for 10X data.
    - `ptSizeMax`: Adjusts the size of the spots on the image.

## Tips for Success
- **Image Resolution**: When using `createVisiumSCE`, ensure the `resolution` parameter ("Low" or "High") matches the available files in the 10X directory.
- **Normalization**: Spaniel does not perform normalization itself; use `scater` or `scran` before plotting gene expression.
- **Coordinate System**: Spaniel stores pixel coordinates in `colData` and the image as a `grob` in `metadata(sce)$Grob`.

## Reference documentation
- [Spaniel 10X Visium](./references/spaniel-vignette-tenX-import.md)