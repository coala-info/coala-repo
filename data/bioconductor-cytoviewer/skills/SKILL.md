---
name: bioconductor-cytoviewer
description: This tool provides an interactive Shiny-based interface for visualizing multi-channel images, segmentation masks, and single-cell metadata from multiplexed imaging technologies. Use when user asks to launch an interactive image viewer, overlay segmentation masks on images, or visualize single-cell metadata in a spatial context.
homepage: https://bioconductor.org/packages/release/bioc/html/cytoviewer.html
---

# bioconductor-cytoviewer

name: bioconductor-cytoviewer
description: Interactive visualization of multi-channel images and segmentation masks from imaging mass cytometry (IMC) and other multiplexed imaging technologies. Use this skill to launch Shiny-based image viewers, overlay segmentation masks on images, and visualize single-cell metadata (SingleCellExperiment/SpatialExperiment) in a spatial context.

# bioconductor-cytoviewer

## Overview

The `cytoviewer` package provides an interactive Shiny interface for exploring highly multiplexed imaging data. It bridges the gap between raw pixel-level intensities (stored in `CytoImageList` objects) and single-cell data (stored in `SingleCellExperiment` or `SpatialExperiment` objects). The tool supports three primary visualization modes:
1. **Composite**: Multi-channel overlays with adjustable contrast, brightness, and gamma.
2. **Channels**: Side-by-side viewing of individual marker channels.
3. **Masks**: Visualization of segmentation masks colored by cell-specific metadata (e.g., cell type, expression levels).

## Core Workflow

### 1. Data Preparation
`cytoviewer` requires data to be formatted into specific Bioconductor classes, typically using the `cytomapper` package for loading.

```r
library(cytoviewer)
library(cytomapper)

# Load images and masks (usually .tiff)
images <- loadImages(path_to_tiffs, pattern = "_imc.tiff")
masks <- loadImages(path_to_masks, pattern = "_mask.tiff", as.is = TRUE)

# Set channel names for the images
channelNames(images) <- c("CD3", "CD8", "PanCK", "DNA1")

# Add image identifiers to link objects
mcols(images)$ImageID <- c("Sample1", "Sample2")
mcols(masks)$ImageID <- c("Sample1", "Sample2")
```

### 2. Launching the Interface
The `cytoviewer()` function returns a Shiny app object. You must call `shiny::runApp()` to open the interface.

```r
# Basic call with images only
app <- cytoviewer(image = images)

# Full call with masks and single-cell metadata
app <- cytoviewer(image = images,
                  mask = masks,
                  object = sce_object,
                  img_id = "ImageID",   # colData column in sce_object
                  cell_id = "CellID")   # colData column in sce_object

if (interactive()) {
  shiny::runApp(app)
}
```

## Input Variations

The functionality of the app scales based on the provided arguments:
*   **Images only**: Image-level visualization (Composite/Channels).
*   **Images + Masks**: Adds the ability to overlay mask outlines on top of images.
*   **Images + Masks + Object**: Full functionality, including coloring masks or outlines by metadata (e.g., "CellType" or "Area").
*   **Masks + Object**: Cell-level visualization only (no raw pixel data).

## Key Features & Tips

*   **Image Appearance**: Use the "General controls" in the sidebar to add scale bars, legends, and titles.
*   **Image Filters**: Apply Gaussian blurring or toggle pixel interpolation for smoother visualization.
*   **Metadata Coloring**: When an `object` is provided, you can color cells by categorical variables (discrete colors) or continuous variables (using viridis, inferno, or plasma palettes).
*   **Zooming**: The "Composite" and "Mask" tabs support interactive zooming to inspect sub-cellular details.
*   **Downloads**: Use the dropdown menu in the header to export the current view as a PDF or PNG.

## Reference documentation

- [cytoviewer - Interactive multi-channel image visualization in R](./references/cytoviewer.md)
- [imageBrowser.Rmd](./references/imageBrowser.Rmd)