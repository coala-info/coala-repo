---
name: bioconductor-pd.soygene.1.0.st
description: This Bioconductor package provides annotation and platform design information for the Affymetrix Soygene 1.0 ST array. Use when user asks to process Soygene 1.0 ST expression data, perform RMA normalization using the oligo package, or access probe sequence information for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.soygene.1.0.st.html
---

# bioconductor-pd.soygene.1.0.st

name: bioconductor-pd.soygene.1.0.st
description: Annotation package for the Soygene 1.0 ST array. Use when processing Affymetrix Soygene 1.0 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.soygene.1.0.st

## Overview
The `pd.soygene.1.0.st` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary infrastructure to analyze Affymetrix Soygene 1.0 ST arrays. It is designed to work seamlessly with the `oligo` package to handle low-level processing, such as feature-to-genome mapping and sequence-specific adjustments.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.soygene.1.0.st)
```

### Integration with oligo
This package provides the platform design information required by the `oligo` package for preprocessing.

```r
library(oligo)

# Read CEL files (the pd package is used internally)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is useful for custom quality control or probe-effect modeling.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the array
```

### Data Structures
- **pmSequence**: A `DataFrame` object containing the probe sequences.
- **bgSequence**: Background probe sequences (if applicable).
- **mmSequence**: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure your R session has sufficient memory when loading large datasets with `oligo`.
- **Platform Matching**: This package is specific to the "Soygene 1.0 ST" array. Ensure your CEL files match this specific platform version; otherwise, `oligo` may throw an error regarding incompatible PD packages.
- **Annotation Hub**: For higher-level gene annotations (symbols, GO terms), use this package in conjunction with `biomaRt` or the specific organism annotation package (e.g., `org.Gm.eg.db` for Soybean).

## Reference documentation
- [pd.soygene.1.0.st Reference Manual](./references/reference_manual.md)