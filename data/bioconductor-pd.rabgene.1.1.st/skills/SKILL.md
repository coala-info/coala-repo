---
name: bioconductor-pd.rabgene.1.1.st
description: This package provides annotation data for the Affymetrix Rabgene 1.1 ST array to support low-level analysis with the oligo package. Use when user asks to process Rabgene 1.1 ST CEL files, map probe sequences, or perform RMA normalization on this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rabgene.1.1.st.html
---

# bioconductor-pd.rabgene.1.1.st

name: bioconductor-pd.rabgene.1.1.st
description: Annotation package for the Affymetrix Rabgene 1.1 ST array. Use when performing low-level analysis of Rabgene 1.1 ST expression data, specifically for mapping probe sequences and identifiers during preprocessing with the 'oligo' package.

# bioconductor-pd.rabgene.1.1.st

## Overview
The `pd.rabgene.1.1.st` package is a Platform Design (PD) annotation package for the Affymetrix Rabgene 1.1 ST array. It was built using `pdInfoBuilder` and is specifically designed to work with the `oligo` package to facilitate the analysis of high-density oligonucleotide arrays. It contains the sequence information and feature-level metadata required for preprocessing CEL files.

## Usage and Workflow

### Integration with oligo
This package is rarely called directly by the user. Instead, it is automatically loaded by the `oligo` package when reading CEL files produced by the Rabgene 1.1 ST platform.

```r
library(oligo)

# Read CEL files; oligo will automatically detect and load pd.rabgene.1.1.st
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform normalization (e.g., RMA)
eset <- rma(raw_data)
```

### Accessing Probe Sequences
If you need to inspect the Perfect Match (PM) probe sequences for this array, you can load the sequence data explicitly.

```r
library(pd.rabgene.1.1.st)
data(pmSequence)

# View the first few sequences
# The DataFrame contains 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Manual Package Loading
If the automatic detection fails or you need to verify the annotation environment:

```r
# Load the package
library(pd.rabgene.1.1.st)

# Check package details
packageDescription("pd.rabgene.1.1.st")
```

## Tips
- Ensure that `oligo` is installed, as `pd.rabgene.1.1.st` is a data-only package meant to support `oligo`'s functions.
- If you encounter errors regarding "missing platform design," ensure this package is installed via BiocManager: `BiocManager::install("pd.rabgene.1.1.st")`.

## Reference documentation
- [pd.rabgene.1.1.st Reference Manual](./references/reference_manual.md)