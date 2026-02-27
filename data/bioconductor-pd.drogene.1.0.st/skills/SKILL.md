---
name: bioconductor-pd.drogene.1.0.st
description: This package provides annotation and platform design data for the Affymetrix Drosophila Gene 1.0 ST array. Use when user asks to process Drosophila Gene 1.0 ST expression data, map probes to sequences, or manage chip-specific metadata using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.drogene.1.0.st.html
---


# bioconductor-pd.drogene.1.0.st

name: bioconductor-pd.drogene.1.0.st
description: Annotation package for the Drosophila Gene 1.0 ST array. Use when processing Affymetrix Drosophila Gene 1.0 ST expression data with the oligo package to map probes to sequences and manage chip-specific metadata.

# bioconductor-pd.drogene.1.0.st

## Overview

The `pd.drogene.1.0.st` package is a Bioconductor annotation data package specifically designed for the Affymetrix Drosophila Gene 1.0 ST array. It is built using the `pdInfoBuilder` framework and is intended to be used as a platform design (pd) package in conjunction with the `oligo` package for low-level analysis of microarray data.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, provided the package is installed. You can also load it manually:

```r
library(pd.drogene.1.0.st)
```

### Integration with oligo
This package provides the necessary mapping between probe identifiers and their physical locations or sequences. When using `oligo` to process Drosophila Gene 1.0 ST arrays, the `oligo` functions will query this package for probe geometry and feature information.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.drogene.1.0.st' package is used behind the scenes 
# during preprocessing (e.g., RMA)
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for the Perfect Match (PM) probes on the array. This is stored in a `DataFrame` object.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (columns: 'fid' and 'sequence')
head(pmSequence)

# 'fid' corresponds to the feature ID used in the oligo objects
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Platform Matching**: This package is specific to the "1.0 ST" version of the Drosophila Gene array. Ensure your CEL files match this specific platform version.
- **Annotation**: For higher-level gene annotations (symbols, GO terms), use this package to get the probe IDs, then map them using the `drogene10sttranscriptcluster.db` package.

## Reference documentation

- [pd.drogene.1.0.st Reference Manual](./references/reference_manual.md)