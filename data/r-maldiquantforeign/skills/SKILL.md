---
name: r-maldiquantforeign
description: This tool provides import and export routines for mass spectrometry data in R using the MALDIquantForeign package. Use when user asks to read or write various mass spectrometry file formats, import spectra or peak lists into MALDIquant objects, or export processed results to formats like mzML, imzML, and CSV.
homepage: https://cloud.r-project.org/web/packages/MALDIquantForeign/index.html
---

# r-maldiquantforeign

name: r-maldiquantforeign
description: Import and export routines for mass spectrometry data in R using the MALDIquantForeign package. Use this skill when you need to read or write various MS file formats (Bruker fid, mzXML, mzML, imzML, Analyze 7.5, CDF, CSV, etc.) into MALDIquant objects for analysis.

# r-maldiquantforeign

## Overview
The `MALDIquantForeign` package provides the essential connectivity between raw mass spectrometry data files and the `MALDIquant` analysis framework. It supports a wide range of proprietary and open standard formats, allowing users to import spectra or peak lists and export processed results.

## Installation
To install the package from CRAN:
```R
install.packages("MALDIquantForeign")
```

## Core Workflows

### 1. Importing Data
The package provides a high-level `import()` function that attempts to auto-detect file formats, as well as format-specific functions.

**Auto-detection:**
```R
library(MALDIquantForeign)
# Import a single file or a directory
spectra <- import("path/to/data/")
```

**Format-Specific Imports:**
Use these when the file format is known or auto-detection fails:
- `importBrukerFlex()`: Bruker Daltonics *flex-series (fid)
- `importMzMl()`: mzML files
- `importMzXml()`: mzXML files
- `importImzMl()`: imzML (imaging MS) files
- `importAnalyze()`: Analyze 7.5 files
- `importCiphergenXml()`: Ciphergen XML
- `importCsv()` / `importTab()`: Text-based formats

**Importing Peak Lists (Centroided Data):**
By default, `import` assumes profile data (MassSpectrum objects). To import peak lists as `MassPeaks` objects, set `centroided=TRUE`.
```R
peaks <- import("peaks.csv", centroided=TRUE)
```

### 2. Exporting Data
Export `MassSpectrum` or `MassPeaks` objects back to disk.

**Single Object Export:**
```R
export(spectra[[1]], file="output.mzML", type="mzML")
```

**Batch Export:**
To export a list of spectra to a directory, use the `path` argument and `force=TRUE` to create the directory if it doesn't exist.
```R
export(spectra, path="processed_data", type="csv", force=TRUE)
```

### 3. Supported Formats
To see a list of all supported import and export formats on your current system:
```R
supportedFileFormats()
```

## Tips and Best Practices
- **Compressed Files:** `MALDIquantForeign` natively supports `.zip`, `.tar.gz`, `.tar.bz2`, and `.tar.xz` archives.
- **Remote Files:** You can pass URLs directly to the `import` functions to download and read data from web repositories.
- **Verbose Output:** Use `verbose=FALSE` in import/export functions to suppress progress messages during batch processing.
- **Metadata:** The import functions attempt to preserve metadata (e.g., file path, sample name) within the `MALDIquant` objects.

## Reference documentation
- [MALDIquantForeign: Import/Export Routines for 'MALDIquant'](./references/MALDIquantForeign-intro.md)