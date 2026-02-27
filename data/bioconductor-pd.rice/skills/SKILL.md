---
name: bioconductor-pd.rice
description: This package provides annotation and platform design information for the Affymetrix Rice Genome Array. Use when user asks to preprocess Rice GeneChip .CEL files, map probes to sequences, or perform low-level analysis of rice microarray data using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rice.html
---


# bioconductor-pd.rice

name: bioconductor-pd.rice
description: Annotation package for the Rice Genome Array. Use when working with Affymetrix Rice GeneChip data in R, specifically for probe-level processing, feature-level annotation, and sequence retrieval using the oligo package.

# bioconductor-pd.rice

## Overview

The `pd.rice` package is a Bioconductor annotation platform (Platform Design) package for the Rice Genome Array. It is primarily designed to work as a backend for the `oligo` package to enable the preprocessing of .CEL files. It contains the mapping between probes, features, and sequences required for low-level analysis of rice microarray data.

## Workflow and Usage

### Loading the Package
The package is typically loaded automatically when reading Rice Array CEL files with `oligo`, but can be loaded manually:

```r
library(pd.rice)
```

### Integration with oligo
The most common use case is providing the annotation slot for `read.celfiles`. The `oligo` package identifies this package to correctly map probe intensities to probesets.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles(), pkgname = "pd.rice")
```

### Accessing Sequence Data
The package provides sequence information for Perfect Match (PM) probes, which is essential for algorithms that account for probe sequence effects (like GC-RMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the expression object
```

### Available Data Objects
- `pmSequence`: Sequence data for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large batches of rice microarray CEL files.
- **Compatibility**: This package is specifically built using `pdInfoBuilder` and is intended for use with the `oligo` or `eeptools` packages, rather than the older `affy` package (which uses CDF files).

## Reference documentation

- [pd.rice Reference Manual](./references/reference_manual.md)