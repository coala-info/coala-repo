---
name: bioconductor-cytomapper
description: This tool visualizes highly multiplexed imaging cytometry data by handling multi-channel images and segmentation masks. Use when user asks to visualize pixel-level intensities, map single-cell metadata onto segmentation masks, or manage CytoImageList objects for spatial analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/cytomapper.html
---

# bioconductor-cytomapper

name: bioconductor-cytomapper
description: Visualization of highly multiplexed imaging cytometry data (e.g., IMC, MIBI, t-CyCIF). Use this skill to handle CytoImageList objects, display pixel-level intensities across multiple channels, and visualize cell-level metadata or expression on segmentation masks. It is particularly useful for spatial analysis workflows involving SingleCellExperiment objects and image data.

# bioconductor-cytomapper

## Overview
The `cytomapper` package is designed for the visualization and analysis of multiplexed imaging data. It introduces the `CytoImageList` class to manage multi-channel images and segmentation masks. The package enables two primary visualization workflows:
1. **Pixel-level visualization**: Displaying raw or normalized intensity values for multiple markers.
2. **Cell-level visualization**: Mapping single-cell data (expression or metadata) from a `SingleCellExperiment` object onto segmentation masks.

## Core Workflows

### 1. Data Loading and Preparation
Images and masks are loaded into `CytoImageList` objects.
```r
library(cytomapper)

# Load images or masks
path <- "path/to/images"
images <- loadImages(path, pattern = "_imc.tiff")
masks <- loadImages(path, pattern = "_mask.tiff")

# Scale masks if they were normalized during acquisition (e.g., 16-bit)
masks <- scaleImages(masks, 2^16 - 1)

# Set channel names for multi-channel stacks
channelNames(images) <- c("H3", "CD99", "CDH", "CD8a", "PIN")

# Link images to metadata using mcols
mcols(images)$ImageNb <- c("1", "2", "3")
mcols(masks)$ImageNb <- c("1", "2", "3")
```

### 2. Pixel-Level Visualization (`plotPixels`)
Use `plotPixels` to view up to 6 channels simultaneously.
```r
# Basic multi-channel plot
plotPixels(image = images, colour_by = c("H3", "CD99", "CDH"))

# Plot with cell outlines from masks
plotPixels(image = images, 
           mask = masks, 
           object = sce, 
           img_id = "ImageNb", 
           cell_id = "CellNb",
           colour_by = c("H3", "CD99"),
           outline_by = "CellType")
```

### 3. Cell-Level Visualization (`plotCells`)
Use `plotCells` to visualize metadata (e.g., cell types) or expression values on segmented areas.
```r
# Colour by metadata (discrete)
plotCells(mask = masks, 
          object = sce, 
          img_id = "ImageNb", 
          cell_id = "CellNb", 
          colour_by = "CellType")

# Colour by expression (continuous)
plotCells(mask = masks, 
          object = sce, 
          img_id = "ImageNb", 
          cell_id = "CellNb", 
          colour_by = "CD99",
          exprs_values = "exprs")
```

### 4. Image Manipulation
`CytoImageList` objects support standard list operations and specialized accessors.
* **Subsetting**: `getImages(images, "ImageName")` or `getChannels(images, "CD99")`.
* **Merging**: `mergeChannels(images1, images2)`.
* **Normalization**: `normalize(images)` scales pixel values (0-1) globally or per-image.
* **Looping**: Use `endoapply(images, FUN, ...)` to apply `EBImage` functions (like `gblur`) while preserving the `CytoImageList` class.

### 5. Feature Extraction
Generate a `SingleCellExperiment` directly from images and masks.
```r
sce <- measureObjects(masks, images, img_id = "ImageNb")
```

## Advanced Features
* **On-disk Storage**: For large datasets, use `loadImages(..., on_disk = TRUE, h5FilesPath = path)` to store images as HDF5 files via `HDF5Array`.
* **Interactive Gating**: Use `cytomapperShiny(object = sce, mask = masks, image = images)` to gate cells interactively and visualize them on images.
* **Customization**: Most plotting functions accept `bcg` (brightness, contrast, gamma), `scale_bar`, and `image_title` lists for fine-grained visual control.

## Reference documentation
- [Visualization of imaging cytometry data in R](./references/cytomapper.md)
- [On disk storage and handling of images](./references/cytomapper_ondisk.md)