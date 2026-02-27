---
name: bioconductor-synapsis
description: The synapsis package automates the analysis of meiotic immunofluorescence data by processing microscopy images to identify cells and quantify molecular events. Use when user asks to crop individual cells from images, identify meiotic sub-stages like pachytene, or count protein foci on synaptonemal complexes.
homepage: https://bioconductor.org/packages/release/bioc/html/synapsis.html
---


# bioconductor-synapsis

name: bioconductor-synapsis
description: Analysis of meiotic immunofluorescence data using the synapsis R package. Use this skill to automate the processing of microscopy images, specifically for cropping individual cells, identifying meiotic sub-stages (pachytene), and counting coincident foci on synaptonemal complexes.

# bioconductor-synapsis

## Overview

The `synapsis` package provides tools for the objective and reproducible analysis of meiotic immunofluorescence data. It is specifically designed to handle meiotic prophase I images where researchers need to quantify molecular events (foci) occurring on chromosomal structures (the synaptonemal complex). The package automates cell identification, stage classification, and foci counting, reducing the subjectivity inherent in manual quantification.

## Core Workflow

### 1. Data Preparation
The package expects separate image files for different channels (e.g., one for the foci protein like MLH3 and one for the synaptonemal complex like SYCP3).

```r
library(synapsis)
library(EBImage)

# Define path to image directory
path <- "path/to/your/images"

# Example of reading images to check resolution
img <- readImage(paste0(path, "/your_image_SYCP3.tif"))
dim(img) # High resolution (e.g., >1000x1000) is recommended
```

### 2. Automated Cell Cropping
Use `auto_crop_fast` to identify and extract individual cells from large field-of-view images.

```r
# Basic cropping
auto_crop_fast(path, file_ext = "tif", min_cell_area = 7000, max_cell_area = 30000)

# For images with touching/overlapping cells, use watershed separation
auto_crop_fast(path, file_ext = "tif", crowded_cells = TRUE)
```
*   **Output**: Creates a `crops/` folder containing individual cell images and a `crops-RGB/` folder for visual verification.
*   **Tip**: Use `annotation = "on"` to generate diagnostic plots during the process.

### 3. Identifying Pachytene Cells (Optional)
Filter the cropped cells to identify those specifically in the pachytene stage based on synaptonemal complex morphology.

```r
SYCP3_stats <- get_pachytene(path, file_ext = "tif", ecc_thresh = 0.8, area_thresh = 0.04)
```
*   **Output**: Moves pachytene-positive cells to a `crops/pachytene/` subfolder and returns a data frame of cell statistics.

### 4. Counting Foci
Quantify the number of protein foci that coincide with the synaptonemal complex.

```r
foci_counts <- count_foci(
  path, 
  stage = "pachytene", 
  file_ext = "tif", 
  crowded_foci = FALSE, # Set TRUE for high-density foci like DMC1
  offset_factor = 8, 
  brush_size = 3
)
```

## Interpreting Results

The `count_foci` function returns a data frame with the following key columns:
*   **foci_count**: The number of coincident foci identified.
*   **lone_foci**: Foci detected that do not overlap with the synaptonemal complex.
*   **verdict**: A "keep" or "discard" recommendation based on image "crispness" (C1 metric).
*   **C1**: A measurement of foci size uniformity; lower values typically indicate clearer images with less background noise.

## Troubleshooting and Tips

*   **Resolution**: If images are low resolution, smoothing operations may erase small foci. Aim for images >4MB.
*   **Parameter Tuning**: If detection is poor, adjust `min_cell_area` or `max_cell_area` based on the pixel dimensions of your cells.
*   **Genotype Strings**: By default, the package looks for "++" (WT) or "--" (KO) in filenames. Customize this using `WT_str` and `KO_str` arguments in `get_pachytene`.
*   **Testing**: Use the `test_amount` parameter in `auto_crop_fast` to process a small subset of images while optimizing parameters.

## Reference documentation

- [Using synapsis](./references/synapsis_tutorial.md)