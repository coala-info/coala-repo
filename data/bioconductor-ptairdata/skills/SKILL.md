---
name: bioconductor-ptairdata
description: This package provides raw PTR-TOF-MS mass spectrometry datasets in HDF5 format for volatolomics analysis. Use when user asks to access example exhaled air or mycobacteria headspace data, test ptairMS processing workflows, or locate raw HDF5 files for mass spectrometry tutorials.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ptairData.html
---


# bioconductor-ptairdata

name: bioconductor-ptairdata
description: Access and use the ptairData Bioconductor package, which provides raw PTR-TOF-MS (Proton-Transfer-Reaction Time-of-Flight mass spectrometer) datasets in HDF5 format. Use this skill to locate and load example data for volatolomics analysis, specifically for testing the ptairMS processing package.

# bioconductor-ptairdata

## Overview
The `ptairData` package is an experiment data package providing raw mass spectrometry datasets (HDF5 format) acquired from a PTR-TOF-MS instrument. It serves as the primary data source for examples and vignettes in the `ptairMS` package. The data includes exhaled air samples from healthy individuals and headspace samples from mycobacteria cell cultures.

## Installation
To install the package from Bioconductor:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("ptairData")
```

## Data Access and Workflows

### Locating Raw Data Files
The datasets are stored as HDF5 files within the package installation directory. Use `system.file` to retrieve the absolute paths to these directories or specific files.

```r
# Path to the exhaled air dataset directory
exhaled_dir <- system.file("extdata/exhaledAir", package = "ptairData")
list.files(exhaled_dir)

# Path to the mycobacteria dataset directory
myco_dir <- system.file("extdata/mycobacteria", package = "ptairData")
list.files(myco_dir)
```

### Dataset Descriptions
1.  **exhaledAir**: Contains 6 files.
    *   Source: Two healthy individuals.
    *   Replicates: Three acquisitions per individual on different days.
    *   Sampling: Two expirations per acquisition using Buffered end-tidal (BET) sampling.
    *   m/z Range: Truncated to [20.4, 21.6] and [50, 150] to reduce file size.

2.  **mycobacteria**: Contains 6 files.
    *   Source: Cell culture headspace.
    *   Groups: Two different mycobacteria species and one control (medium only).
    *   Replicates: Two replicates per group.
    *   m/z Range: Truncated to [20.4, 21.6] and [56.4, 90.6].

### Integration with ptairMS
These files are intended to be processed using the `ptairMS` package. A typical workflow involves pointing `ptairMS` functions to these file paths:

```r
library(ptairMS)
library(ptairData)

# Example: Reading a directory of files from ptairData
directory_path <- system.file("extdata/exhaledAir", package = "ptairData")
# Then use ptairMS functions like readRaw, ptairMS, etc.
```

## Usage Tips
*   **Truncated Data**: Remember that these files are truncated in the m/z dimension. They are excellent for testing code logic and workflows but do not represent the full spectral range of a standard acquisition.
*   **HDF5 Format**: The files are in HDF5 format. While they can be inspected with general HDF5 tools (like `rhdf5`), they are specifically structured for the `ptairMS` processing pipeline.

## Reference documentation
- [PTR-TOF-MS volatolomics datasets description](./references/ptairData_vignette.Rmd)
- [PTR-TOF-MS dataset description (Markdown version)](./references/ptairData_vignette.md)