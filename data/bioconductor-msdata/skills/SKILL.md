---
name: bioconductor-msdata
description: This package provides a collection of mass spectrometry raw data files and example datasets for testing and benchmarking Bioconductor tools. Use when user asks to access sample mass spectrometry data, locate raw mzML files for proteomics or metabolomics workflows, or load example datasets for packages like xcms and MSnbase.
homepage: https://bioconductor.org/packages/release/data/experiment/html/msdata.html
---


# bioconductor-msdata

## Overview

The `msdata` package is a specialized Bioconductor ExperimentData package that provides a variety of mass spectrometry raw data files. It serves as a central repository for small, reproducible datasets used across other Bioconductor packages like `xcms`, `mzR`, and `MSnbase`. The package includes data from various instruments (Ion Trap, FTICR, Agilent Q-TOF, AB Sciex) and experiment types (LC-MS, CE-MS, TMT proteomics, and MRM).

## Key Workflows

### Locating Data Files

The primary purpose of `msdata` is to provide file paths to raw data stored on disk.

```r
# Find the installation directory
msdata_path <- find.package("msdata")

# List files in specific subdirectories
iontrap_files <- list.files(file.path(msdata_path, "iontrap"), full.names = TRUE)
fticr_files <- list.files(file.path(msdata_path, "fticr-mzML"), full.names = TRUE)
sciex_files <- list.files(file.path(msdata_path, "sciex"), full.names = TRUE)
```

### Accessing Proteomics Datasets

The `proteomics()` function is a helper to list specific proteomics-related files (TMT, MS3, MRM).

```r
library(msdata)

# List all proteomics files
(f <- proteomics(full.names = TRUE))

# Filter for a specific experiment (e.g., MS3 TMT11)
fms3 <- proteomics(full.names = TRUE, pattern = "MS3TMT11.mzML")
```

### Loading Data into Analysis Packages

Once file paths are retrieved, they are typically passed to packages like `MSnbase` or `mzR`.

```r
library(MSnbase)

# Read a proteomics file into an MSnExp object
raw_data <- readMSData(fms3, mode = "onDisk")

# Accessing identification data
mzid_file <- ident(full.names = TRUE)
```

### Using Pre-loaded Objects

The package also contains pre-defined objects for quick testing.

```r
# Load a subset of FTICR data (xs object)
data(xs)
show(xs)
```

## Data Categories

| Directory | Description |
|-----------|-------------|
| `iontrap` | Ion Trap positive ionization (mzML). Subset 500-850 m/z. |
| `fticr-mzML` | FTICR Apex III data (mzML). Subset 400-450 m/z. |
| `proteomics` | TMT 6-plex/10-plex/11-plex, MS3 SPS, and MRM data. |
| `sciex` | AB Sciex TripleTOF 5600+ profile-mode LC-MS data. |
| `CE-MS` | Capillary Electrophoresis MS data (Agilent 6560 IM-QToF). |

## Tips for Usage

- **Full Paths**: Always use `full.names = TRUE` when listing files to ensure the analysis functions can find the files regardless of the current working directory.
- **Metadata**: For the `MS3TMT11.mzML` file, use `data(fdms3tmt11)` to get the associated feature metadata, which can be assigned to the object using `fData(ms3) <- fdms3tmt11`.
- **Identification**: Use `ident()` to find mzIdentML files and `quant()` to find quantitative data files.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)