---
name: bioconductor-pd.guigene.1.0.st
description: This package provides annotation data and probe mappings for the Affymetrix Guigene 1.0 ST microarray. Use when user asks to process Guigene 1.0 ST CEL files, perform low-level analysis with the oligo package, or access probe sequences for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.guigene.1.0.st.html
---


# bioconductor-pd.guigene.1.0.st

name: bioconductor-pd.guigene.1.0.st
description: Annotation package for the Affymetrix Guigene 1.0 ST array. Use when processing Guigene 1.0 ST microarray data, specifically for low-level analysis, background correction, and normalization using the oligo package.

# bioconductor-pd.guigene.1.0.st

## Overview

The `pd.guigene.1.0.st` package is a Platform Design (PD) annotation package for the Affymetrix Guigene 1.0 ST array. It provides the necessary mapping between probe identifiers, physical locations on the chip, and probe sequences. This package is primarily designed to work as a backend dependency for the `oligo` package to enable the analysis of high-density oligonucleotide arrays.

## Usage

This package is rarely used in isolation. It is typically invoked automatically by the `oligo` package when reading CEL files generated from the Guigene 1.0 ST platform.

### Loading the Package

```r
library(pd.guigene.1.0.st)
```

### Integration with oligo

When analyzing Guigene 1.0 ST data, you should use the `oligo` package. The `oligo` package will identify the correct annotation package based on the CEL file header.

```r
library(oligo)

# Read CEL files (pd.guigene.1.0.st will be loaded automatically)
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences

If you need to access the Perfect Match (PM) probe sequences for sequence-specific analysis:

```r
library(pd.guigene.1.0.st)
data(pmSequence)

# View the first few sequences
head(pmSequence)
```

The `pmSequence` object is a `DataFrame` containing:
- `fid`: Feature identifier.
- `sequence`: The actual nucleotide sequence of the probe.

## Workflow Tips

1. **Automatic Detection**: You do not usually need to call `library(pd.guigene.1.0.st)` manually if you are using `oligo::read.celfiles()`. The `oligo` package handles the mapping.
2. **Memory Management**: PD packages can be memory-intensive as they load SQLite databases in the background. Ensure your R environment has sufficient RAM for large experiments.
3. **Compatibility**: This package is specific to the "ST" (Sense Target) version of the Guigene 1.0 array. Ensure your CEL files match this specific platform version.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)