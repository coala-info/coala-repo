---
name: bioconductor-xenlite
description: This tool provides a lightweight infrastructure for analyzing and visualizing 10x Genomics Xenium spatial transcriptomics data using the XenSPEP class and Parquet-backed geometry. Use when user asks to manage large-scale spatial datasets, restore XenSPEP objects from Parquet files, or visualize cell segments and transcript distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/xenLite.html
---

# bioconductor-xenlite

name: bioconductor-xenlite
description: Analysis and exploration of 10x Genomics Xenium spatial transcriptomics data using the xenLite package. Use this skill to work with the XenSPEP class, manage large-scale spatial geometry via Parquet files, and perform lightweight visualization of cell segments and transcript distributions.

# bioconductor-xenlite

## Overview

The `xenLite` package provides a lightweight infrastructure for handling 10x Genomics Xenium data within the Bioconductor ecosystem. It addresses the high dependency load of traditional spatial packages by using the `XenSPEP` class, which extends `SpatialExperiment`. This class manages voluminous geometry data (cell, nucleus, and transcript coordinates) using Parquet files, while keeping expression counts in memory or HDF5-backed matrices.

## Core Workflow

### 1. Installation and Setup

Install the package using `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("xenLite")
library(xenLite)
```

### 2. Accessing Demonstration Data

The package provides functions to retrieve cached datasets from the Open Storage Network:

*   **Human Lung Cancer:** `pa <- cacheXenLuad()`
*   **Human Dermal Melanoma:** `pa <- cacheXenPdmelLite()`
*   **Human Prostate Adenocarcinoma:** `pa <- cacheXenProstLite()`

### 3. Restoring XenSPEP Objects

Data is typically downloaded as a zip file containing the `SpatialExperiment` component and Parquet files. Use `restoreZipXenSPEP` to load the object into R:

```r
# pa is the path returned by a cache function
spe <- restoreZipXenSPEP(pa)

# Standard preprocessing: ensure rownames are unique gene symbols
rownames(spe) <- make.names(SummarizedExperiment::rowData(spe)$Symbol, unique = TRUE)
```

### 4. Spatial Visualization

Use `viewSegG2` to visualize cell segments and transcript occupancy for specific genes in a defined spatial region:

```r
# Define spatial boundaries (x_range, y_range)
# gene1 and gene2 are used to color cells by occupancy
out <- viewSegG2(spe, 
                 xlim = c(5800, 6300), 
                 ylim = c(1300, 1800), 
                 lwd = 0.5, 
                 gene1 = "CD4", 
                 gene2 = "EPCAM")

# Add a legend to interpret colors (single vs double occupancy)
legend(5800, 1390, 
       fill = c("purple", "cyan", "pink"), 
       legend = c("CD4", "EPCAM", "Both"))
```

### 5. Handling Large Disk-Based Data

For very large datasets, `xenLite` supports HDF5-backed representations to minimize memory usage:

```r
# Create a working directory and unzip the cached data
dir.create(work_dir <- file.path(tempdir(), "xenium_work"))
unzip(pa, exdir = work_dir)

# Load the HDF5-backed SummarizedExperiment component
library(HDF5Array)
spe_hdf5 <- loadHDF5SummarizedExperiment(file.path(work_dir, "xen_data_folder"))
```

## Key Functions and Classes

*   **XenSPEP Class:** An extension of `SpatialExperiment` designed to handle Parquet-backed geometry.
*   **`restoreZipXenSPEP()`:** Reconstitutes the spatial object from a zipped archive.
*   **`viewSegG2()`:** Plots cell boundaries and highlights cells containing specific transcripts.
*   **`cacheXen*()` functions:** Utility functions for downloading and caching Xenium datasets.

## Tips for Success

*   **Memory Management:** If working with full Xenium slides, prefer the HDF5-backed workflow to avoid crashing the R session.
*   **Coordinate Systems:** Ensure the `xlim` and `ylim` parameters in `viewSegG2` match the coordinate system of the `spatialCoords(spe)`.
*   **Gene Symbols:** Always check `rowData(spe)$Symbol` as the primary identifier for genes, as `rownames` may initially be Ensembl IDs or non-unique.

## Reference documentation

- [xenLite: exploration of a class for Xenium demonstration data](./references/xenLite.Rmd)
- [xenLite: exploration of a class for Xenium demonstration data (Markdown)](./references/xenLite.md)