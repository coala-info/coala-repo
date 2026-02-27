---
name: bioconductor-msbackendrawfilereader
description: This tool provides a backend for the Spectra package to enable direct access and processing of Thermo Fisher Scientific RAW mass spectrometry files. Use when user asks to read Thermo RAW files, filter scans using native filter strings, access mass spectrometry metadata, or export RAW data to MGF format.
homepage: https://bioconductor.org/packages/release/bioc/html/MsBackendRawFileReader.html
---


# bioconductor-msbackendrawfilereader

## Overview

`MsBackendRawFileReader` is a Bioconductor package that provides a backend for the `Spectra` package, allowing direct access to Thermo Fisher Scientific RAW files. It leverages the NewRawFileReader .Net libraries (via the `rawrr` package) to provide high-performance access to mass spectrometry data, including metadata and peak information, without requiring conversion to open formats like mzML.

## Installation and Requirements

The backend requires specific DLLs to interface with the Thermo libraries.

```r
# Install required DLLs (run once)
rawrr::installRawFileReaderDLLs()

# Ensure the execution environment is ready
if (isFALSE(file.exists(rawrr:::.rawrrAssembly()))){
  rawrr::installRawrrExe()
}
```

## Loading Data

The package follows the standard `Spectra` initialization pattern. **Note:** Files must have the `.raw` extension.

```r
library(Spectra)
library(MsBackendRawFileReader)

# Define raw file paths
fls <- c("sample1.raw", "sample2.raw")

# Initialize the backend
beRaw <- backendInitialize(MsBackendRawFileReader(), files = fls)

# Create a Spectra object
s <- Spectra(beRaw)
```

## Key Workflows

### Filtering Scans
The package provides a `filterScan` method that uses Thermo's native scan filter strings (e.g., "FTMS + c NSI Full ms2").

```r
# Filter for specific scan types using Thermo filter strings
hcd_spectra <- s |>
  filterScan("FTMS + c NSI Full ms2 487.2567@hcd27.00")

# Access specific spectra by index
target_spectrum <- hcd_spectra[437]
```

### Accessing Spectra Variables
The backend provides access to a wide range of Thermo-specific metadata.

```r
# List available variables
spectraVariables(beRaw)

# Common variables:
# "msLevel", "rtime", "scanIndex", "precursorMz", "energy", 
# "isolationWindowTargetMz", "scanType", "AGC", "injectionTime"
```

### Exporting to MGF
You can export RAW data to Mascot Generic Format (MGF) for database searching, mapping `Spectra` variables to MGF tags.

```r
library(MsBackendMgf)

# Define mapping for Mascot compatibility
map <- c(custom = "TITLE",
         msLevel = "CHARGE",
         scanIndex = "SCANS",
         precursorMz = "PEPMASS",
         rtime = "RTINSECONDS")

# Add a custom title
s$custom <- paste0("File: ", s$dataOrigin, " ; Scan: ", s$scanIndex)

# Export
export(s, backend = MsBackendMgf(), file = "output.mgf", map = map)
```

### Data Processing
You can add custom functions to the `Spectra` processing queue. A common task is filtering for the top N peaks in a mass window.

```r
# Use the internal top_n function to keep the most intense peak per 100 Da window
s_filtered <- addProcessing(s, MsBackendRawFileReader:::.top_n, n = 1, mass_window = 100)

# Compare original vs filtered
plotSpectraMirror(s[1], s_filtered[1])
```

## Tips and Best Practices

1.  **File Extensions:** The underlying libraries are strict; ensure your files end in `.raw` (case-insensitive, but `.raw` is standard).
2.  **Parallel Processing:** Use `BiocParallel` for faster I/O when dealing with many files or large datasets.
3.  **Memory Efficiency:** `MsBackendRawFileReader` is an "on-disk" backend. It only loads peak data into memory when requested (e.g., via `peaksData()` or `intensity()`), making it suitable for very large experiments.
4.  **Scan Types:** Use `beRaw$scanType` to see the full filter strings, which is helpful for constructing precise `filterScan` calls.

## Reference documentation

- [MsBackendRawFileReader](./references/MsBackendRawFileReader.md)