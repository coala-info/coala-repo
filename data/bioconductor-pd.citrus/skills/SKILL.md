---
name: bioconductor-pd.citrus
description: This package provides platform design and annotation data for the Citrus microarray. Use when user asks to process Citrus microarray data, map probe IDs to sequences, or perform feature-level preprocessing using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.citrus.html
---


# bioconductor-pd.citrus

name: bioconductor-pd.citrus
description: Annotation package for the Citrus (Citrus sinensis) microarray. Use this skill when processing Affymetrix-style microarray data for Citrus species using the oligo or xps packages, specifically for mapping probe IDs to sequences and managing chip layout information.

# bioconductor-pd.citrus

## Overview
The `pd.citrus` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design (PD) information for the Citrus genome microarray. It is primarily designed to work as a backend database for the `oligo` package to enable feature-level preprocessing (like RMA) and sequence-specific analysis.

## Workflow and Usage

### Loading the Package
The package is typically loaded automatically when reading raw CEL files with `oligo::read.celfiles()`, but it can be loaded manually:

```r
library(pd.citrus)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is essential for algorithms that account for hybridization efficiency based on GC content.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Integration with oligo
The most common use case is providing the annotation environment for an `ExpressionFeatureSet`:

```r
library(oligo)

# Read CEL files (pd.citrus must be installed)
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.citrus' package provides the mapping for preprocessing
eset <- rma(raw_data)
```

### Data Objects
- `pmSequence`: A `DataFrame` object containing the probe sequences.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: Annotation packages like `pd.citrus` use SQLite databases internally. If you encounter "database locked" errors, ensure your R session has appropriate permissions to the library folder.
- **Platform Matching**: This package is specific to the Citrus microarray design. Ensure your CEL files were generated from this specific platform before use.
- **Sequence Analysis**: Use the `pmSequence` object if you need to perform custom probe-level analysis, such as calculating melting temperatures or checking for cross-hybridization.

## Reference documentation
- [pd.citrus Reference Manual](./references/reference_manual.md)