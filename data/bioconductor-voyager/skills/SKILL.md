---
name: bioconductor-voyager
description: The Voyager package provides a framework for exploratory spatial data analysis of transcriptomics data using spatial statistics and geometries. Use when user asks to quantify spatial autocorrelation, identify hotspots or coldspots, perform spatially-informed dimension reduction, or calculate bivariate spatial correlations.
homepage: https://bioconductor.org/packages/release/bioc/html/Voyager.html
---

# bioconductor-voyager

## Overview
The `Voyager` package provides a comprehensive framework for Exploratory Spatial Data Analysis (ESDA) within the Bioconductor ecosystem. It extends the `SpatialFeatureExperiment` (SFE) data structure—which itself inherits from `SpatialExperiment` and `SingleCellExperiment`—to provide spatial analogs to the `scater` package. `Voyager` allows users to quantify spatial autocorrelation, identify hotspots/coldspots, and perform spatially-informed dimension reduction, moving beyond simple centroid-based analysis by supporting actual tissue geometries and images.

## Core Workflow

### 1. Data Preparation
`Voyager` operates on `SpatialFeatureExperiment` objects. Ensure your data is formatted correctly and includes spatial coordinates or geometries.

```r
library(Voyager)
library(SpatialFeatureExperiment)
library(SFEData)
library(scater)

# Load example data or your own SFE object
sfe <- McKellarMuscleData()

# Pre-processing (standard scRNA-seq workflow)
sfe <- sfe[, colData(sfe)$in_tissue]
sfe <- logNormCounts(sfe)
```

### 2. Spatial Neighborhood Graphs
A spatial graph is required for most spatial statistics. `Voyager` provides wrappers to build these based on the technology (e.g., Visium) or geometry.

```r
# For Visium data
colGraph(sfe, "visium") <- findVisiumGraph(sfe)

# For other data, use general graph construction
# colGraph(sfe, "knn") <- findSpatialNeighbors(sfe, method = "knn", k = 6)
```

### 3. Univariate Spatial Statistics
Use `runUnivariate` or specific wrappers like `runMoransI` to calculate global and local statistics.

*   **Global Statistics:** Moran's I (autocorrelation), Geary's C, Correlograms.
*   **Local Statistics:** Local Moran's I, Getis-Ord Gi* (hotspot detection).

```r
features_use <- c("Myh1", "Myh2")

# Compute Moran's I (Global)
sfe <- runUnivariate(sfe, type = "moran", features = features_use, 
                     colGraphName = "visium", swap_rownames = "symbol")

# Compute Getis-Ord Gi* (Local)
sfe <- runUnivariate(sfe, type = "localG", features = features_use,
                     colGraphName = "visium", include_self = TRUE, 
                     swap_rownames = "symbol")

# Access results
# Global: rowData(sfe)
# Local: localResults(sfe, name = "localG")
```

### 4. Multivariate and Bivariate Analysis
*   **MULTISPATI PCA:** Spatially-informed PCA that maximizes both variance and spatial autocorrelation.
*   **Lee's L:** Measures spatial bivariate correlation between two features.

```r
# Spatially informed PCA
sfe <- runMultivariate(sfe, "multispati", colGraphName = "visium", 
                       subset_row = hvgs, nfposi = 10, nfnega = 10)

# Bivariate correlation (Lee's L)
lee_matrix <- calculateBivariate(sfe, "lee", features = hvgs)
```

### 5. Visualization
`Voyager` provides specialized plotting functions that handle geometries and images.

```r
# Plot gene expression with annotation geometries
plotSpatialFeature(sfe, features = "Myh1", colGeometryName = "spotPoly", 
                   annotGeometryName = "myofiber_simplified", aes_use = "color")

# Plot local results (e.g., Gi* hotspots) over a tissue image
plotLocalResult(sfe, "localG", features = "Myh1", 
                colGeometryName = "spotPoly", image_id = "lowres",
                divergent = TRUE, diverge_center = 0)

# Plot spatially informed reduced dimensions
spatialReducedDim(sfe, "multispati", ncomponents = 2, image_id = "lowres")
```

## Tips for Success
*   **Feature Naming:** Use `swap_rownames = "symbol"` in functions if your SFE object uses Ensembl IDs as primary rownames but you prefer gene symbols for analysis and plotting.
*   **Local Results:** Local statistics are stored in the `localResults` slot of the SFE object, not `colData`. Use `localResult(sfe, "type", "feature")` to retrieve them.
*   **Negative Autocorrelation:** In `MULTISPATI`, pay attention to negative eigenvalues (controlled by `nfnega`), which represent "checkerboard" patterns of spatial expression.
*   **Image Alignment:** If plotting on an image, ensure the image is correctly oriented using `mirrorImg()` or `rotateImg()` if it doesn't align with the spot geometries.

## Reference documentation
- [Overview of Voyager](./references/overview.md)
- [Overview of Voyager (Rmd)](./references/overview.Rmd)