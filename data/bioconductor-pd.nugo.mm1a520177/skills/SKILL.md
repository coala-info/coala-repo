---
name: bioconductor-pd.nugo.mm1a520177
description: This package provides annotation and platform design information for the NuGO Mouse Array mm1a520177. Use when user asks to process Affymetrix-based NuGO mouse microarrays, map probe sequences to grid coordinates, or perform feature-level preprocessing using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.nugo.mm1a520177.html
---

# bioconductor-pd.nugo.mm1a520177

name: bioconductor-pd.nugo.mm1a520177
description: Annotation package for the NuGO Mouse Array mm1a520177. Use this skill when processing Affymetrix-based NuGO mouse microarrays using the oligo package, specifically for probe-level data mapping, sequence analysis, and background correction.

# bioconductor-pd.nugo.mm1a520177

## Overview

The `pd.nugo.mm1a520177` package is a specialized annotation platform built using `pdInfoBuilder`. It provides the necessary mapping between physical grid coordinates on the NuGO Mouse Array (mm1a520177) and probe sequences. This package is designed to work as a backend for the `oligo` package to enable preprocessing of .CEL files.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.nugo.mm1a520177")
```

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked manually:

```r
library(pd.nugo.mm1a520177)
```

### Integration with oligo
The primary use case is providing the platform design information for feature-level preprocessing:

```r
library(oligo)

# Read CEL files (oligo will automatically detect and load pd.nugo.mm1a520177)
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences for sequence-specific analysis (e.g., GC-content calculations or custom background correction):

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Data Objects
- `pmSequence`: Contains sequences for Perfect Match probes.
- `mmSequence`: Contains sequences for Mismatch probes (if applicable to the array design).
- `bgSequence`: Contains sequences for background probes.

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **Platform Matching**: This package is specific to the `mm1a520177` design. If your CEL files were generated on a different NuGO or Affymetrix mouse array, this package will not be compatible.
- **Feature IDs**: The `fid` column in the sequence data maps directly to the feature identifiers used in `oligo` objects.

## Reference documentation

- [pd.nugo.mm1a520177 Reference Manual](./references/reference_manual.md)