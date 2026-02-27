---
name: bioconductor-pd.clariom.s.rat
description: This package provides annotation and platform-specific metadata for the Affymetrix Clariom S Rat microarray. Use when user asks to process Clariom S Rat .CEL files, map probe identifiers to sequences, or provide chip layout infrastructure for the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.s.rat.html
---


# bioconductor-pd.clariom.s.rat

name: bioconductor-pd.clariom.s.rat
description: Annotation package for the Clariom S Rat array. Use when processing Affymetrix/Thermo Fisher Clariom S Rat microarray data, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the 'oligo' or 'xps' packages.

# bioconductor-pd.clariom.s.rat

## Overview
The `pd.clariom.s.rat` package is a Bioconductor annotation data package. It provides the necessary infrastructure to process Clariom S Rat microarray data. It is primarily designed to work as a backend for the `oligo` package, enabling the preprocessing, normalization, and summarization of .CEL files by providing probe sequence information and chip layout metadata.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.clariom.s.rat)
```

### Usage with oligo
The most common use case is providing the annotation platform for `read.celfiles`:

```r
library(oligo)
# Read CEL files; oligo uses pd.clariom.s.rat to understand the chip layout
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package:

```r
library(pd.clariom.s.rat)
data(pmSequence)

# View the first few sequences
head(pmSequence)

# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure your R session has sufficient memory when working with large microarray datasets.
- **Platform Specificity**: This package is specific to the "Clariom S" design for Rat. Do not use it for "Clariom D" or other species' Clariom S arrays.
- **Integration**: This package is a "pdInfo" package. It does not contain gene-level annotations (like gene symbols or GO terms); for those, use the corresponding platform design mapping package (e.g., `clariomsrat.db`).

## Reference documentation
- [pd.clariom.s.rat Reference Manual](./references/reference_manual.md)