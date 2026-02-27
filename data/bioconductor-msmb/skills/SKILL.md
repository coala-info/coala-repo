---
name: bioconductor-msmb
description: This package provides access to datasets, images, and scripts associated with the "Modern Statistics for Biology" textbook. Use when user asks to access example biological data files, load pre-saved R objects from the MSMB book, or retrieve microscopy images for analysis workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MSMB.html
---


# bioconductor-msmb

name: bioconductor-msmb
description: Access and load data sets, images, and scripts associated with the book 'Modern Statistics for Biology' (MSMB). Use this skill when a user needs to practice biological data analysis, access specific example files (FCS, TXT, CSV, RData), or follow workflows from the MSMB textbook.

# bioconductor-msmb

## Overview
The `MSMB` package is a data-experiment package for Bioconductor that serves as a companion to the book "Modern Statistics for Biology" by Susan Holmes and Wolfgang Huber. It provides a centralized repository of diverse biological datasets, including flow cytometry data (.fcs), image files (.tif, .png), and structured data frames used throughout the book's chapters.

## Loading the Package
To begin using the resources, load the library in your R session:
```r
library("MSMB")
```

## Accessing Data Resources
The package organizes data into several subdirectories within the package installation folder. Use `system.file` to locate these assets.

### 1. External Data (extdata)
Contains raw data files such as Flow Cytometry (FCS) files, metadata, and CSVs.
```r
# List all files in extdata
dir(system.file("extdata", package = "MSMB"))

# Example: Accessing a specific file path
fcs_path <- system.file("extdata", "01126211_NB8_I025.fcs", package = "MSMB")
turtle_path <- system.file("extdata", "PaintedTurtles.txt", package = "MSMB")
```

### 2. Images (images)
Contains microscopy and biological images for image analysis workflows.
```r
# List available images
dir(system.file("images", package = "MSMB"))

# Example: Accessing a TIF image
dapi_path <- system.file("images", "image-DAPI.tif", package = "MSMB")
```

### 3. R Data Objects (data)
Contains pre-saved R objects (.RData) which can be loaded directly into the environment.
```r
# List available RData objects
dir(system.file("data", package = "MSMB"))

# Load a specific dataset
load(system.file("data", "brcalymphnode.RData", package = "MSMB"))
```

### 4. Scripts (scripts)
Contains R scripts used for specific data processing tasks described in the book.
```r
# List available scripts
dir(system.file("scripts", package = "MSMB"))
```

## Typical Workflow
1. **Identify the resource**: Determine if you need a raw file (extdata), an image (images), or a processed R object (data).
2. **Retrieve the path**: Use `system.file(subdir, filename, package = "MSMB")`.
3. **Read the data**: Use the appropriate R function for the file type (e.g., `read.csv()` for .csv, `flowCore::read.FCS()` for .fcs, or `EBImage::readImage()` for .tif).

## Reference documentation
- [Data sets for the book ‘Modern Statistics for Biology’](./references/MSMB.md)