---
name: bioconductor-pd.canine
description: This package provides platform design and annotation data for the Affymetrix Canine genome microarray. Use when user asks to preprocess canine CEL files, map probe IDs to sequences, or manage platform design information for dog expression arrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.canine.html
---


# bioconductor-pd.canine

name: bioconductor-pd.canine
description: Annotation package for the Canine (Dog) genome array. Use this skill when working with Affymetrix Canine expression microarrays in R, specifically for preprocessing raw CEL files using the oligo package, mapping probe IDs to sequences, and managing platform design information.

# bioconductor-pd.canine

## Overview
The `pd.canine` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Canine GeneChip. It is primarily designed to work as a backend database for the `oligo` package to enable the preprocessing (background correction, normalization, and summarization) of canine-specific microarray data.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.canine")
```

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.canine)
```

### 2. Integration with oligo
When analyzing Canine CEL files, `oligo` uses this package to identify probe locations and types.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.canine' package is used internally here to 
# provide the chip layout for RMA or other algorithms
eset <- rma(raw_data)
```

### 3. Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is useful for sequence-specific analysis or re-annotation.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the platform design
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: Annotation packages like `pd.canine` use SQLite databases internally. If you encounter memory issues, ensure you are using the latest version of `oligo` and `DBI`.
- **Platform Verification**: Ensure your CEL files match the "Canine" array type. If `read.celfiles` fails to find the annotation, manually check the `annotation` slot of the resulting object.

## Reference documentation
- [pd.canine Reference Manual](./references/reference_manual.md)