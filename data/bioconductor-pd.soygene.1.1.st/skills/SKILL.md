---
name: bioconductor-pd.soygene.1.1.st
description: This Bioconductor package provides platform design and sequence information for the Affymetrix Soygene 1.1 ST array. Use when user asks to process Soygene 1.1 ST expression data, map probe identifiers to sequences, or provide platform design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.soygene.1.1.st.html
---

# bioconductor-pd.soygene.1.1.st

name: bioconductor-pd.soygene.1.1.st
description: Annotation package for the Soygene 1.1 ST array. Use when processing Affymetrix Soygene 1.1 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform design information for the oligo package.

# bioconductor-pd.soygene.1.1.st

## Overview
The `pd.soygene.1.1.st` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Soygene 1.1 ST array. This package is primarily designed to work as a backend for the `oligo` package to enable the preprocessing and analysis of Affymetrix ST (Sense Target) arrays for soybean (Glycine max).

## Usage in R

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.soygene.1.1.st)
```

### Integration with oligo
The most common workflow involves using this package to provide the annotation environment for `FeatureSet` objects:

```r
library(oligo)

# Read CEL files (pd.soygene.1.1.st must be installed)
raw_data <- read.celfiles(filenames = list.celfiles())

# The platform design is automatically linked
show(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific background correction methods or probe-level analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature identifier in the platform design
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the actual nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (if available).
- `mmSequence`: Sequence data for Mismatch probes (if available).

## Workflow Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Installation**: If the package is missing, install it via BiocManager: `BiocManager::install("pd.soygene.1.1.st")`.
- **Compatibility**: This package is specifically for the "1.1.st" version of the Soygene array. Ensure your CEL files match this specific platform design.

## Reference documentation
- [pd.soygene.1.1.st Reference Manual](./references/reference_manual.md)