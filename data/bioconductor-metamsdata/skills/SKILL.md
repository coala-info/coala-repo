---
name: bioconductor-metamsdata
description: This package provides example GC-MS and LC-MS data files in NetCDF format for metabolomics data analysis. Use when user asks to access sample mass spectrometry data, perform metabolomics processing demonstrations, or test pipelines using the metaMS package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/metaMSdata.html
---


# bioconductor-metamsdata

name: bioconductor-metamsdata
description: Accessing and using the example GC-MS and LC-MS CDF data files provided by the metaMSdata package. Use this skill when a user needs to perform metabolomics data analysis demonstrations, testing, or benchmarking using the metaMS package and requires standard NetCDF (.CDF) sample files.

# bioconductor-metamsdata

## Overview
The `metaMSdata` package is a data-only Bioconductor ExperimentData package. It provides essential example datasets in NetCDF format for both Gas Chromatography-Mass Spectrometry (GC-MS) and Liquid Chromatography-Mass Spectrometry (LC-MS). These files are specifically designed to be used with the `metaMS` package for demonstrating automated metabolomics data processing pipelines, including peak picking, alignment, and identification.

## Loading and Accessing Data
Since `metaMSdata` contains no R functions and only external data files, the primary workflow involves locating the physical paths to the provided `.CDF` files using `system.file`.

### Locating GC-MS Example Files
The package includes four GC-MS files and a template CSV for database building.
```r
# List all GC-MS CDF files
gc_files <- list.files(system.file("extdata", package = "metaMSdata"), 
                       pattern = "GC.*CDF", 
                       full.names = TRUE)

# Locate the GC-MS database template
gc_csv <- system.file("extdata", "three_compounds.csv", package = "metaMSdata")
```

### Locating LC-MS Example Files
The package includes four LC-MS files.
```r
# List all LC-MS CDF files
lc_files <- list.files(system.file("extdata", package = "metaMSdata"), 
                       pattern = "LC.*CDF", 
                       full.names = TRUE)
```

## Typical Workflow with metaMS
The most common use case for this skill is providing data to the `runGC` or `runLC` functions in the `metaMS` package.

### Example: GC-MS Processing
```r
library(metaMS)
library(metaMSdata)

# Get paths to GC files
files <- list.files(system.file("extdata", package = "metaMSdata"), 
                    pattern = "GC", full.names = TRUE)

# Use with metaMS (requires setting up settings and database)
# data(FEM_settings)
# result <- runGC(files, settings = metaSetting(FEM_settings, "GC"))
```

### Example: LC-MS Processing
```r
library(metaMS)
library(metaMSdata)

# Get paths to LC files
files <- list.files(system.file("extdata", package = "metaMSdata"), 
                    pattern = "LC", full.names = TRUE)

# Use with metaMS
# data(FEM_settings)
# result <- runLC(files, settings = metaSetting(FEM_settings, "LC"))
```

## Tips
- **Data Format**: All mass spectrometry data files are in the NetCDF (.CDF) format, which is a common exchange format for MS data.
- **Database Template**: The `three_compounds.csv` file in `inst/extdata` is a critical reference for users looking to format their own in-house libraries for GC-MS annotation.
- **Package Dependency**: This package is almost always used in conjunction with `metaMS`. Ensure `metaMS` is installed to process these files.

## Reference documentation
- [metaMSdata Reference Manual](./references/reference_manual.md)