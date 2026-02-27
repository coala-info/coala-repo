---
name: bioconductor-pd.atdschip.tiling
description: This package provides platform design information and probe sequences for the Affymetrix AGRONOMICS1 tiling array for Arabidopsis thaliana. Use when user asks to process Affymetrix tiling array data with the oligo package, retrieve probe sequences, or perform low-level preprocessing for the TAIR8 genome build.
homepage: https://bioconductor.org/packages/release/data/experiment/html/pd.atdschip.tiling.html
---


# bioconductor-pd.atdschip.tiling

name: bioconductor-pd.atdschip.tiling
description: Data package providing platform design information for the Affymetrix Atdschip_tiling (AGRONOMICS1) tiling array for Arabidopsis thaliana. Use this skill when processing Affymetrix tiling array data with the oligo package, specifically for TAIR8 genome build mapping, probe sequence retrieval, and background correction.

## Overview

The `pd.atdschip.tiling` package is an annotation resource built with `pdInfoBuilder`. It provides the necessary SQLite-based infrastructure for the `oligo` package to handle the AGRONOMICS1 tiling array for *Arabidopsis thaliana*. It maps feature identifiers (fids) to physical coordinates and probe sequences, which is essential for low-level preprocessing of .CEL files.

## Typical Workflow

### 1. Loading the Package and Data
The package is typically loaded automatically when reading CEL files with `oligo::readCelFiles()`, but can be invoked manually to inspect probe sequences.

```r
library(pd.atdschip.tiling)
library(oligo)

# Load probe sequence data
data(pmSequence)
```

### 2. Preprocessing with oligo
This package is designed to work as a backend for `oligo` functions. You do not usually call functions within `pd.atdschip.tiling` directly; instead, you pass the package name or let `oligo` detect it.

```r
# Example: Reading CEL files (assuming .CEL files are in the working directory)
# The oligo package will use pd.atdschip.tiling to understand the chip layout
raw_data <- readCelFiles(filenames = list.celfiles())

# Normalization and Summarization (RMA)
# This uses the platform design info to group probes
eset <- rma(raw_data)
```

### 3. Accessing Probe Sequences
To perform sequence-specific analysis (like GC-content bias correction), access the `pmSequence` object.

```r
# View the first few PM probe sequences
head(pmSequence)

# pmSequence is a DataFrame with 'fid' (feature ID) and 'sequence'
# Accessing specific columns:
fids <- pmSequence$fid
seqs <- pmSequence$sequence
```

## Key Objects

- **pd.atdschip.tiling**: The main annotation object containing the SQLite database connection for the chip layout.
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match (PM) probes.
- **mmSequence / bgSequence**: If available, these provide Mismatch or Background probe sequences (accessed via `data(pmSequence)`).

## Tips for Tiling Arrays
- **Genome Build**: This package is specifically mapped to the TAIR8 genome build of *Arabidopsis thaliana*. Ensure your downstream genomic coordinates match this version.
- **Memory Management**: Tiling array data can be large. Use `oligo`'s ability to handle large datasets via `ff` objects if system RAM is limited.

## Reference documentation

- [Platform Design Info for Affymetrix Atdschip_tiling](./references/reference_manual.md)