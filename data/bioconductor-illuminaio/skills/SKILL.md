---
name: bioconductor-illuminaio
description: This tool provides low-level parsing of Illumina IDAT files from expression and genotyping microarrays to extract raw intensity data and metadata. Use when user asks to read IDAT files, extract bead summaries, or parse raw data from Illumina microarrays without proprietary software.
homepage: https://bioconductor.org/packages/release/bioc/html/illuminaio.html
---


# bioconductor-illuminaio

name: bioconductor-illuminaio
description: Low-level parsing of Illumina IDAT files from expression and genotyping microarrays. Use this skill when you need to extract raw intensity data, bead summaries, and metadata from .idat files without relying on proprietary software like GenomeStudio.

## Overview

The `illuminaio` package provides a high-performance, cross-platform interface for reading Illumina IDAT files. It handles both encrypted expression IDATs (by decrypting them to XML and parsing) and genotyping IDATs. It is designed as a foundational tool for developers of downstream analysis packages (like `minfi` or `limma`) to access the full range of information stored in the binary files.

## Core Workflow

### 1. Loading the Package
```R
library(illuminaio)
```

### 2. Reading IDAT Files
The primary function is `readIDAT()`. It automatically detects the file format (Expression vs. Genotyping) and calls the appropriate internal routine.

```R
# Provide the path to a single .idat file
idat_data <- readIDAT("path/to/sample_Grn.idat")
```

### 3. Inspecting the Output
The function returns a list. The structure varies depending on the array type:

*   **Expression Arrays:** Typically contains `Barcode`, `Section`, `ChipType`, `RunInfo`, and `Quants`.
*   **Genotyping Arrays:** Contains more fields including `fileSize`, `versionNumber`, `nFields`, `nSNPsRead`, `Quants`, `MidBlock`, `RedGreen`, and `Unknowns`.

### 4. Accessing Intensity Data
The summarized bead data is stored in the `Quants` element, usually as a data frame or matrix.

```R
# Extract the summary table
quants <- idat_data$Quants

# View the first few rows
head(quants)
```

## Data Field Interpretation

### Expression IDAT Fields
The column names in `Quants` for expression arrays are derived from the internal XML and differ from GenomeStudio labels:
- **CodesBinData / IllumicodeBinData**: Probe ID (corresponds to `ProbeID`).
- **MeanBinData**: Mean intensity of non-outlying beads (corresponds to `AVG_Signal`).
- **NumGoodBeadsBinData**: Number of beads not classed as outliers (corresponds to `NBEADS`).
- **DevBinData**: Standard deviation of intensity (can be used to calculate `BEAD_STDERR`).
- **MedianBinData**: Median intensity of non-outlying beads.
- **TrimmedMeanBinData**: Trimmed mean intensity.
- **BackgroundBinData / BackgroundDevBinData**: Background intensity metrics.

### Genotyping IDAT Fields
Genotyping arrays use more standard naming conventions:
- **Mean**: Average intensity.
- **SD**: Standard deviation.
- **NBeads**: Number of beads.

## Tips and Best Practices

- **Control Probes**: `readIDAT()` extracts all data, including internal Illumina control probes that are often hidden in GenomeStudio. If comparing to GenomeStudio exports, you may need to filter these out.
- **Batch Effects**: Use the `RunInfo` slot to check scan dates and software versions, which are critical for identifying potential batch effects in large studies.
- **Memory Efficiency**: `illuminaio` is optimized for speed and memory, but reading hundreds of IDAT files simultaneously can be resource-intensive. Process files in a loop or use parallelization if memory allows.
- **File Extensions**: Ensure you are pointing to the `.idat` file. For dual-channel arrays (like Infinium), you must read the `_Grn.idat` and `_Red.idat` files separately.

## Reference documentation

- [Encrypted IDAT Format](./references/EncryptedFormat.md)
- [illuminaio: Importing Data from Illumina BeadArray Platforms](./references/illuminaio.md)