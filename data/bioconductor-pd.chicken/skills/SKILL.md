---
name: bioconductor-pd.chicken
description: This package provides platform design and annotation data for the Affymetrix Chicken genome microarray. Use when user asks to preprocess Chicken GeneChip CEL files, perform low-level analysis with the oligo package, or retrieve probe sequence information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.chicken.html
---


# bioconductor-pd.chicken

name: bioconductor-pd.chicken
description: Annotation package for the Chicken (Gallus gallus) genome microarray. Use when performing low-level analysis of Affymetrix Chicken GeneChip arrays, specifically for preprocessing CEL files with the oligo package or retrieving probe sequence information.

# bioconductor-pd.chicken

## Overview

The `pd.chicken` package is a Platform Design (PD) info package for the Chicken genome. It was built using the `pdInfoBuilder` package and is specifically designed to be used in conjunction with the `oligo` package for the analysis of high-density oligonucleotide arrays. It provides the mapping between probe identifiers (fids) and their sequences, which is essential for background correction and normalization routines.

## Usage

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.chicken)
```

### Integration with oligo
When analyzing Chicken GeneChip data, the `oligo` package uses `pd.chicken` to understand the chip layout.

```r
library(oligo)
# Assuming .CEL files are in the current directory
affyData <- read.celfiles(list.celfiles())
# oligo will automatically detect and use pd.chicken for annotation
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific analysis or custom probe-level modeling.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
fids <- pmSequence$fid
sequences <- pmSequence$sequence
```

### Data Structures
- **pmSequence**: A `DataFrame` object containing:
  - `fid`: Feature identifier (integer).
  - `sequence`: The actual nucleotide sequence (character).
- **bgSequence / mmSequence**: Depending on the specific array version, background or Mismatch (MM) sequences may also be available via similar `data()` calls if defined in the platform design.

## Tips
- **Memory Management**: PD packages can be large. If working with many samples, ensure your R session has sufficient memory to hold the annotation objects.
- **Package Versioning**: Ensure the version of `pd.chicken` matches the Bioconductor release used for your `oligo` installation to avoid compatibility issues.
- **Automatic Detection**: You do not usually need to call functions within `pd.chicken` directly; its primary role is providing data to `oligo` functions like `rma()` or `snprma()`.

## Reference documentation
- [pd.chicken Reference Manual](./references/reference_manual.md)