---
name: bioconductor-tomoseqr
description: The tomoseqr package reconstructs 3D gene expression volumes from 1D Tomo-seq data using iterative proportional fitting. Use when user asks to identify axial peak genes, create 3D tissue masks, reconstruct spatial expression patterns from orthogonal axes, or visualize 3D gene volumes.
homepage: https://bioconductor.org/packages/release/bioc/html/tomoseqr.html
---


# bioconductor-tomoseqr

## Overview

The `tomoseqr` package implements iterative proportional fitting to reconstruct 3D gene expression volumes from 1D Tomo-seq data (sequenced cryosections). It allows researchers to transform linear expression profiles from three orthogonal axes into a unified 3D spatial model, providing tools for data preparation, mask creation, 3D reconstruction, and interactive visualization.

## Data Preparation

### Tomo-seq Expression Data
You must provide three data frames (one for each axis: x, y, z) following these requirements:
- **Format**: Data frame with a header.
- **Columns**: First column is `geneID` (character); subsequent columns are numeric expression levels.
- **Order**: Sections must be ordered from left to right (low to high intercept) for each axis.
- **Consistency**: Gene IDs must match across all three data frames.

```r
library(tomoseqr)
# Load example data
data(testx, testy, testz)
```

### Mask Data
A mask is a 3D matrix (array) representing the sample's physical shape.
- **Values**: `1` if the voxel is part of the sample, `0` otherwise.
- **Creation**: Use the built-in Shiny tool to draw the sample shape manually.

```r
# Launch the mask creation interface
masker() 
# Follow UI instructions to define sections and download the .rda file
```

## 3D Reconstruction Workflow

The core function `estimate3dExpressions` performs the iterative proportional fitting to estimate the spatial distribution of specific genes.

```r
# Reconstruct 3D patterns for specific genes
tomoObj <- estimate3dExpressions(
    testx, 
    testy, 
    testz, 
    mask = mask, 
    query = c("gene1", "gene2")
)
```

## Visualization and Analysis

### Interactive Viewer
The package includes a Shiny-based `imageViewer` to explore the reconstructed 3D volumes through 2D slices or 3D point clouds.

```r
# Launch interactive visualization
imageViewer(tomoObj)
```

### Finding Axial Peak Genes
To identify genes that show significant spatial variation (peaks) along a specific axis, use `findAxialGenes`. This is useful for selecting candidates for 3D reconstruction.

```r
# Detect genes with significant differences between sections
axialGeneTable <- findAxialGenes(testx)

# Columns in result:
# - max: Maximum expression level
# - meanExeptMax: Average expression excluding the peak
# - isPeakGene: Index of the section containing the peak
```

## Typical Workflow Summary
1. **Identify Candidates**: Run `findAxialGenes` on x, y, and z data to find genes with localized expression.
2. **Define Geometry**: Use `masker()` to create a 3D mask representing the tissue shape.
3. **Reconstruct**: Run `estimate3dExpressions` using the three axis data frames, the mask, and the selected gene list.
4. **Inspect**: Use `imageViewer()` to validate the spatial patterns and export plots.

## Reference documentation
- [R Package for Analyzing Tomo-seq Data](./references/tomoseqr.md)