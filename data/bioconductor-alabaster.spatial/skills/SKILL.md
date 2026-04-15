---
name: bioconductor-alabaster.spatial
description: The alabaster.spatial package provides a framework for saving and loading SpatialExperiment objects to and from disk while preserving all metadata and image data. Use when user asks to save spatial omics data, load SpatialExperiment objects from file, or serialize spatial coordinates and images for the alabaster ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.spatial.html
---

# bioconductor-alabaster.spatial

## Overview

The `alabaster.spatial` package is part of the **alabaster** ecosystem, designed to provide a robust framework for saving and loading Bioconductor objects. Specifically, this package extends the framework to handle `SpatialExperiment` objects. It ensures that all components of a spatial dataset—including the count matrix (assays), row metadata (rowData), column metadata (colData), spatial coordinates, and associated image data—are correctly serialized to disk and can be reconstructed perfectly.

## Core Workflow

The package relies on the generic `saveObject` and `readObject` functions from the `alabaster.base` package, with specialized methods implemented for spatial classes.

### Saving a SpatialExperiment

To save a `SpatialExperiment` object, specify the object and a destination directory.

```r
library(SpatialExperiment)
library(alabaster.spatial)

# Assuming 'spe' is your SpatialExperiment object
target_dir <- "path/to/save_directory"
saveObject(spe, target_dir)
```

The resulting directory will contain:
- `OBJECT`: A file identifying the object type.
- `assays/`: The experimental data (e.g., HDF5 format).
- `coordinates/`: Spatial coordinates stored as an array.
- `images/`: Image files (e.g., PNG) and a mapping file.
- `column_data/` and `row_data/`: Metadata for spots/cells and features.

### Loading a SpatialExperiment

To load a previously saved object, simply point `readObject` to the directory.

```r
library(alabaster.spatial)

# Load the object back into R
spe_imported <- readObject("path/to/save_directory")

# Verify spatial data
spatialCoords(spe_imported)
imgData(spe_imported)
```

## Key Considerations

- **Unique Column Names**: It is highly recommended to ensure `colnames(spe)` are unique before saving to avoid issues during reconstruction.
- **Image Handling**: The package automatically handles the serialization of `imgData`. When loaded, images are reconstructed as `SpatialImage` objects within the `SpatialExperiment`.
- **Integration**: This package works seamlessly with other `alabaster` extensions. For example, if your `SpatialExperiment` contains `reducedDims`, these will be handled by `alabaster.sce` logic automatically during the `saveObject` call.
- **Schema Compliance**: The on-disk format follows the official [BiocObjectSchema](https://artifactdb.github.io/BiocObjectSchemas/html/spatial_experiment/v1.html) for spatial experiments, ensuring compatibility with other languages (like Python via `dolomite-spatial`).

## Reference documentation

- [Save/load spatial omics data to/from file](./references/userguide.md)