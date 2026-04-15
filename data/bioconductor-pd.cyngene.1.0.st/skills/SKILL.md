---
name: bioconductor-pd.cyngene.1.0.st
description: This package provides annotation and platform design data for the Cyngene 1.0 ST microarray. Use when user asks to process raw CEL files, perform RMA normalization on Cyngene ST data, or access probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cyngene.1.0.st.html
---

# bioconductor-pd.cyngene.1.0.st

name: bioconductor-pd.cyngene.1.0.st
description: Annotation package for the Cyngene 1.0 ST array. Use when processing Affymetrix/Cyngene ST (Gene 1.0 ST) microarray data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.cyngene.1.0.st

## Overview
The `pd.cyngene.1.0.st` package is a Bioconductor annotation data package. It provides the necessary infrastructure to process and analyze Cyngene 1.0 ST microarrays. It is primarily designed to work as a backend for the `oligo` package, enabling the preprocessing (normalization, background correction, and summarization) of raw CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.cyngene.1.0.st)
```

### Integration with oligo
The most common workflow involves using this package to provide the platform design information for feature-level preprocessing:
```r
library(oligo)

# Read CEL files (the package will be used automatically if the platform is detected)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for the Perfect Match (PM) probes. This is useful for custom sequence-based analysis or quality control.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences
# 'fid' corresponds to the feature identifier on the array
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Automatic Detection**: You do not usually need to call functions within `pd.cyngene.1.0.st` directly. The `oligo` package uses the `pdInfoBuilder` infrastructure to identify this package based on the header of the CEL files.
- **Memory Management**: Annotation packages can be large. Ensure your R session has sufficient memory when performing summarization on large datasets.
- **Platform Specifics**: This package is specific to the 1.0 ST (Sense Target) architecture, which differs from older 3' IVT designs.

## Reference documentation
- [pd.cyngene.1.0.st Reference Manual](./references/reference_manual.md)