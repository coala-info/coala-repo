---
name: bioconductor-pd.chigene.1.0.st
description: This package provides platform design and annotation data for the Affymetrix ChiGene 1.0 ST array. Use when user asks to process Chinese Hamster expression data, map probe sequences, or perform low-level preprocessing of ChiGene 1.0 ST CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.chigene.1.0.st.html
---

# bioconductor-pd.chigene.1.0.st

name: bioconductor-pd.chigene.1.0.st
description: Annotation package for the Affymetrix ChiGene 1.0 ST array. Use when processing Affymetrix Gene 1.0 ST expression data for Chinese Hamster (Cricetulus griseus) to provide platform design information, probe sequences, and feature mapping, typically in conjunction with the oligo package.

# bioconductor-pd.chigene.1.0.st

## Overview
The `pd.chigene.1.0.st` package is a Bioconductor "Platform Design" (pd) annotation package. It provides the necessary infrastructure to analyze Affymetrix ChiGene 1.0 ST arrays. It contains the mapping between probe identifiers, sequences, and their physical locations on the array. This package is designed to work seamlessly with the `oligo` package for low-level preprocessing (like RMA) of Gene ST arrays.

## Usage

### Loading the Package
The package is usually loaded automatically when reading CEL files with the `oligo` package, but can be loaded manually:

```r
library(pd.chigene.1.0.st)
```

### Integration with oligo
The primary workflow involves using this package as a backend for `read.celfiles`. The `oligo` package identifies the chip type from the CEL file headers and searches for this annotation package.

```r
library(oligo)

# List and read CEL files
files <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(files)

# The rawData object will now use pd.chigene.1.0.st for feature mapping
# Perform RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package using the `pmSequence` dataset.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

### Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch (MM) probes (rarely used in ST arrays).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when processing large numbers of CEL files.
- **Automatic Detection**: If `read.celfiles()` fails to find the package, ensure it is installed via `BiocManager::install("pd.chigene.1.0.st")`.
- **Platform Specificity**: This package is specific to the version 1.0 ST array for Chinese Hamster. Do not use it for other species or different versions of the ChiGene array.

## Reference documentation
- [pd.chigene.1.0.st Reference Manual](./references/reference_manual.md)