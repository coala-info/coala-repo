---
name: bioconductor-pd.hg.u133b
description: This package provides platform design and annotation data for the Affymetrix Human Genome U133B microarray. Use when user asks to process raw CEL files from HG-U133B arrays, perform RMA normalization using the oligo package, or access probe sequence information.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u133b.html
---


# bioconductor-pd.hg.u133b

name: bioconductor-pd.hg.u133b
description: Annotation data package for the Affymetrix Human Genome U133 Plus 2.0 (HG-U133B) array. Use this skill when processing Affymetrix HG-U133B microarray data using the oligo or pdInfoBuilder packages, specifically for platform design information, probe sequences, and feature-level annotation.

# bioconductor-pd.hg.u133b

## Overview
The `pd.hg.u133b` package is a Bioconductor annotation resource specifically designed for use with the `oligo` package. It provides the platform design information required to process raw CEL files from the Affymetrix HG-U133B array. It contains mapping information between probes, feature IDs, and sequences.

## Typical Workflow

### 1. Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.hg.u133b)
```

### 2. Using with oligo
When analyzing HG-U133B arrays, the `oligo` package uses this platform design package to identify the geometry and probe sequences of the chip.

```r
library(oligo)

# Read CEL files (the package will be detected automatically)
affyData <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(affyData)
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for the Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Implementation Tips
- **Automatic Detection**: You do not usually need to call functions inside `pd.hg.u133b` directly. Its primary role is providing a standardized SQLite-based schema that `oligo` queries during preprocessing.
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when performing preprocessing (RMA/GCRMA) on large datasets.
- **Platform Matching**: Ensure your CEL files are specifically for the "B" version of the U133 set; the "A" version requires `pd.hg.u133a`.

## Reference documentation
- [pd.hg.u133b Reference Manual](./references/reference_manual.md)