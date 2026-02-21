---
name: bioconductor-gcspikelite
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gcspikelite.html
---

# bioconductor-gcspikelite

name: bioconductor-gcspikelite
description: Access spike-in GC/MS data for metabolomics analysis. Use when demonstrating or testing GC/MS peak alignment, identification, and quantification workflows, particularly those involving the 'flagme' package.

# bioconductor-gcspikelite

## Overview
The `gcspikelite` package is a Bioconductor experiment data package providing spike-in Gas Chromatography/Mass Spectrometry (GC/MS) data. It contains six NetCDF files and a metadata "targets" file. This dataset is specifically designed to support the methods and workflows implemented in the `flagme` package, which handles peak detection, alignment, and visualization for GC/MS data.

## Loading Data and Metadata
The package provides a `targets` data frame that maps filenames to experimental groups.

```r
# Load the package
library(gcspikelite)

# Load the targets metadata
data(targets)

# View the metadata (Filename and Group columns)
print(targets)
```

## Locating Raw Data Files
The actual GC/MS data is stored as NetCDF (.CDF) files within the package's installation directory. To use these files with analysis tools like `flagme` or `xcms`, you must resolve their full system paths.

```r
# Get the directory containing the NetCDF files
gcms_path <- system.file("gc-ms-data", package = "gcspikelite")

# List the available CDF files
cdf_files <- list.files(gcms_path, pattern = ".CDF", full.names = TRUE)

# Combine with targets metadata for analysis
targets$FullFilePath <- file.path(gcms_path, targets$Filename)
```

## Typical Workflow with flagme
The primary use case for `gcspikelite` is to provide a reproducible dataset for the `flagme` workflow.

1. **Data Preparation**: Locate the files and define the groups.
2. **Peak Detection**: Use `flagme` or `xcms` to process the raw CDF files.
3. **Alignment**: Use the spike-in data to test retention time alignment algorithms.

Example of initializing a `peakDataset` (requires `flagme`):
```r
library(flagme)
# Assuming cdf_files and targets are prepared
# pd <- peakDataset(targets$FullFilePath, mz=seq(50, 550), rt=seq(1, 1000))
```

## Data Structure
- **targets**: A data frame with 6 observations.
  - `Filename`: The name of the NetCDF file.
  - `Group`: The experimental condition (e.g., "0.2x", "1x", "2x", "5x").
- **Raw Files**: 6 NetCDF files located in the `gc-ms-data` subdirectory of the package.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)