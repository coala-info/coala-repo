---
name: bioconductor-pd.aragene.1.1.st
description: This package provides annotation and platform design data for the Affymetrix Arabidopsis Gene 1.1 ST Array Strip. Use when user asks to process Arabidopsis Gene 1.1 ST Array CEL files, perform low-level preprocessing with the oligo package, or retrieve probe sequences for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.aragene.1.1.st.html
---


# bioconductor-pd.aragene.1.1.st

name: bioconductor-pd.aragene.1.1.st
description: Provides annotation data for the Affymetrix aragene.1.1.st platform. Use when processing Arabidopsis Gene 1.1 ST Array Strip data in R, specifically for low-level analysis, feature-level preprocessing, and retrieving probe sequences using the oligo package.

# bioconductor-pd.aragene.1.1.st

## Overview
The `pd.aragene.1.1.st` package is a Bioconductor annotation package (Platform Design package) specifically built for the Arabidopsis Gene 1.1 ST Array Strip. It provides the necessary mapping between probe identifiers, physical coordinates on the array, and probe sequences. This package is designed to work as a backend for the `oligo` package to enable preprocessing (like RMA) and quality control of CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked directly:
```r
library(pd.aragene.1.1.st)
```

### Integration with oligo
The primary use case is providing the platform design information to the `read.celfiles` function.
```r
library(oligo)
# Read CEL files; the pd package is identified via the CEL file header
affyData <- read.celfiles(filenames = list.celfiles())

# The 'pd.aragene.1.1.st' package provides the layout for preprocessing
eset <- rma(affyData)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-based analysis.
```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when performing feature-level extractions.
- **Automatic Selection**: You do not usually need to call functions inside `pd.aragene.1.1.st` directly; the `oligo` package methods (`rma`, `boxplot`, `image`) use this package internally based on the `annotation` slot of the `FeatureSet` object.
- **Platform Verification**: Ensure your CEL files are indeed from the Arabidopsis Gene 1.1 ST platform; using the wrong `pd` package will result in incorrect mapping and errors during preprocessing.

## Reference documentation
- [pd.aragene.1.1.st Reference Manual](./references/reference_manual.md)