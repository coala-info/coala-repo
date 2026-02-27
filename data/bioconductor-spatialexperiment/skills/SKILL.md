---
name: bioconductor-spatialexperiment
description: This package provides an S4 class for managing and analyzing spatial transcriptomics data from spot-based and molecule-based platforms. Use when user asks to create SpatialExperiment objects, manipulate spatial coordinates, manage image metadata, or perform subsetting and merging of spatial -omics datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html
---


# bioconductor-spatialexperiment

name: bioconductor-spatialexperiment
description: Specialized R/Bioconductor package for handling spatial -omics data. Use this skill when you need to create, manipulate, or analyze SpatialExperiment (SPE) objects, including spot-based (10x Genomics Visium) and molecule-based (seqFISH, MERFISH) data. It provides guidance on managing spatial coordinates, image data (imgData), and integrating expression assays with spatial metadata.

## Overview

The `SpatialExperiment` package provides an S4 class that extends `SingleCellExperiment` to specifically support spatial transcriptomics. It organizes data into five main components:
1. **Assays**: Expression counts (e.g., `counts`, `molecules`).
2. **rowData**: Feature metadata (genes).
3. **colData**: Observation metadata (cells/spots), including `sample_id`.
4. **spatialCoords**: Numeric matrix of spatial coordinates (x, y).
5. **imgData**: Image metadata and `SpatialImage` objects for visualization.

## Core Workflows

### 1. Object Construction

**Manual Construction:**
```r
library(SpatialExperiment)
spe <- SpatialExperiment(
    assays = list(counts = count_matrix),
    colData = col_data_df,
    spatialCoordsNames = c("x", "y"),
    sample_id = "sample_01"
)
```

**10x Genomics Visium (Automated):**
The preferred way to load Visium data is using the `VisiumIO` package:
```r
library(VisiumIO)
vl <- TENxVisiumList(sampleFolders = "path/to/outs", sample_ids = "sample01")
spe <- import(vl)
```

### 2. Accessing Spatial Data

*   **Coordinates**: Use `spatialCoords(spe)` to get the matrix or `spatialCoordsNames(spe)` to see column names.
*   **Images**: Use `imgData(spe)` to see image metadata. Use `getImg(spe)` to retrieve a specific `SpatialImage` object.
*   **Raster Data**: `imgRaster(spe)` extracts the RGB raster for plotting.

### 3. Molecule-based Data (e.g., seqFISH)

For molecule-based platforms, use `BumpyMatrix` to store individual molecule coordinates within the `molecules` assay:
```r
library(BumpyMatrix)
# df contains gene, cell, x, y
mol <- splitAsBumpyMatrix(df[, c("x", "y")], row = df$gene, col = df$cell)
spe <- SpatialExperiment(assays = list(counts = count_mat, molecules = mol))
```

### 4. Image Manipulation

You can transform images directly within the SPE object:
*   **Rotate**: `spe <- rotateImg(spe, degrees = 90)` (positive is counter-clockwise).
*   **Mirror**: `spe <- mirrorImg(spe, axis = "h")` (use "h" for horizontal or "v" for vertical).
*   **Add/Remove**: Use `addImg()` and `rmvImg()` to manage multiple resolutions or staining types.

### 5. Common Operations

*   **Subsetting**: SPE objects subset like standard matrices: `spe[, spe$in_tissue == 1]`. This automatically synchronizes `spatialCoords` and `imgData`.
*   **Merging**: Use `cbind(spe1, spe2)` to combine samples. Ensure `sample_id` values are unique; if not, the function will append indices automatically.
*   **Sample IDs**: The `sample_id` column in `colData` is protected. To change it, you must provide a mapping that maintains the number of unique samples.

## Tips for Success

*   **Coordinate Precision**: When manually constructing, ensure `spatialCoords` is a numeric matrix. If coordinates are in `colData`, use `spatialCoordsNames` to "promote" them.
*   **Memory Management**: `StoredSpatialImage` objects only load the image into memory when `imgRaster()` or `plot()` is called, which is efficient for large datasets.
*   **Sample ID Consistency**: Always check that `imgData(spe)$sample_id` matches the levels in `spe$sample_id`.

## Reference documentation

- [SpatialExperiment](./references/SpatialExperiment.md)