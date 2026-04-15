---
name: bioconductor-pd.rcngene.1.0.st
description: This package provides annotation and platform design information for the Affymetrix rcngene.1.0.st microarray. Use when user asks to process raw .CEL files, perform RMA normalization, or access probe sequences for this specific array type.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rcngene.1.0.st.html
---

# bioconductor-pd.rcngene.1.0.st

name: bioconductor-pd.rcngene.1.0.st
description: Annotation package for the Affymetrix rcngene.1.0.st microarray platform. Use when performing low-level analysis (preprocessing, normalization, or summarization) of .CEL files from this specific array type, typically in conjunction with the oligo package.

# bioconductor-pd.rcngene.1.0.st

## Overview

The `pd.rcngene.1.0.st` package is a Platform Design (PD) annotation package for the Affymetrix rcngene.1.0.st array. It was built using the `pdInfoBuilder` package and is specifically designed to work with the `oligo` package to provide the necessary mapping between probes and genomic features.

This package contains the layout information, probe sequences, and feature identifiers required to process raw microarray data.

## Usage and Workflow

### Integration with oligo

The primary use case for this package is automatic. When you load .CEL files using the `oligo` package, R will look for this package to understand the chip layout.

```r
library(oligo)
library(pd.rcngene.1.0.st)

# Read CEL files - the pd package is used automatically based on the CEL file header
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences

If you need to perform sequence-specific analysis or verify probe properties, you can load the Perfect Match (PM) sequence data directly.

```r
library(pd.rcngene.1.0.st)

# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Key Data Objects

- **pmSequence**: A `DataFrame` object containing the sequences for PM probes.
  - `fid`: Feature identifier.
  - `sequence`: The actual nucleotide sequence.

## Tips

- **Automatic Loading**: You rarely need to call functions within this package directly. Ensure it is installed so that `oligo` can find it when calling `read.celfiles()`.
- **Memory Management**: PD packages can be large. If working with many samples, ensure your R environment has sufficient RAM for the `oligo` objects created using this annotation.
- **Platform Specificity**: This package is strictly for the `rcngene.1.0.st` array. Using it with other array types will result in incorrect mappings.

## Reference documentation

- [pd.rcngene.1.0.st Reference Manual](./references/reference_manual.md)