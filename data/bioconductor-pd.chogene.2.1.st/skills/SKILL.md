---
name: bioconductor-pd.chogene.2.1.st
description: This package provides platform design and annotation data for the Affymetrix CHOgene 2.1 ST expression array. Use when user asks to process raw CEL files from the CHOgene 2.1 ST platform, map probe identifiers to sequences, or perform low-level preprocessing and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.chogene.2.1.st.html
---


# bioconductor-pd.chogene.2.1.st

name: bioconductor-pd.chogene.2.1.st
description: Annotation package for the Affymetrix CHOgene 2.1 ST expression array. Use when analyzing microarray data from this platform, specifically for mapping probe identifiers to sequences and performing low-level preprocessing with the oligo package.

# bioconductor-pd.chogene.2.1.st

## Overview

The `pd.chogene.2.1.st` package is a Platform Design (pd) annotation package for the Affymetrix CHOgene 2.1 ST array. It was built using the `pdInfoBuilder` package and is specifically designed to work with the `oligo` package to facilitate the analysis of Gene ST arrays. It contains the sequence information and feature-level metadata required to process raw CEL files.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be loaded manually:

```r
library(pd.chogene.2.1.st)
```

### Use with oligo
The primary use case is providing the platform design information to the `read.celfiles` function. The `oligo` package identifies the chip type from the CEL file header and searches for this annotation package.

```r
library(oligo)

# Read CEL files
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# The rawData object will now use pd.chogene.2.1.st for feature mapping
# You can then proceed to RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis or quality control.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
head(pmSequence)

# The data is stored in a DataFrame with 'fid' (feature ID) and 'sequence'
```

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large batches of ST arrays.
- **Compatibility**: This package is intended for the "ST" (Sense Target) version of the CHOgene 2.1 array. Ensure your CEL files match this specific platform version.
- **Annotation**: While this package provides the physical mapping of probes on the array, for gene-level annotations (symbols, GO terms, etc.), you should use the corresponding transcript-level annotation package (e.g., `chogene21sttranscriptcluster.db`).

## Reference documentation

- [pd.chogene.2.1.st Reference Manual](./references/reference_manual.md)