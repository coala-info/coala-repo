---
name: bioconductor-pd.poplar
description: This package provides annotation data and probe sequence information for the Affymetrix Poplar genome microarray. Use when user asks to analyze Poplar microarray data, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.poplar.html
---

# bioconductor-pd.poplar

name: bioconductor-pd.poplar
description: Provides annotation data for the Poplar genome array. Use when working with Affymetrix Poplar chip data in R, specifically for mapping probe identifiers to sequences and integrating with the oligo package for microarray analysis.

# bioconductor-pd.poplar

## Overview
The `pd.poplar` package is a specialized annotation platform (Platform Design package) built using `pdInfoBuilder`. It provides the necessary metadata and sequence information for analyzing Affymetrix Poplar microarray data. It is designed to work seamlessly with the `oligo` package to facilitate low-level analysis, such as preprocessing and feature-level extraction.

## Typical Workflow

### 1. Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.poplar)
```

### 2. Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, as well as Mismatch (MM) and Background (BG) sequences if applicable to the array design.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### 3. Integration with oligo
This package is a dependency for high-level functions in the `oligo` package. When you read CEL files from a Poplar array, `oligo` uses `pd.poplar` to understand the chip layout.

```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.poplar' package provides the annotation slot for this object
show(raw_data)
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (accessible via `data(pmSequence)`).
- `mmSequence`: Sequence data for mismatch probes (accessible via `data(pmSequence)`).

## Reference documentation
- [pd.poplar Reference Manual](./references/reference_manual.md)