---
name: bioconductor-scider
description: The scider package models global cell density in spatial transcriptomics data to identify high-density regions and analyze spatial relationships between cell types. Use when user asks to calculate grid-based cell densities, identify regions of interest, test for spatial correlations between cell types, or perform cell-based contour analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/scider.html
---


# bioconductor-scider

## Overview
The `scider` package provides a framework for modeling the global density of cells in spatial transcriptomics data. It operates on `SpatialExperiment` objects and enables researchers to move beyond individual cell locations to a grid-based density perspective. Key capabilities include identifying high-density regions (ROIs), testing for spatial correlations between cell types, and performing cell-based analysis using density-driven contours.

## Core Workflow

### 1. Data Preparation and Visualization
Load the package and your `SpatialExperiment` data. Use `plotSpatial` to inspect the initial distribution of cell types.

```r
library(scider)
library(SpatialExperiment)

# Load data (example uses built-in Xenium subset)
data("xenium_bc_spe")

# Visualize cell types
plotSpatial(spe, group.by = "cell_type", pt.alpha = 0.8)
```

### 2. Grid-Based Density Calculation
The `gridDensity` function calculates the density for each cell type across a grid. Results are stored in `metadata(spe)$grid_density`.

```r
spe <- gridDensity(spe)

# Visualize overall density
plotDensity(spe)

# Visualize density of a specific Cell of Interest (COI)
plotDensity(spe, coi = "Fibroblasts")
```

### 3. Identifying Regions of Interest (ROIs)
ROIs can be detected automatically based on density thresholds or selected manually.

**Algorithmic Detection:**
```r
spe <- findROI(spe, coi = "Fibroblasts")
plotROI(spe, roi = "Fibroblasts")
```

**Manual Selection:**
Use `selectRegion` to open an interactive Shiny gadget. After selecting points and clicking "Export", the result is saved to `sel_region`.
```r
selectRegion(metadata(spe)$grid_density, x.col = "x_grid", y.col = "y_grid")
spe <- postSelRegion(spe, sel_region = sel_region)
```

### 4. Testing Cell-Type Relationships
Use `corDensity` to test the correlation between cell type densities within ROIs or across the whole slide.

```r
results <- corDensity(spe, roi = "Fibroblasts")

# View overall correlations
results$overall

# Visualize correlations
plotDensCor(spe, celltype1 = "Breast cancer", celltype2 = "Fibroblasts")
plotCorHeatmap(results$ROI)
```

### 5. Cell-Based Contour Analysis
To study how cell behavior or composition changes relative to the density of a specific cell type, use the contour workflow.

```r
# 1. Identify density contours (e.g., deciles of fibroblast density)
spe <- getContour(spe, coi = "Fibroblasts", equal.cell = TRUE)

# 2. Assign individual cells to these contours
spe <- allocateCells(spe)

# 3. Visualize results
plotContour(spe, coi = "Fibroblasts")
plotSpatial(spe, group.by = "fibroblasts_contour")
plotCellCompo(spe, contour = "Fibroblasts")
```

## Tips for Success
- **Object Compatibility**: Ensure your input is a `SpatialExperiment` object with valid `spatialCoords`.
- **COI Naming**: When specifying `coi`, use the exact string found in your cell type annotation column.
- **ROI Variation**: `corDensity` is particularly powerful because it can account for ROI-specific variation using cubic splines or linear fits, providing a more robust global correlation measure than simple point-wise correlations.
- **Interactive Selection**: If `selectRegion` does not open a window, ensure your R session supports interactive graphics (e.g., RStudio).

## Reference documentation
- [scider User Guide](./references/scider_userGuide.md)