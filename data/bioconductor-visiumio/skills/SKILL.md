---
name: bioconductor-visiumio
description: This package imports 10X Genomics Visium and Visium HD spatial transcriptomics data into Bioconductor SpatialExperiment objects. Use when user asks to import Space Ranger outputs, load Visium HD datasets by bin size, or merge multiple spatial transcriptomics samples into a single object.
homepage: https://bioconductor.org/packages/release/bioc/html/VisiumIO.html
---

# bioconductor-visiumio

## Overview

The `VisiumIO` package facilitates the import of 10X Genomics Visium spatial transcriptomics data into the Bioconductor ecosystem. It primarily converts raw or filtered outputs from the Space Ranger pipeline into `SpatialExperiment` objects, which integrate count matrices, row/column metadata, and spatial coordinates/images. It supports both standard Visium and high-resolution Visium HD datasets.

## Installation and Loading

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("VisiumIO")

library(VisiumIO)
library(SpatialExperiment)
```

## Importing Single Samples (Standard Visium)

Use the `TENxVisium` class to represent a single sample. The constructor points to the `outs` directory of a Space Ranger run.

```r
# Define path to the 'outs' folder
outs_path <- "path/to/sample/outs"

# Create the representation object
vis_obj <- TENxVisium(
    spacerangerOut = outs_path,
    processing = "raw",      # or "filtered"
    images = "lowres",       # options: "lowres", "hires", "detected", "aligned"
    sample_id = "sample01"
)

# Import into SpatialExperiment
spe <- import(vis_obj)
```

## Importing Multiple Samples

Use `TENxVisiumList` to load multiple samples into a single merged `SpatialExperiment` object.

```r
# Vector of paths to sample directories (each containing an 'outs' folder)
sample_dirs <- c("path/to/sample1", "path/to/sample2")

# Create the list object
vlist <- TENxVisiumList(
    sampleFolders = sample_dirs,
    sample_ids = c("S1", "S2"),
    processing = "filtered",
    images = "lowres"
)

# Import and merge
spe_merged <- import(vlist)
```

## Importing Visium HD

Visium HD data is organized by bin size (e.g., 2um, 8um, 16um). Use `TENxVisiumHD` to target specific resolutions.

```r
# Import a specific bin size
hd_obj <- TENxVisiumHD(
    spacerangerOut = "path/to/Visium_HD_Output",
    bin_size = "002",         # e.g., "002", "008", "016"
    processing = "filtered",
    format = "mtx"            # or "h5" for HDF5 format
)

spe_hd <- import(hd_obj)
```

## Supported Formats and Classes

The package uses `TENxIO` under the hood to handle various file extensions:
- **.h5**: Imported via `TENxH5` as a `SingleCellExperiment` with `TENxMatrix`.
- **.mtx / .mtx.gz**: Imported via `TENxMTX` as a `SummarizedExperiment`.
- **.tar.gz**: Imported via `TENxFileList`.
- **.parquet**: Used for Visium HD spatial coordinates.

## Tips for Success

- **Directory Structure**: Ensure the `spacerangerOut` path points to a directory containing an `outs/` folder. The package expects the standard Space Ranger subfolder structure (`spatial/` and `*_feature_bc_matrix/`).
- **Image Selection**: If multiple images are available, you can specify them as a vector in the `images` argument.
- **Coordinate Names**: By default, the package looks for `pxl_col_in_fullres` and `pxl_row_in_fullres`. If your CSV uses different headers, adjust the `spatialCoordsNames` argument in the constructor.

## Reference documentation

- [VisiumIO](./references/VisiumIO.md)