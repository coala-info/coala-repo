---
name: bioconductor-pd.ovigene.1.0.st
description: This Bioconductor package provides annotation data and platform design information for the Ovigene 1.0 ST microarray. Use when user asks to process Ovigene 1.0 ST expression data, map probe identifiers to sequences, or perform microarray normalization with the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ovigene.1.0.st.html
---

# bioconductor-pd.ovigene.1.0.st

name: bioconductor-pd.ovigene.1.0.st
description: Annotation package for the Ovigene 1.0 ST array. Use when processing Affymetrix/Ovigene ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.ovigene.1.0.st

## Overview

The `pd.ovigene.1.0.st` package is a Bioconductor annotation data package specifically designed for the Ovigene 1.0 ST array. It is built using `pdInfoBuilder` and is intended to be used as a backend for the `oligo` package to facilitate the preprocessing and analysis of microarrays. It contains the necessary mapping between feature identifiers (fids) and probe sequences.

## Usage in R

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.ovigene.1.0.st)
```

### Accessing Probe Sequences
The package provides sequence data for Perfect Match (PM) probes. This is useful for sequence-specific background correction or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
fids <- pmSequence$fid
seqs <- pmSequence$sequence
```

### Integration with oligo
This package serves as the "platform design" (pd) object. When working with an `ExpressionFeatureSet` or `FeatureSet` object in `oligo`, the functions will look for this package to understand the chip layout.

```r
library(oligo)

# Example workflow:
# 1. Read CEL files (oligo will identify pd.ovigene.1.0.st automatically)
# rawData <- read.celfiles(filenames)

# 2. Perform RMA normalization
# eset <- rma(rawData)
```

## Data Structures
- **pmSequence**: A `DataFrame` object containing:
  - `fid`: Feature identifier (integer).
  - `sequence`: The nucleotide sequence of the probe (character).
- **bgSequence / mmSequence**: Depending on the specific array design, background or mismatch sequences may be mapped via the same internal mechanisms as `pmSequence`.

## Reference documentation

- [pd.ovigene.1.0.st Reference Manual](./references/reference_manual.md)