---
name: bioconductor-simpleseg
description: bioconductor-simpleseg provides a streamlined pipeline for segmenting multiplexed cellular images and extracting single-cell features directly within R. Use when user asks to segment TIFF stacks into masks, identify cell bodies using watershedding or dilation, and normalize extracted spatial proteomics or transcriptomics data.
homepage: https://bioconductor.org/packages/release/bioc/html/simpleSeg.html
---


# bioconductor-simpleseg

## Overview

`simpleSeg` is a Bioconductor package designed to streamline the segmentation of multiplexed cellular images directly within R. It extends the functionality of `EBImage` and `cytomapper` to provide a structured pipeline for creating segmentation masks from TIFF stacks without requiring external software. The package is particularly useful for spatial proteomics and transcriptomics workflows, offering automated parameter optimization and multiple methods for watershedding and cell body identification.

## Installation

```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("simpleSeg")
```

## Typical Workflow

### 1. Data Loading
`simpleSeg` works with `CytoImageList` objects from the `cytomapper` package.

```R
library(simpleSeg)
library(cytomapper)
library(EBImage)

# Load TIFFs as a CytoImageList
# Assuming 'files' is a list of paths to TIFF stacks
images <- lapply(files, EBImage::readImage, as.is = TRUE)
images <- cytomapper::CytoImageList(images)
mcols(images)$imageID <- names(images)
```

### 2. Segmentation
The `simpleSeg()` function is the primary interface. It generates a `CytoImageList` of segmentation masks.

```R
masks <- simpleSeg::simpleSeg(images,
  nucleus = "HH3",        # Name or index of the nuclear marker
  transform = "sqrt",     # Optional: "sqrt", "log", or NULL
  cellBody = "dilation",  # Method to identify cytoplasm
  discSize = 3,           # Pixels to dilate if using "dilation"
  cores = 1               # Parallel processing support
)
```

**Watershedding Methods (`watershed` argument):**
*   `"distance"`: Uses a distance map of thresholded nuclei.
*   `"intensity"`: Uses the raw intensity of the nuclear marker.
*   `"combine"`: Multiplies distance map by intensity (default).

**Cell Body Identification (`cellBody` argument):**
*   `"dilation"`: Expands nuclei by a fixed pixel radius.
*   `"discModel"`: Uses all markers to predict cytoplasm via a model.
*   `"marker"`: Uses specific cytoplasm markers (e.g., `cellBody = "CD3"`).
*   `"None"`: Returns only the nuclear masks.

### 3. Feature Extraction
Use `cytomapper::measureObjects` to extract intensities and morphological features into a `SingleCellExperiment` (SCE).

```R
cellSCE <- cytomapper::measureObjects(masks, images, img_id = "imageID")
```

### 4. Normalization
The `normalizeCells()` function prepares the extracted data for downstream analysis like clustering or classification.

```R
cellSCE <- normalizeCells(cellSCE,
  assayIn = "counts",
  assayOut = "norm",
  imageID = "imageID",
  transformation = "sqrt",
  method = c("trim99", "minMax") # Can chain multiple methods
)
```

**Available Normalization Methods:**
*   `"mean"`: Divides intensities by their mean.
*   `"minMax"`: Scales values between 0 and 1.
*   `"trim99"`: Caps values at the 99th percentile to handle outliers.
*   `"PC1"`: Removes the first principal component (technical noise reduction).

## Visualization Tips

*   **Check Masks:** Use `EBImage::display(colorLabels(masks[[1]]))` for an interactive view of the segmentation.
*   **Overlay Markers:** Use `cytomapper::plotPixels()` to overlay mask outlines on specific marker channels to validate boundary accuracy.
*   **QC Distributions:** Use `ggplot2` to plot the density of markers before and after normalization to ensure the data is appropriately scaled (e.g., moving from highly skewed to bimodal distributions).

## Reference documentation

- [Segmenting and normalizing multiplexed imaging data with simpleSeg](./references/simpleSeg.md)