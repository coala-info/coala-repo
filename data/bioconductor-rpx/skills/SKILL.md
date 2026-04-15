---
name: bioconductor-rpx
description: This tool provides programmatic access to proteomics data and metadata from the ProteomeXchange repository. Use when user asks to search for datasets, inspect project metadata, list available files, or download proteomics data using ProteomeXchange identifiers.
homepage: https://bioconductor.org/packages/release/bioc/html/rpx.html
---

# bioconductor-rpx

name: bioconductor-rpx
description: Programmatic access to proteomics data from the ProteomeXchange repository. Use this skill to search for, metadata-inspect, and download proteomics datasets (e.g., mzML, fasta, mzTab files) using ProteomeXchange (PXD) identifiers.

# bioconductor-rpx

## Overview

The `rpx` package provides an R interface to the ProteomeXchange central repository, allowing users to retrieve proteomics data and metadata programmatically. It primarily interacts with the PRIDE database but is designed to support additional repositories. The package uses `BiocFileCache` to manage downloads, ensuring that data is only transferred once and retrieved from a local cache in subsequent sessions.

## Core Workflow

### 1. Initialize a Dataset
The central class is `PXDataset`. Create an instance by providing a ProteomeXchange identifier (e.g., "PXD000001").

```r
library(rpx)
px <- PXDataset("PXD000001")
px
```

### 2. Inspect Metadata
Use accessor functions to extract project details:

*   `pxid(px)`: Returns the experiment identifier.
*   `pxurl(px)`: Returns the remote FTP/HTTP URL for the data files.
*   `pxtax(px)`: Returns the species/taxonomy information.
*   `pxref(px)`: Returns bibliographic references associated with the project.

### 3. List and Filter Files
To see all files available in the project, use `pxfiles()`. This returns a list of filenames and indicates if they are already available locally (cached).

```r
# List all files
files <- pxfiles(px)

# Filter for specific file types (e.g., fasta)
fasta_files <- grep("fasta", pxfiles(px), value = TRUE)
```

### 4. Download Data
Use `pxget()` to download files. You can specify files by name, index, or use `"all"`.

```r
# Download a specific file
local_path <- pxget(px, "erwinia_carotovora.fasta")

# The returned object is the local path to the cached file
library(Biostrings)
readAAStringSet(local_path)
```

## Caching and Maintenance
`rpx` automatically manages data via `BiocFileCache`. 
*   Files are stored in a default package cache (usually `~/.cache/R/rpx`).
*   If a file is already in the cache, `pxget()` retrieves the local path immediately without re-downloading.
*   Use `?rpxCache` to learn how to define custom cache locations or manage existing entries.

## Tips for Efficient Usage
*   **Partial Downloads**: Proteomics datasets can be massive (TB scale). Always use `pxfiles()` first to identify only the specific files (e.g., mzTab or fasta) needed for your analysis rather than downloading the entire project.
*   **Interactive Selection**: If you call `pxget(px)` without a file list, it will provide an interactive menu in the R console for file selection.
*   **Integration**: Combine `rpx` with `MSnbase`, `Spectra`, or `mzR` to process the downloaded mass spectrometry data files.

## Reference documentation
- [An R interface to the ProteomeXchange repository](./references/rpx.Rmd)
- [An R interface to the ProteomeXchange repository (Markdown version)](./references/rpx.md)