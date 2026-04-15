---
name: bioconductor-spatialomicsoverlay
description: This package recreates and visualizes Region of Interest overlays from NanoString GeoMx experiments by integrating OME-TIFF images with experimental metadata and gene expression data. Use when user asks to visualize spatial transcriptomics data, overlay ROI selections on images, or manipulate OME-TIFF image orientations and crops for GeoMx experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/SpatialOmicsOverlay.html
---

# bioconductor-spatialomicsoverlay

## Overview

The `SpatialOmicsOverlay` package allows users to recreate the Region of Interest (ROI) overlays from NanoString GeoMx experiments in R. It integrates OME-TIFF image data with experimental metadata and gene expression, enabling high-resolution visualization of free-handed ROI selections and immunofluorescent-guided segmentations.

## Core Workflow

### 1. Data Ingestion

To create a `SpatialOverlay` object, you need the OME-TIFF file and a Lab Worksheet or annotation file.

```r
library(SpatialOmicsOverlay)
library(GeomxTools)

# Increase Java heap space BEFORE loading RBioFormats if handling large images
options(java.parameters = "-Xmx4g")

# Read overlay without image first (faster)
muBrain <- readSpatialOverlay(ometiff = "path/to/image.ome.tiff", 
                              annots = "path/to/LabWorksheet.txt",
                              slideName = "Slide1", 
                              image = FALSE, 
                              outline = FALSE)
```

### 2. Adding Plotting Factors

Attach metadata or gene expression data to the overlay object to use for coloring plots.

```r
# Add categorical metadata
muBrain <- addPlottingFactor(overlay = muBrain, 
                             annots = annot_df, 
                             plottingFactor = "segment")

# Add gene expression from a GeomxSet
muBrain <- addPlottingFactor(overlay = muBrain, 
                             annots = target_geomx_set, 
                             plottingFactor = "Calm1")
```

### 3. Plotting Without Image

Plot ROIs based on coordinates. This is useful for quick data exploration.

```r
# hiRes = FALSE uses points (faster), hiRes = TRUE uses polygons
plotSpatialOverlay(overlay = muBrain, 
                   colorBy = "Calm1", 
                   hiRes = FALSE) +
    viridis::scale_color_viridis()
```

### 4. Integrating the Image

OME-TIFFs are pyramidal. Use `checkValidRes` to find a resolution your system can handle (higher `res` = smaller image).

```r
res <- checkValidRes(ometiff = "path/to/image.ome.tiff") # e.g., returns 8
muBrain <- addImageOmeTiff(overlay = muBrain, 
                           ometiff = "path/to/image.ome.tiff", 
                           res = res)

# Plot with image background
plotSpatialOverlay(overlay = muBrain, 
                   colorBy = "segment", 
                   fluorLegend = TRUE)
```

## Image Manipulation

### Flipping and Reorienting
Correct image orientation to match traditional anatomical views.
```r
muBrain <- flipY(muBrain)
muBrain <- flipX(muBrain)
```

### Cropping
Reduce memory usage and focus on specific areas.
```r
# Crop to tissue boundaries
muBrain <- cropTissue(overlay = muBrain, buffer = 0.05)

# Crop to specific samples
muBrainCrop <- cropSamples(overlay = muBrain, 
                           sampleIDs = c("Sample1", "Sample2"), 
                           sampsOnly = TRUE)
```

### Recoloring Channels
Modify the visualization markers (e.g., FITC, Cy3, Cy5).
```r
# Must be done on a 4-channel image before RGB conversion
chan4 <- add4ChannelImage(overlay = muBrain)
chan4 <- changeImageColoring(overlay = chan4, color = "magenta", dye = "Cy5")
chan4 <- changeColoringIntensity(overlay = chan4, minInten = 500, maxInten = 10000, dye = "Cy5")
chan4 <- recolor(chan4)
showImage(chan4)
```

## Troubleshooting

- **Java Heap Space**: If `readSpatialOverlay` fails with `java.lang.OutOfMemoryError`, run `options(java.parameters = "-Xmx4g")` (or higher) in a fresh R session before loading any libraries.
- **NegativeArraySizeException**: The image resolution (`res`) is too high for your system's memory. Increase the `res` value (e.g., from 4 to 6).
- **Cache Resources Exhausted**: This is a `magick` memory limit. You may need to configure the ImageMagick policy file on your system.

## Reference documentation
- [SpatialOmicsOverlay](./references/SpatialOmicsOverlay.md)