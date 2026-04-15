---
name: bioconductor-rawrr
description: This tool provides direct access to Thermo Fisher Scientific Orbitrap raw mass spectrometry data in R without requiring file conversion. Use when user asks to read spectral data, extract chromatograms like TIC or XIC, or access instrument-specific metadata from .raw files.
homepage: https://bioconductor.org/packages/release/bioc/html/rawrr.html
---

# bioconductor-rawrr

name: bioconductor-rawrr
description: Access and analyze Thermo Fisher Scientific Orbitrap raw mass spectrometry data directly in R. Use this skill when you need to read spectral data, extract chromatograms (TIC, BPC, XIC), or access instrument-specific metadata (AGC, resolution, charge) from .raw files without converting them to mzML.

# bioconductor-rawrr

## Overview

The `rawrr` package provides direct access to proprietary Thermo Fisher Scientific raw files using the .NET `RawFileReader` API. It allows R users to bypass data conversion steps, preserving Orbitrap-specific diagnostic information. The package uses two primary S3 objects: `rawrrSpectrum` (for individual scans) and `rawrrChromatogram` (for intensity traces over time).

## Installation and Setup

Before first use, the package requires the installation of the `rawrr` executable and assemblies:

```R
rawrr::installRawrrExe()
```

## Core Functions

| Function | Purpose | Returns |
| --- | --- | --- |
| `readFileHeader()` | Get instrument model, scan count, and time range. | `list` |
| `readIndex()` | Generate a table of all scans with metadata. | `data.frame` |
| `readSpectrum()` | Extract specific scans by scan number. | `rawrrSpectrumSet` |
| `readChromatogram()` | Extract TIC, BPC, or XIC traces. | `rawrrChromatogramSet` |
| `readTrailer()` | Access scan-specific trailer values. | `vector` |

## Typical Workflows

### 1. Exploring File Metadata
Use `readFileHeader` for a high-level summary and `readIndex` to understand the experimental design (e.g., MS levels, precursor masses).

```R
header <- rawrr::readFileHeader("data.raw")
idx <- rawrr::readIndex("data.raw")

# Filter for MS2 scans of a specific precursor
ms2_scans <- subset(idx, MSOrder == "Ms2" & precursorMass > 487 & precursorMass < 488)
```

### 2. Reading and Plotting Spectra
`readSpectrum` retrieves intensity and m/z vectors. The `plot` method can display centroided data with resolution and charge annotations.

```R
S <- rawrr::readSpectrum(rawfile = "data.raw", scan = c(9594, 9595))

# Plot with diagnostic info and signal-to-noise ratio
plot(S[[1]], centroid = TRUE, SN = TRUE, diagnostic = TRUE)

# Access specific attributes using accessors
rawrr::scanNumber(S[[1]])
rawrr::precursorMass(S[[1]])
```

### 3. Chromatogram Extraction (XIC)
Extract Ion Chromatograms (XIC) for specific masses with a parts-per-million (ppm) tolerance.

```R
# Define target masses
targets <- c(487.2571, 547.2984)
names(targets) <- c("Pep1", "Pep2")

# Extract XIC from MS1 scans
C <- rawrr::readChromatogram("data.raw", mass = targets, tol = 10, type = "xic", filter = "ms")
plot(C, diagnostic = TRUE)
```

### 4. Custom Metadata Access
If a specific instrument parameter is not available via a standard accessor, use `makeAccessor` to create one based on the API key.

```R
# Create accessor for Maximum Injection Time
maxIonTime <- rawrr::makeAccessor(key = "Max. Ion Time (ms):", returnType = "double")
maxIonTime(S[[1]])
```

## Tips and Best Practices

- **Performance**: For large batches of files, use `parallel::mclapply` on scan indices to speed up data extraction.
- **Filtering**: When using `readChromatogram`, providing a specific `filter` string (e.g., "FTMS + c NSI Full ms2...") significantly speeds up the API call by narrowing the search space.
- **Data Types**: Always prefer accessor functions (e.g., `scanNumber()`) over direct list subsetting (e.g., `$scan`) to ensure proper type casting from the underlying character data returned by the API.
- **Windows Users**: Ensure the system decimal symbol is set to `.` to avoid parsing errors where m/z and intensity vectors appear to have different lengths.

## Reference documentation

- [The rawrr R package - Direct Access to Orbitrap Data and Beyond](./references/rawrr.md)