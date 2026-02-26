---
name: bioconductor-droplettestfiles
description: The DropletTestFiles package provides raw, non-analysis-ready datasets from droplet-based technologies for testing and benchmarking purposes. Use when user asks to list available droplet datasets, download raw 10X Genomics test files, or retrieve cached data for benchmarking utilities.
homepage: https://bioconductor.org/packages/release/data/experiment/html/DropletTestFiles.html
---


# bioconductor-droplettestfiles

## Overview

The `DropletTestFiles` package provides a collection of raw, non-analysis-ready datasets from droplet-based technologies (primarily 10X Genomics). These files represent the direct output of processing pipelines like CellRanger and are intended for testing and benchmarking utilities that handle raw droplet data. The package serves as a client for `ExperimentHub`, allowing users to list available datasets and download them to a local cache.

## Core Functions

### Listing Available Files
To see all available datasets and their metadata (species, genome, file type, etc.):

```r
library(DropletTestFiles)
available_files <- listTestFiles()
# View the first few entries
head(available_files)
```

The resulting `DataFrame` contains columns such as `rdatapath` (the unique identifier for the file) and `file.name` (e.g., `raw.h5`, `filtered.tar.gz`, `mol_info.h5`).

### Downloading a Test File
To retrieve a file, use `getTestFile()`. This function returns a local file path to the cached resource.

```r
# Using a specific rdatapath from listTestFiles()
path <- getTestFile("tenx-2.0.1-nuclei_900/1.0.0/filtered.h5", prefix=TRUE)
# 'path' is now a character string pointing to the file on your disk
```

- `prefix=TRUE`: Prepends the `ExperimentHub` cache path (usually what you want).
- `prefix=FALSE`: Returns the relative path within the hub.

## Typical Workflow: Loading into SingleCellExperiment

A common use case is downloading a 10X HDF5 file and loading it into a Bioconductor object using `DropletUtils`.

```r
library(DropletTestFiles)
library(DropletUtils)

# 1. Identify and download a filtered HDF5 matrix
target_path <- "tenx-3.1.0-5k_pbmc_protein_v3/1.0.0/filtered.h5"
local_path <- getTestFile(target_path, prefix=TRUE)

# 2. Read the file into a SingleCellExperiment object
sce <- read10xCounts(local_path, type="HDF5")

# 3. Inspect the object
sce
```

## Tips for Usage

- **File Types**: The package includes various formats:
    - `.h5`: HDF5 feature-barcode matrices.
    - `.tar.gz`: Compressed folders containing MTX files, barcodes, and features.
    - `mol_info.h5`: Molecule information files used for calculating ambient RNA or barcode rank plots.
- **Read-Only**: The paths returned by `getTestFile()` point to the `ExperimentHub` cache. These files should be treated as read-only.
- **Caching**: Once a file is downloaded, it is stored locally. Subsequent calls to `getTestFile()` for the same resource will be instantaneous and will not require an internet connection.

## Reference documentation
- [Motivation](./references/motivation.md)