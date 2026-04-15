---
name: bioconductor-rmassbankdata
description: This package provides example mass spectrometry data, compound lists, and metadata for testing and demonstrating RMassBank workflows. Use when user asks to access narcotics standards in mzML format, retrieve example compound lists, or test the RMassBank processing pipeline with pre-calculated results.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RMassBankData.html
---

# bioconductor-rmassbankdata

name: bioconductor-rmassbankdata
description: Access and use the RMassBankData experiment data package. Use this skill when you need example mass spectrometry data (mzML), compound lists, and annotation info-lists to test or demonstrate RMassBank workflows, including XCMS test data and narcotics standards.

# bioconductor-rmassbankdata

## Overview
`RMassBankData` is a Bioconductor experiment data package providing a standardized dataset for testing the `RMassBank` package. It contains high-resolution LC-MS/MS spectra of 15 narcotics standards, along with the necessary metadata (compound lists and info-lists) required to run the RMassBank pipeline from raw data to MassBank record generation.

## Data Access and Usage

The package primarily serves as a file repository. To use the data, you must locate the files on your local system after installing the package.

### Locating Data Files
Use `system.file` to retrieve the paths to the included datasets:

```r
library(RMassBankData)

# Find the root directory of the data
data_path <- system.file("spectra", package = "RMassBankData")

# List available mzML files (narcotics standards)
mzml_files <- list.files(data_path, pattern = "*.mzML", full.names = TRUE)

# Access the compound list (CSV)
compound_list <- system.file("list/list.csv", package = "RMassBankData")

# Access annotation info-lists
infolist <- system.file("infolists/infolist.csv", package = "RMassBankData")
```

### Dataset Contents
The package is organized into several directories essential for the RMassBank workflow:

- `spectra/`: LC-MS runs of 15 narcotics standards in deprofiled mzML format.
- `list/`: A CSV file containing compound information (ID, Name, SMILES, RT, etc.).
- `infolists/`: Complete CSV lists with metadata annotations for the standards.
- `infolists_incomplete/`: Partial lists used to demonstrate how RMassBank handles and downloads missing metadata.
- `results/`: Pre-calculated intermediate and final results of `msms_workflow` runs, useful for verifying outputs without re-running the full time-consuming pipeline.

## Typical Workflow Example
This data is typically passed into `RMassBank` functions to test the processing pipeline:

```r
library(RMassBank)
library(RMassBankData)

# Load the example compound list
cpd_list_path <- system.file("list/list.csv", package = "RMassBankData")
loadList(cpd_list_path)

# Define the path to the spectra for RMassBank processing
spectra_dir <- system.file("spectra", package = "RMassBankData")

# Example: Accessing a specific file for a workflow step
sample_file <- file.path(spectra_dir, "001_narcotine.mzML")
```

## Tips
- **Testing XCMS**: This package includes specific test data for XCMS integration within RMassBank.
- **Vignette Building**: If you are developing tools that extend RMassBank, use the files in the `results/` folder to provide "instant" data for documentation examples.
- **Path Handling**: Always use `system.file` rather than hardcoded paths, as the installation directory varies across systems.

## Reference documentation
- [RMassBankData Reference Manual](./references/reference_manual.md)