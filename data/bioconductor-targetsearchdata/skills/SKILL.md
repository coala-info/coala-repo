---
name: bioconductor-targetsearchdata
description: This package provides exemplary GC-MS data from E. coli salt stress experiments for testing and demonstrating metabolomics analysis workflows. Use when user asks to load raw NetCDF files, access metabolite libraries, retrieve retention index markers, or locate sample metadata for TargetSearch demonstrations.
homepage: https://bioconductor.org/packages/release/data/experiment/html/TargetSearchData.html
---

# bioconductor-targetsearchdata

name: bioconductor-targetsearchdata
description: Access and utilize the TargetSearchData Bioconductor package, which provides exemplary GC-MS (Gas Chromatography-Mass Spectrometry) data from E. coli salt stress experiments. Use this skill when a user needs to load raw NetCDF files, peak lists (RI files), sample metadata, metabolite libraries, or retention index markers for testing or demonstrating GC-MS data analysis workflows, particularly with the TargetSearch package.

## Overview

The `TargetSearchData` package is a specialized data-experiment package providing a subset of metabolite data from an E. coli stress response study. It serves as the primary data source for examples and vignettes in the `TargetSearch` ecosystem. The package includes trimmed NetCDF (CDF) files, corresponding retention index (RI) peak lists, sample metadata, a metabolite reference library, and retention time correction markers (FAMEs).

## Data Access Functions

The package provides several helper functions with the `tsd_` prefix to easily locate and load these files without manually constructing file paths.

### Locating the Data Directory
*   `tsd_path()`: Returns the absolute path to the `TargetSearchData` installation directory.
*   `tsd_data_path()`: Returns the path to the `gc-ms-data` subdirectory where all experimental files are stored.

### Retrieving Specific Files
*   `tsd_file_path(filenames)`: Returns the absolute path for one or more specific files (e.g., "samples.txt"). It validates that the files exist.
*   `tsd_cdffiles()`: Returns a character vector of all available NetCDF (.cdf) files.
*   `tsd_rifiles()`: Returns a character vector of all available peak list (.txt) files.

## Typical Workflow

### 1. Load the Package
```r
library(TargetSearchData)
```

### 2. Access Metadata and Libraries
These files are essential for setting up a `TargetSearch` analysis:
```r
# Get path to the sample description file
sample_file <- tsd_file_path("samples.txt")

# Get path to the metabolite library
lib_file <- tsd_file_path("library.txt")

# Get path to the RI markers (FAMEs)
rim_file <- tsd_file_path("rimLimits.txt")
```

### 3. List Raw Data Files
```r
# List all CDF files for processing
cdf_files <- tsd_cdffiles()

# List all RI files (pre-extracted peak lists)
ri_files <- tsd_rifiles()
```

## Data Specifications

*   **CDF Files**: Trimmed versions of original files. Retention time is restricted to 200–400 seconds; m/z range is 85–320 daltons.
*   **RI Files**: Tab-delimited text files containing retention time, retention index, and spectra (m/z:intensity).
*   **Sample Metadata**: Contains `CDF_FILE`, `MEASUREMENT_DAY`, and `TIME_POINT`.
*   **Library File**: Contains metabolite names, expected RI, search windows, selective masses, and reference spectra.
*   **RI Markers**: Defines the `LowerLimit`, `UpperLimit`, and `RIstandard` for FAMEs used in retention index calibration.

## Reference documentation

- [The TargetSearchData Package](./references/TargetSearchData.md)