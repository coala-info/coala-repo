---
name: bioconductor-pd.hg.focus
description: This Bioconductor package provides platform design and annotation data for the Affymetrix HG-Focus microarray. Use when user asks to preprocess HG-Focus CEL files using the oligo package, access probe sequence information, or map probe identifiers to physical locations on the array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.focus.html
---

# bioconductor-pd.hg.focus

name: bioconductor-pd.hg.focus
description: Annotation package for the Affymetrix HG-Focus array. Use this skill when analyzing HG-Focus microarray data in R, particularly when using the 'oligo' package to preprocess CEL files or when probe sequence information is required for downstream analysis.

# bioconductor-pd.hg.focus

## Overview
The `pd.hg.focus` package is a Bioconductor annotation resource providing platform design (PD) information for the Affymetrix HG-Focus microarray. It was built using the `pdInfoBuilder` package and serves as a critical dependency for the `oligo` package. It maps probe identifiers to their physical locations on the array and provides sequence data for various probe types.

## Usage

### Loading the Package
To use the annotation data in an R session:
```R
library(pd.hg.focus)
```

### Accessing Probe Sequences
The package stores sequence data for Perfect Match (PM) probes, as well as background (BG) and mismatch (MM) sequences if applicable. The data is stored in a `DataFrame` object.

```R
# Load the PM sequence data
data(pmSequence)

# Inspect the data structure
# The DataFrame typically contains 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Integration with the oligo Package
In most workflows, you do not call `pd.hg.focus` functions directly. Instead, the `oligo` package uses it automatically when reading CEL files generated from the HG-Focus platform.

```R
library(oligo)

# Read CEL files; oligo detects the platform and loads pd.hg.focus
affy_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization or other preprocessing
eset <- rma(affy_data)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for Perfect Match probes.
- `mmSequence`: Sequence data for Mismatch probes (if available).
- `bgSequence`: Sequence data for Background probes (if available).

## Reference documentation
- [pd.hg.focus Reference Manual](./references/reference_manual.md)