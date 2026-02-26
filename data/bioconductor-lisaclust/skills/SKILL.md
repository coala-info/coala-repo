---
name: bioconductor-lisaclust
description: This tool identifies and visualizes regions of cell type colocalization in multiplexed imaging data using Local Indicators of Spatial Association curves. Use when user asks to identify tissue compartments, cluster spatial microenvironments, or visualize cell type associations in spatial proteomics and transcriptomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/lisaClust.html
---


# bioconductor-lisaclust

name: bioconductor-lisaclust
description: Identify and visualize regions of cell type colocalization in multiplexed imaging data using Local Indicators of Spatial Association (LISA) curves. Use this skill when analyzing spatial proteomics or transcriptomics data (e.g., MIBI, IMC, CODEX) to define tissue compartments or microenvironments based on the spatial distribution of multiple cell types simultaneously.

## Overview

`lisaClust` provides a framework for unsupervised clustering of Local Indicators of Spatial Association (LISA) functions. It transforms spatial point patterns of cell types into "LISA curves"—local summaries of L-functions—which are then clustered to identify consistent spatial organizations (regions). This approach is particularly useful for identifying tissue compartments (e.g., tumor vs. stroma) or complex immune microenvironments in high-parameter spatial cytometry data.

## Core Workflow

### 1. Data Preparation
Data should be stored in a `SingleCellExperiment` (SCE) or `SpatialExperiment` object. At minimum, `colData` must contain:
- Spatial coordinates (e.g., `x`, `y`)
- Cell type labels
- Image/Sample identifiers (if multiple images are present)

```r
library(lisaClust)
library(SingleCellExperiment)

# Example: Creating SCE from a data frame
# cells contains x, y, cellType, imageID
sce <- SingleCellExperiment(colData = cells)
```

### 2. Identifying Regions with lisaClust()
The `lisaClust()` function is a convenience wrapper that calculates LISA curves and performs k-means clustering in one step.

```r
# k: number of spatial regions to identify
sce <- lisaClust(sce, 
                 k = 5, 
                 cellType = "cellType", 
                 imageID = "imageID")

# Results are stored in colData(sce)$region
head(colData(sce)$region)
```

### 3. Visualizing Regions
Use `hatchingPlot()` to visualize the identified regions alongside individual cell types. Regions are indicated by different hatching patterns.

```r
# Plot specific images
hatchingPlot(sce, useImages = c("sample1", "sample2"))

# For large datasets, adjust 'nbp' (number of grid points) for speed/resolution
hatchingPlot(sce, nbp = 300)
```

### 4. Interpreting Regions
Use `regionMap()` to create a heatmap or bubble plot showing the enrichment of cell types within each identified region.

```r
# Identify which cell types characterize which regions
regionMap(sce, type = "bubble")
```

## Advanced Usage

### Custom Clustering
If you prefer a clustering method other than k-means (e.g., SOM, Hierarchical), you can generate the LISA curves manually.

```r
# 1. Generate LISA curves
# Rs: radii over which to calculate spatial association
lisaCurves <- lisa(sce, Rs = c(20, 50, 100))

# 2. Run custom clustering (e.g., k-means manually)
kM <- kmeans(lisaCurves, centers = 3)

# 3. Assign back to SCE
colData(sce)$custom_region <- paste0("region_", kM$cluster)
```

## Tips and Best Practices
- **Radii Selection**: When using `lisa()`, the `Rs` parameter defines the spatial scales. Choose radii that reflect the biological scale of interest (e.g., immediate neighbors vs. broader tissue architecture).
- **Scaling**: `lisaClust` is designed for multiplexed data. It handles many cell types simultaneously, making it more powerful than simple pairwise interaction analysis for defining "neighborhoods."
- **Integration**: The output regions can be used as covariates in downstream differential expression or survival analysis to see if specific microenvironments correlate with clinical outcomes.

## Reference documentation
- [Introduction to Clustering of Local Indicators of Spatial Assocation (LISA) curves](./references/lisaClust.md)