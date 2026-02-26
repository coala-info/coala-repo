---
name: bioconductor-imcdatasets
description: The imcdatasets package provides access to curated, publicly available Imaging Mass Cytometry datasets including single-cell data, raw images, and segmentation masks. Use when user asks to list available IMC datasets, retrieve single-cell expression data, download multichannel images or masks, or access dataset metadata for downstream analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/imcdatasets.html
---


# bioconductor-imcdatasets

## Overview
The `imcdatasets` package provides a collection of curated, publicly available Imaging Mass Cytometry (IMC) datasets. Each dataset typically consists of three components: single-cell expression data, multichannel raw images, and cell segmentation masks. This package is designed to work seamlessly with `cytomapper` for visualization and `SingleCellExperiment` for downstream analysis.

## Core Workflows

### 1. Listing Available Datasets
To see which datasets are available and identify their specific loading functions:
```r
library(imcdatasets)
datasets <- listDatasets()
head(datasets)
```
Key columns in the output include `FunctionCall` (the R function to use), `Species`, `Tissue`, and `NumberOfCells`.

### 2. Retrieving Data
Datasets are retrieved using their specific function (e.g., `Damond_2019_Pancreas()`). You must specify the `data_type` to download.

**Single-Cell Data:**
Returns a `SingleCellExperiment` or `SpatialExperiment` object.
```r
sce <- IMMUcan_2022_CancerExample(data_type = "sce")
```

**Multichannel Images:**
Returns a `CytoImageList` containing the raw pixel data for all channels.
```r
images <- IMMUcan_2022_CancerExample(data_type = "images")
```

**Segmentation Masks:**
Returns a `CytoImageList` containing single-channel images where pixel values correspond to cell IDs.
```r
masks <- IMMUcan_2022_CancerExample(data_type = "masks")
```

### 3. Memory Management (On-Disk Storage)
IMC images can be large. To save memory, you can store images/masks on disk as HDF5 files instead of loading them entirely into RAM.
```r
masks <- IMMUcan_2022_CancerExample(
    data_type = "masks", 
    on_disk = TRUE, 
    h5FilesPath = tempdir()
)
```

### 4. Accessing Metadata
To view metadata about a dataset without downloading the full object:
```r
IMMUcan_2022_CancerExample(data_type = "sce", metadata = TRUE)
```

## Integration with Other Packages

### Visualization with `cytomapper`
The objects returned by `imcdatasets` are specifically formatted for `cytomapper` functions:
* **Pixel Visualization:** `plotPixels(images, colour_by = c("CD8a", "CDH1"))`
* **Cell Visualization:** `plotCells(masks, object = sce, img_id = "image_number", cell_id = "cell_number", colour_by = "CD8a")`

### Data Structure Requirements
If contributing or manipulating data, ensure the following mappings:
* `image_name` in `colData(sce)` must match `mcols(images)$image_name` and `mcols(masks)$image_name`.
* `cell_number` in `colData(sce)` must match the integer values in the `masks` images.
* `rownames(sce)` should match `channelNames(images)`.

## Reference documentation
- [Contribution Guidelines and Dataset Formatting](./references/Guidelines_Contribution_Dataset-formatting.md)
- [imcdatasets Main Vignette](./references/imcdatasets.md)