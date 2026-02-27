---
name: bioconductor-pd.mg.u74av2
description: This package provides annotation data and chip layout metadata for the Affymetrix Murine Genome U74A version 2 microarray platform. Use when user asks to process MG_U74Av2 CEL files, map probes to sequences, or perform low-level preprocessing and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74av2.html
---


# bioconductor-pd.mg.u74av2

name: bioconductor-pd.mg.u74av2
description: Annotation data package for the Affymetrix MG_U74Av2 (Murine Genome U74A version 2) platform. Use when processing MG_U74Av2 microarray data with the 'oligo' or 'pdInfoBuilder' packages to map probes to sequences and manage chip layout metadata.

# bioconductor-pd.mg.u74av2

## Overview
The `pd.mg.u74av2` package is a specialized Bioconductor annotation resource for the Affymetrix Murine Genome U74A v2 array. It provides the SQLite-based infrastructure required by the `oligo` package to perform low-level preprocessing, such as background correction and normalization, on CEL files. It specifically contains probe sequence information and physical mapping for Perfect Match (PM) and Mismatch (MM) probes.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be invoked manually:

```r
library(pd.mg.u74av2)
```

### 2. Accessing Probe Sequences
The package stores sequence data for PM, MM, and background probes in a `DataFrame` format.

```r
# Load the sequence data
data(pmSequence)

# View the first few entries (fid: feature ID, sequence: nucleotide sequence)
head(pmSequence)
```

### 3. Integration with oligo
This package is a dependency for high-level analysis. When analyzing MG_U74Av2 arrays, ensure this package is installed so `oligo` can identify the chip topology.

```r
library(oligo)

# Example: Reading CEL files (assuming .CEL files are in the working directory)
# The pd.mg.u74av2 package will be used to provide the platform design
raw_data <- read.celfiles(filenames = list.celfiles())

# Summarize expression (RMA)
eset <- rma(raw_data)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **mmSequence**: A `DataFrame` containing the sequences for Mismatch probes (if applicable).
- **bgSequence**: A `DataFrame` containing sequences for background/control probes.

## Usage Tips
- **Memory Management**: These annotation objects can be large. Only load `pmSequence` if you are performing sequence-specific analysis (e.g., GC-content effect modeling).
- **Platform Verification**: Ensure your CEL files are specifically for the "MG_U74Av2" version, as using this package with version 1 (MG_U74A) or other variants will result in incorrect mapping.

## Reference documentation
- [pd.mg.u74av2 Reference Manual](./references/reference_manual.md)