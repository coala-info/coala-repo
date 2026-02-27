---
name: bioconductor-pd.medicago
description: This package provides platform design and annotation data for the Medicago truncatula genome microarray. Use when user asks to process Affymetrix microarrays using the oligo package, access probe sequences, or perform normalization on Medicago expression data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.medicago.html
---


# bioconductor-pd.medicago

name: bioconductor-pd.medicago
description: Provides annotation data for the Medicago truncatula genome array. Use when working with the 'oligo' package to process Affymetrix microarrays for Medicago. This skill includes access to probe sequences (PM, MM, and background) and platform design information required for preprocessing and normalization of expression data.

# bioconductor-pd.medicago

## Overview
The `pd.medicago` package is a Platform Design (PD) annotation package for the Medicago truncatula microarray. It was built using `pdInfoBuilder` and is specifically designed to work with the `oligo` package for low-level analysis of Affymetrix tiling and expression arrays. It provides the mapping between probe identifiers, physical coordinates on the chip, and their nucleotide sequences.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.medicago)
```

### Integration with oligo
The primary use case is providing the annotation backend for `oligo` functions like `read.celfiles`.
```r
library(oligo)
# Read CEL files; pd.medicago is used automatically if the chip type matches
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization using the pd.medicago mapping
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the sequence data for Perfect Match (PM), Mismatch (MM), or Background (bg) probes. This is useful for custom sequence-specific analysis or GC-content calculations.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing other sequence types if available via the same dataset
# data(mmSequence)
# data(bgSequence)
```

### Data Structure
- **fid**: Feature identifier (integer) corresponding to the physical location on the array.
- **sequence**: The actual nucleotide sequence of the probe.

## Tips
- This package is a "data" package. It does not contain high-level analysis functions but rather the infrastructure required by `oligo`.
- Ensure `oligo` is installed to make full use of this annotation package.
- If you encounter errors regarding "missing platform design," ensure `pd.medicago` is installed via `BiocManager::install("pd.medicago")`.

## Reference documentation
- [pd.medicago Reference Manual](./references/reference_manual.md)