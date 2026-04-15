---
name: bioconductor-pd.rta.1.0
description: This package provides annotation and platform design metadata for the RTA 1.0 microarray platform. Use when user asks to analyze RTA 1.0 microarray data, map probe IDs to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rta.1.0.html
---

# bioconductor-pd.rta.1.0

name: bioconductor-pd.rta.1.0
description: Annotation package for the RTA 1.0 microarray platform. Use this skill when analyzing RTA 1.0 data in R, specifically for mapping probe IDs to sequences and providing platform metadata for the oligo package.

# bioconductor-pd.rta.1.0

## Overview
The `pd.rta.1.0` package is a Bioconductor annotation resource (Platform Design package) for the RTA 1.0 microarray. It was built using `pdInfoBuilder` and provides the necessary mapping between probe identifiers and their physical sequences, as well as the layout information required by the `oligo` package for low-level analysis (such as RMA normalization).

## Usage
This package is primarily used as a backend dependency for the `oligo` package rather than a standalone tool.

### Loading the Package
```r
library(pd.rta.1.0)
```

### Integration with oligo
When reading CEL files from an RTA 1.0 array, the `oligo` package will automatically detect the platform and attempt to load this package to provide the necessary metadata:

```r
library(oligo)

# List CEL files in the current directory
celFiles <- list.celfiles()

# Read CEL files; oligo uses pd.rta.1.0 automatically
rawData <- read.celfiles(celFiles)

# Perform normalization (e.g., RMA)
eset <- rma(rawData)
```

### Accessing Probe Sequences
You can manually inspect the probe sequences stored within the package using the `data()` function. The sequences are stored in a `DataFrame` object.

```r
# Load Perfect Match (PM) sequence data
data(pmSequence)

# View the first few entries
# The DataFrame contains 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Key Data Objects
- `pmSequence`: Contains sequences for Perfect Match probes.
- `bgSequence`: Contains sequences for background probes (if available).
- `mmSequence`: Contains sequences for Mismatch probes (if available).

## Reference documentation
- [pd.rta.1.0 Reference Manual](./references/reference_manual.md)