---
name: bioconductor-mzr
description: This tool provides a low-level interface to access and parse raw mass spectrometry and identification data files. Use when user asks to read MS spectra, extract chromatograms, or parse peptide-spectrum matches from mzML, mzXML, or mzIdentML files.
homepage: https://bioconductor.org/packages/release/bioc/html/mzR.html
---


# bioconductor-mzr

name: bioconductor-mzr
description: Access and parse raw mass spectrometry (mzXML, mzML, mzData, netCDF) and identification (mzIdentML) data. Use this skill when you need to read MS spectra, chromatograms, or peptide-spectrum matches (PSMs) for downstream analysis in R.

# bioconductor-mzr

## Overview
The `mzR` package provides a low-level R interface to common mass spectrometry file formats. It uses C++ backends (primarily ProteoWizard) to enable fast, memory-efficient, random access to data without loading entire files into memory. It is the foundational parser for higher-level packages like `xcms` and `MSnbase`.

## Core Workflows

### Working with Raw MS Data (mzML, mzXML, mzData)
1. **Open File**: Use `openMSfile(filename)` to create an `mzR` object.
2. **Inspect Metadata**:
   - `runInfo(object)`: Summary of scans, MS levels, and time range.
   - `instrumentInfo(object)`: Details on hardware and software.
   - `header(object, index)`: Metadata for specific scans (retention time, precursor MZ, etc.).
3. **Extract Peaks**: Use `peaks(object, index)` to get a matrix of m/z and intensity values.
4. **Extract Chromatograms**: Use `chromatogram(object)` (requires `pwiz` backend).
5. **Close File**: Always use `close(object)` to release system resources.

### Working with Identification Data (mzIdentML)
1. **Open File**: Use `openIDfile(filename)`.
2. **Inspect Metadata**: Use `mzidInfo(object)` for software and search parameters.
3. **Extract PSMs**: Use `psms(object)` to get a data frame of peptide-spectrum matches.
4. **Extract Scores**: Use `score(object)` to see search-engine specific scores.
5. **Extract Modifications**: Use `modifications(object)` for peptide modification details.

## Key Functions

| Function | Description |
|----------|-------------|
| `openMSfile()` | Opens a raw data file (mzML, mzXML, netCDF). |
| `openIDfile()` | Opens an identification file (mzIdentML). |
| `header()` | Returns a data frame with scan-level metadata. |
| `peaks()` | Returns m/z and intensity matrices for one or more scans. |
| `runInfo()` | Returns global run parameters (scan count, etc.). |
| `psms()` | Returns peptide-spectrum matches from ID files. |
| `close()` | Closes the file handle and clears the C++ backend cache. |

## Usage Tips
- **Memory Efficiency**: `mzR` does not load the whole file. Access only the specific scan indices you need using `peaks(object, i)`.
- **Backend Selection**: The `pwiz` backend is the default and most robust for `mzML`. Use `backend = "netCDF"` specifically for CDF files.
- **Developer Note**: If you need high-level data manipulation (e.g., filtering by RT or MZ), consider using `MSnbase` or `Spectra` packages, which wrap `mzR`.
- **Closing Handles**: If you encounter "too many open files" errors, ensure every `openMSfile` call has a corresponding `close` call.

## Reference documentation
- [A parser for raw and identification mass-spectrometry data](./references/mzR.Rmd)
- [A parser for raw and identification mass-spectrometry data](./references/mzR.md)