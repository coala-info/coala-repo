---
name: bioconductor-pd.nugo.hs1a520180
description: This package provides platform design and annotation data for the NuGO Human Array hs1a520180. Use when user asks to preprocess .CEL files, access probe sequences, or perform background correction and normalization for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.nugo.hs1a520180.html
---

# bioconductor-pd.nugo.hs1a520180

## Overview

The `pd.nugo.hs1a520180` package is a Bioconductor annotation package (Platform Design info) for the NuGO Human Array hs1a520180. It was built using `pdInfoBuilder` and is primarily designed to work as a backend for the `oligo` package to facilitate the preprocessing of .CEL files. It contains the mapping between feature identifiers (fids) and probe sequences.

## Usage in R

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.nugo.hs1a520180)
```

### Accessing Probe Sequences
The package provides sequence data for Perfect Match (PM) probes, and potentially Mismatch (MM) or Background (BG) probes if applicable to the array design.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
This package provides the necessary SQLite database schema for the `oligo` package to perform:
1. **Background Correction**: Using probe sequence information (e.g., RMA or GCRMA).
2. **Normalization**: Quantile normalization at the feature level.
3. **Summarization**: Mapping probes to probesets for expression calculation.

Example workflow:
```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.nugo.hs1a520180' package is used internally here:
eset <- rma(raw_data)
```

## Implementation Details
- **Storage**: Sequences are stored in a `DataFrame` object.
- **Columns**: 
    - `fid`: Feature Identifier (integer).
    - `sequence`: The actual nucleotide sequence (character).
- **Compatibility**: Designed for use with the `oligo` package. For high-level gene annotations (symbols, Entrez IDs), use the corresponding transcript-cluster or probeset-level annotation package (e.g., `nugo.hs1a520180.db`).

## Reference documentation

- [pd.nugo.hs1a520180 Reference Manual](./references/reference_manual.md)