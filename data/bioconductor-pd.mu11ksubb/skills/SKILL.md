---
name: bioconductor-pd.mu11ksubb
description: This package provides platform design information and probe sequences for the Affymetrix Mu11KsubB microarray. Use when user asks to preprocess Mu11KsubB CEL files, access probe sequence data, or provide a backend for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mu11ksubb.html
---


# bioconductor-pd.mu11ksubb

## Overview
The `pd.mu11ksubb` package is a Bioconductor annotation interface built with `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Mu11KsubB array. This package is primarily intended to be used as a backend for the `oligo` package to enable the preprocessing and analysis of .CEL files.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.mu11ksubb)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific background correction or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the chip
```

### Integration with oligo
When analyzing Mu11KsubB data, ensure this package is installed so `oligo` can correctly map features:

```r
library(oligo)

# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.mu11ksubb' package provides the annotation slot for 'raw_data'
# This allows for RMA normalization or other preprocessing
eset <- rma(raw_data)
```

## Data Objects
- **pmSequence**: A `DataFrame` object containing the sequences for the PM probes. It includes:
  - `fid`: Feature identifier.
  - `sequence`: The actual nucleotide sequence.
- **bgSequence / mmSequence**: Depending on the specific build, these may be mapped to the same sequence data object for background or mismatch probes if applicable to the platform design.

## Tips
- This package is a "Platform Design" (pd) package. It does not contain gene-level annotations (like symbols or GO terms); for those, use the corresponding high-level annotation package (e.g., `mu11ksubb.db`) after summarization.
- Ensure the version of `pd.mu11ksubb` matches the Bioconductor release of your `oligo` package to avoid compatibility issues.

## Reference documentation
- [pd.mu11ksubb Reference Manual](./references/reference_manual.md)