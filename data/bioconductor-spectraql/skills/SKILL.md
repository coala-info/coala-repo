---
name: bioconductor-spectraql
description: The SpectraQL package implements Mass Spec Query Language support for Spectra objects to enable complex mass spectrometry data filtering and extraction. Use when user asks to query mass spectrometry data using MassQL, filter spectra by retention time or precursor m/z, or extract ion chromatograms and scan information.
homepage: https://bioconductor.org/packages/release/bioc/html/SpectraQL.html
---

# bioconductor-spectraql

## Overview

The `SpectraQL` package implements support for the Mass Spec Query Language (MassQL) for `Spectra` objects in R. It allows users to perform complex mass spectrometry data filtering and extraction using a domain-specific language that is more concise than standard R filtering chains. It translates MassQL strings into optimized operations on `Spectra` backends.

## Core Workflow

### 1. Data Preparation
MassQL queries are executed against `Spectra` objects. Ensure you have the necessary backends loaded (e.g., `MsBackendMzR` for mzML files).

```r
library(Spectra)
library(SpectraQL)
library(MsDataHub)

# Load example data
fl <- MsDataHub::PestMix1_DDA.mzML()
dda <- Spectra(fl)
```

### 2. Executing Queries
The primary function is `query(object, query, ...)`.

**Basic Syntax:**
`"QUERY <type> WHERE <condition> AND <condition> FILTER <filter>"`

*   **Type**: `*` (returns `Spectra`), `MS1DATA`/`MS2DATA` (returns list of peak matrices), `scaninfo(*)` (returns `spectraData` DataFrame), or `scansum(*)` (returns TIC/intensities).
*   **Conditions (WHERE)**: Subsets the spectra (e.g., `RTMIN`, `RTMAX`, `MS2PREC`, `CHARGE`, `POLARITY`).
*   **Filters (FILTER)**: Subsets the peaks within the selected spectra (e.g., `MS1MZ`, `MS2MZ`).

### 3. Common Query Examples

**Filter by Retention Time (in seconds):**
```r
# Get Spectra between 200 and 300 seconds
res <- query(dda, "QUERY * WHERE RTMIN = 200 AND RTMAX = 300")
```

**Filter by Precursor m/z with Tolerance:**
```r
# Use TOLERANCEPPM or TOLERANCEMZ
res <- query(dda, "QUERY * WHERE MS2PREC = 278.093:TOLERANCEPPM=30")
```

**Extract Total Ion Chromatogram (TIC):**
```r
# Returns a numeric vector of summed intensities
tic <- query(dda, "QUERY SCANSUM(MS1DATA)")
```

**Extract Extracted Ion Chromatogram (XIC):**
```r
# Combine WHERE (spectra selection) and FILTER (peak selection)
xic <- query(dda, "QUERY SCANSUM(MS1DATA) WHERE RTMIN = 235 AND RTMAX = 250 FILTER MS1MZ = 219.095:TOLERANCEMZ=0.1")
```

**Multiple m/z Values (OR logic):**
```r
res <- query(dda, "QUERY * WHERE MS1MZ = (123 OR 234.1 OR 300):TOLERANCEMZ=0.05")
```

## Key Implementation Details

*   **Case Insensitivity**: `SpectraQL` is case insensitive (e.g., `QUERY` and `query` are both valid).
*   **Retention Time Units**: Unlike standard MassQL (minutes), `SpectraQL` uses **seconds** for `RTMIN` and `RTMAX`.
*   **Default Tolerance**: The default `TOLERANCEMZ` is `0` (exact match) unless specified.
*   **Neutral Loss**: Use `MS2NL` to query for specific neutral losses from the precursor.
*   **Output Types**:
    *   `QUERY *`: Returns a `Spectra` object.
    *   `QUERY MS1DATA`: Returns a `list` of m/z-intensity matrices.
    *   `QUERY SCANINFO(*)`: Returns a `DataFrame`.

## Reference documentation

- [Mass Spec Query Language Support to the Spectra Package](./references/SpectraQL.Rmd)
- [Mass Spec Query Language Support to the Spectra Package](./references/SpectraQL.md)