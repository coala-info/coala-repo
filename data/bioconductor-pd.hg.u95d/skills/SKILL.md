---
name: bioconductor-pd.hg.u95d
description: This package provides platform design annotation and metadata for the Affymetrix Human Genome U95d microarray. Use when user asks to process raw CEL files, retrieve probe sequences, or perform normalization and feature mapping for HG-U95D arrays using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95d.html
---

# bioconductor-pd.hg.u95d

name: bioconductor-pd.hg.u95d
description: Annotation package for the Affymetrix Human Genome U95d (HG-U95D) array. Use when processing or analyzing HG-U95D microarray data using the 'oligo' or 'biocLite' frameworks, specifically for retrieving probe sequences and mapping feature identifiers.

# bioconductor-pd.hg.u95d

## Overview
The `pd.hg.u95d` package is a platform design (PD) annotation package for the Affymetrix HG-U95D microarray. It is specifically designed to work with the `oligo` package to provide the necessary metadata, probe locations, and sequence information required for preprocessing raw CEL files (e.g., background correction, normalization, and summarization).

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.hg.u95d)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific preprocessing methods or quality control.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature identifier in the platform design
```

### Integration with oligo
The primary use case for this package is as a backend for the `read.celfiles` function. When `oligo` detects the HG-U95D chip type, it searches for this annotation package.

```r
library(oligo)

# Read CEL files (ensure pd.hg.u95d is installed)
fns <- list.celfiles(path = "path/to/cel/files", full.names = TRUE)
rawData <- read.celfiles(fns)

# The rawData object will now use pd.hg.u95d for feature mapping
# Perform RMA normalization
eset <- rma(rawData)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for the PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Installation**: Ensure the package is installed via BiocManager: `BiocManager::install("pd.hg.u95d")`.
- **Memory**: PD packages can be large as they contain SQLite databases of the chip layout. Ensure sufficient RAM when processing large batches of CEL files.
- **Compatibility**: This package is built using `pdInfoBuilder` and is intended for use with the `oligo` package rather than the older `affy` package (which uses CDF environments).

## Reference documentation
- [pd.hg.u95d Reference Manual](./references/reference_manual.md)