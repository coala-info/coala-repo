---
name: bioconductor-pd.s.aureus
description: This package provides annotation and platform design data for the Affymetrix Staphylococcus aureus expression array. Use when user asks to process S. aureus microarray data, map probe identifiers to sequences, or perform low-level preprocessing using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.s.aureus.html
---

# bioconductor-pd.s.aureus

name: bioconductor-pd.s.aureus
description: Annotation package for the Staphylococcus aureus (S. aureus) expression array. Use when processing Affymetrix S. aureus microarrays using the oligo or xps packages to map probe identifiers to sequences, manage chip layout, and perform low-level preprocessing.

# bioconductor-pd.s.aureus

## Overview

The `pd.s.aureus` package is a Platform Design (PD) annotation package for the Affymetrix Staphylococcus aureus Genome Array. It was built using the `pdInfoBuilder` package and is specifically designed to work with the `oligo` package. It provides the necessary mapping between probe identifiers, physical coordinates on the array, and probe sequences (PM, MM, and background).

## Usage

This package is typically not called directly by the user but is loaded automatically by high-level analysis packages like `oligo` when processing `.CEL` files from the S. aureus array.

### Loading the Package

```r
library(pd.s.aureus)
```

### Integration with oligo

When analyzing S. aureus microarrays, the `oligo` package uses `pd.s.aureus` to identify the chip layout.

```r
library(oligo)

# Read CEL files; oligo will automatically detect and use pd.s.aureus
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences

You can manually inspect the probe sequence data stored within the package. The sequences are stored in a `DataFrame` object.

```r
# Load the Perfect Match (PM) sequence data
data(pmSequence)

# View the first few rows (columns: 'fid' and 'sequence')
head(pmSequence)

# Accessing background or mismatch sequences (if available)
# data(bgSequence)
# data(mmSequence)
```

### Key Data Objects

- `pmSequence`: Contains the sequences for Perfect Match probes.
- `mmSequence`: Contains the sequences for Mismatch probes (if applicable to the array design).
- `bgSequence`: Contains background probe sequences.

## Reference documentation

- [pd.s.aureus Reference Manual](./references/reference_manual.md)