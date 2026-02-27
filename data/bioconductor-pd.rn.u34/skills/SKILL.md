---
name: bioconductor-pd.rn.u34
description: This package provides platform design and sequence annotation for the Affymetrix Rat Genome U34 microarray. Use when user asks to analyze Rat Genome U34 microarray data, map probe identifiers to sequences, or process CEL files using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rn.u34.html
---


# bioconductor-pd.rn.u34

name: bioconductor-pd.rn.u34
description: Annotation package for the Affymetrix Rat Genome U34 (u34) array. Use this skill when analyzing u34 microarray data in R, specifically for mapping feature identifiers to sequences and providing platform design information required by the oligo package.

# bioconductor-pd.rn.u34

## Overview

The `pd.rn.u34` package is a Platform Design (PD) annotation package for the Affymetrix Rat Genome U34 array. It was generated using the `pdInfoBuilder` package and is specifically designed to work in tandem with the `oligo` package for the analysis of oligonucleotide microarrays. It contains the necessary metadata to map probes to their physical locations and sequences on the chip.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with the `oligo` package, but can be loaded manually:

```r
library(pd.rn.u34)
```

### Integration with oligo
This package provides the infrastructure for the `oligo` package to process raw data. When you use `read.celfiles()`, `oligo` identifies the platform and searches for this annotation package.

```r
library(oligo)
# Assuming .CEL files are in the current directory
affyData <- read.celfiles(list.celfiles())
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM), Mismatch (MM), and Background (BG) probes. These are stored as `DataFrame` objects.

```r
# Load PM sequence data
data(pmSequence)

# View the structure (columns: fid, sequence)
head(pmSequence)

# Accessing other sequences if available
data(mmSequence)
data(bgSequence)
```

### Key Data Objects
- **pmSequence**: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for Perfect Match probes.
- **mmSequence**: Sequence data for Mismatch probes.
- **bgSequence**: Sequence data for background probes.

## Tips
- This package is a data-only annotation package. You will rarely call functions directly from it; instead, you will pass the package name or its objects to high-level analysis functions in `oligo` or `limma`.
- Ensure the version of `pd.rn.u34` matches the array type used in your experiment (Rat Genome U34).

## Reference documentation

- [pd.rn.u34 Reference Manual](./references/reference_manual.md)