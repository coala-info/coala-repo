---
name: bioconductor-pd.drogene.1.1.st
description: This package provides annotation data and probe sequences for the Affymetrix Drosophila Gene 1.1 ST expression array. Use when user asks to process Drosophila Gene 1.1 ST CEL files, map probe identifiers to sequences, or perform low-level normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.drogene.1.1.st.html
---

# bioconductor-pd.drogene.1.1.st

name: bioconductor-pd.drogene.1.1.st
description: Annotation package for the Drosophila Gene 1.1 ST array. Use when processing Affymetrix Drosophila Gene 1.1 ST expression data in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.drogene.1.1.st

## Overview
The `pd.drogene.1.1.st` package is a Bioconductor annotation data package built using `pdInfoBuilder`. It provides the necessary infrastructure to analyze Affymetrix Drosophila Gene 1.1 ST arrays. It is designed to work seamlessly with the `oligo` package to handle low-level processing (like normalization and summarization) of .CEL files.

## Usage and Workflows

### Loading the Package
To use this annotation data, load the package in your R session:

```r
library(pd.drogene.1.1.st)
```

### Integration with oligo
This package is rarely called directly by the user. Instead, it is automatically utilized by the `oligo` package when reading CEL files from the Drosophila Gene 1.1 ST platform.

```r
library(oligo)

# Read CEL files; oligo uses pd.drogene.1.1.st automatically
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is useful for sequence-specific analysis or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the corresponding nucleotide sequence for PM probes.
- `bgSequence`: Background sequence data (if applicable).
- `mmSequence`: Mismatch sequence data (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure your R session has sufficient memory when processing large datasets with `oligo`.
- **Platform Matching**: This package is specific to version 1.1 of the Drosophila Gene ST array. Ensure your CEL files match this specific platform version.
- **Dependencies**: Ensure the `oligo` and `BiocGenerics` packages are installed to make full use of this annotation data.

## Reference documentation
- [pd.drogene.1.1.st Reference Manual](./references/reference_manual.md)