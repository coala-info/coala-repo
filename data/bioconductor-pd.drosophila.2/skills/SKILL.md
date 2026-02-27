---
name: bioconductor-pd.drosophila.2
description: This package provides annotation data and platform design information for the Affymetrix Drosophila Genome 2.0 Array. Use when user asks to analyze Drosophila melanogaster microarray data, map probe identifiers to sequences, or preprocess CEL files using the oligo framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.drosophila.2.html
---


# bioconductor-pd.drosophila.2

name: bioconductor-pd.drosophila.2
description: Provides annotation data for the Drosophila_2 (Fruit Fly) Affymetrix GeneChip. Use this skill when analyzing Drosophila melanogaster microarray data with the 'oligo' or 'biocLite' frameworks, specifically for mapping probe identifiers to sequences and managing platform-specific design information.

# bioconductor-pd.drosophila.2

## Overview
The `pd.drosophila.2` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It is specifically designed to work with the `oligo` package to facilitate the analysis of Affymetrix Drosophila Genome 2.0 Array data. It provides the necessary platform design (pd) information, including probe sequences and feature identifiers required for preprocessing and normalization.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.drosophila.2")
```

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.drosophila.2)
```

### Accessing Probe Sequences
The package stores sequence information for Perfect Match (PM) probes. This is critical for algorithms that account for sequence-specific binding affinities (like GCRMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
When analyzing Drosophila_2 arrays, the `oligo` package uses this annotation to map features:

```r
library(oligo)
# Assuming 'celfiles' is an ExpressionFeatureSet object
# The pd.drosophila.2 package provides the underlying mapping
data <- read.celfiles(filenames)
# Preprocessing (e.g., RMA) automatically utilizes the pd package
eset <- rma(data)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the feature ID (`fid`) and the corresponding 25-mer oligonucleotide sequence for PM probes.
- **bgSequence**: Background probe sequences (if applicable).
- **mmSequence**: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when loading `pmSequence`.
- **Platform Specificity**: This package is strictly for the "Drosophila_2" array. Do not use it for the older "Drosophila" (v1) array.
- **Object Class**: The sequence data is stored in a `DataFrame` (from the `S4Vectors` package), not a standard base R `data.frame`. Use `as.data.frame()` if standard data frame methods are required.

## Reference documentation
- [pd.drosophila.2 Reference Manual](./references/reference_manual.md)