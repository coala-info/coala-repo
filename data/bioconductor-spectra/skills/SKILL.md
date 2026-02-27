---
name: bioconductor-spectra
description: This tool provides a flexible infrastructure for managing, processing, and analyzing mass spectrometry data in R using the Spectra class and various data backends. Use when user asks to import MS data from mzML or MGF files, manipulate spectra variables, process peaks through filtering or smoothing, or create custom data backends.
homepage: https://bioconductor.org/packages/release/bioc/html/Spectra.html
---


# bioconductor-spectra

name: bioconductor-spectra
description: Expert guidance for the Bioconductor Spectra package in R. Use this skill when you need to manage, process, and analyze Mass Spectrometry (MS) data using the Spectra class and its various backends (MsBackend). This includes importing data (mzML, mzXML, MGF), manipulating spectra variables, processing peaks (filtering, smoothing, binning), and creating custom data backends.

# bioconductor-spectra

## Overview

The `Spectra` package provides a modern, flexible, and efficient infrastructure for Mass Spectrometry (MS) data in R. It uses a separation of concerns between the user-facing `Spectra` object (analysis logic) and the `MsBackend` (data storage/retrieval). This allows for "in-memory" processing for small datasets and "on-disk" or "database" processing for large-scale experiments without changing the user code.

## Core Workflows

### 1. Creating Spectra Objects
Data is typically loaded by specifying a backend.

```r
library(Spectra)

# Load from mzML files using the disk-based mzR backend
fls <- dir(system.file("extdata", package = "msdata"), full.names = TRUE, pattern = "mzML")
sps <- Spectra(fls, backend = MsBackendMzR())

# Load from a data.frame (In-memory)
df <- data.frame(msLevel = c(1L, 2L), rtime = c(1.2, 1.4))
df$mz <- list(c(100.1, 100.2), c(200.1, 200.2, 200.3))
df$intensity <- list(c(10, 20), c(30, 40, 50))
sps_mem <- Spectra(df, backend = MsBackendMemory())
```

### 2. Data Inspection and Subsetting
`Spectra` objects behave like vectors.

```r
# Basic inspection
length(sps)
spectraVariables(sps)
msLevel(sps)
rtime(sps)

# Subsetting
sps_ms2 <- sps[msLevel(sps) == 2]

# Accessing peak data (m/z and intensity)
peaksData(sps[1:2]) # Returns a list of matrices
```

### 3. Data Processing
Processing is often "lazy"—operations are cached and applied only when peak data is requested.

```r
# Filter by m/z range
sps_filt <- filterMzRange(sps, mz = c(200, 300))

# Clean and smooth
sps_proc <- sps %>%
    filterIntensity(intensity = 10) %>%
    smooth(method = "SavitzkyGolay") %>%
    pickPeaks()

# Combine spectra
sps_combined <- combineSpectra(sps, groupBy = sps$rtime)
```

## Creating Custom Backends

To create a new backend, you must extend the `MsBackend` virtual class and implement the following core methods:

1.  **`backendInitialize`**: Setup the backend (e.g., connect to DB or load files).
2.  **`length`**: Return the number of spectra.
3.  **`spectraData`**: Return a `DataFrame` of spectra variables.
4.  **`peaksData`**: Return a `List` of matrices (mz and intensity).
5.  **`[` or `extractByIndex`**: Subset the backend.
6.  **`dataStorage` / `dataOrigin`**: Track where data lives.

### Implementation Tip
If your backend is read-only, you only need to implement the "Required methods" (accessors). If it supports modification, you must also implement replacement methods like `peaksData<-` and `spectraData<-`.

## Best Practices

- **Memory Management**: For large datasets, use `MsBackendMzR` or `MsBackendSql` to avoid crashing R.
- **Parallelization**: Use `BiocParallel` parameters. `Spectra` functions often accept a `BPPARAM` argument.
- **Core Variables**: Always ensure your backend provides "core" variables (msLevel, rtime, acquisitionNum, etc.), even if they are `NA`. Use `coreSpectraVariables()` to see the list.

## Reference documentation

- [Creating new MsBackend classes](./references/MsBackend.md)
- [Spectra Package Vignette](./references/Spectra.md)
- [Large-scale Data Handling](./references/Spectra-large-scale.md)
- [MsBackend R-Markdown Source](./references/MsBackend.Rmd)
- [Spectra R-Markdown Source](./references/Spectra.Rmd)