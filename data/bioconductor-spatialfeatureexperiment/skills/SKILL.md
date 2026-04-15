---
name: bioconductor-spatialfeatureexperiment
description: This tool provides an S4 class that integrates spatial transcriptomics data with vector geometries and spatial neighborhood graphs for advanced spatial analysis. Use when user asks to create or manipulate SpatialFeatureExperiment objects, manage cell and tissue geometries, construct spatial neighborhood graphs, or perform geometric operations on Visium, MERFISH, Xenium, and CosMX datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialFeatureExperiment.html
---

# bioconductor-spatialfeatureexperiment

name: bioconductor-spatialfeatureexperiment
description: Expert guidance for the SpatialFeatureExperiment (SFE) R package. Use this skill to create, manipulate, and analyze SFE objects which integrate spatial transcriptomics data with geometric features (sf) and spatial neighborhood graphs (spdep). Use for tasks involving Visium, MERFISH, Xenium, or CosMX data, including geometry operations (cropping, transforming), spatial graph construction, and managing multi-sample spatial datasets.

# bioconductor-spatialfeatureexperiment

## Overview

`SpatialFeatureExperiment` (SFE) is an S4 class that extends `SpatialExperiment` (SPE) by integrating vector geometries via the `sf` package. It allows for the storage and manipulation of:
- **Geometries**: Polygons (cells, nuclei, tissue boundaries) and points (transcript spots).
- **Spatial Graphs**: Neighborhood relationships stored as `listw` objects for spatial statistics.
- **Local Results**: Storage for univariate/bivariate local spatial analysis (e.g., Local Moran's I).

## Core Workflows

### 1. Object Construction
SFE provides specialized readers for major spatial platforms that automatically handle geometry creation.

```r
library(SpatialFeatureExperiment)

# 10X Visium
sfe <- read10xVisiumSFE(dirs = "path/to/outs", sample_id = "sample01", type = "sparse", unit = "micron")

# Vizgen MERFISH
sfe_mer <- readVizgen(dir_use, z = 3L, add_molecules = TRUE)

# 10X Xenium
sfe_xen <- readXenium(dir_use, add_molecules = TRUE)

# Coercion from SpatialExperiment
sfe <- toSpatialFeatureExperiment(spe_object)
```

### 2. Managing Geometries
Geometries are categorized by their relationship to the count matrix.

- **colGeometries**: Associated with columns (cells/spots). Access with `colGeometry(sfe, "name")`.
- **rowGeometries**: Associated with rows (genes, e.g., transcript spots). Access with `rowGeometry(sfe, "name")`.
- **annotGeometries**: Independent geometries (tissue boundaries, histological regions). Access with `annotGeometry(sfe, "name")`.

Common shorthands: `spotPoly(sfe)`, `txSpots(sfe)`, `tissueBoundary(sfe)`, `cellSeg(sfe)`, `nucSeg(sfe)`.

### 3. Spatial Neighborhood Graphs
SFE uses `spdep` style `listw` objects.

```r
# Find neighbors using triangulation
colGraph(sfe, "tri") <- findSpatialNeighbors(sfe, MARGIN = 2, method = "tri2nb")

# Visium specific hexagonal graph
colGraph(sfe, "visium") <- findVisiumGraph(sfe)

# Accessing graphs
g <- colGraph(sfe, "visium")
```

### 4. Geometric Operations
SFE supports spatial subsetting and transformations that keep images and geometries synchronized.

```r
# Crop SFE object to a tissue boundary or bounding box
sfe_subset <- crop(sfe, y = tissueBoundary(sfe))

# Geometric predicates (e.g., which spots are in tissue?)
colData(sfe)$in_tissue <- annotPred(sfe, colGeometryName = "spotPoly", annotGeometryName = "tissueBoundary")

# Global transformations
sfe_mirrored <- mirror(sfe, direction = "vertical")
sfe_transposed <- transpose(sfe)
```

### 5. Multi-sample Handling
When an SFE object contains multiple samples (via `cbind`), the `sample_id` argument becomes mandatory for most geometry and graph functions.

```r
# Get geometries for a specific sample
spots <- colGeometry(sfe_combined, "spotPoly", sample_id = "sample02")

# Change sample IDs across all internal structures
sfe_combined <- changeSampleIDs(sfe_combined, replacement = c(old_id = "new_id"))
```

## Tips for Success
- **Units**: Use `unit(sfe)` to check coordinate units. SFE does not automatically convert units but stores the metadata string (e.g., "micron").
- **Images**: SFE uses `terra::SpatRaster` for images. They are lazily loaded and downsampled during plotting to save memory.
- **Arrow Dependency**: For Xenium and MERFISH, ensure the `arrow` R package is installed for fast Parquet processing.
- **Spatial Statistics**: Because graphs are `listw` objects, you can pass them directly to `spdep` functions like `localmoran()`.

## Reference documentation
- [Introduction to the SpatialFeatureExperiment class](./references/SFE.md)
- [SFE Vignette Source](./references/SFE.Rmd)