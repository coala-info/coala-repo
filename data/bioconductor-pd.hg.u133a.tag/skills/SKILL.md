---
name: bioconductor-pd.hg.u133a.tag
description: This package provides annotation data for the Affymetrix HG-U133A_tag microarray platform. Use when user asks to perform probe-level analysis, retrieve probe sequences, or preprocess CEL files using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u133a.tag.html
---

# bioconductor-pd.hg.u133a.tag

name: bioconductor-pd.hg.u133a.tag
description: Annotation data package for the Affymetrix hg.u133a.tag platform. Use this skill when working with microarray data from the HG-U133A_tag chip, specifically for probe-level analysis, sequence retrieval, and integration with the 'oligo' package.

# bioconductor-pd.hg.u133a.tag

## Overview
The `pd.hg.u133a.tag` package is a Bioconductor annotation package specifically designed for the Affymetrix HG-U133A_tag microarray platform. It provides the necessary infrastructure to map probe identifiers to their physical locations and sequences. This package is primarily intended to be used as a backend for the `oligo` package to facilitate preprocessing, normalization, and analysis of CEL files.

## Usage and Workflows

### Loading the Package
To use the annotation data, load the package in your R session:

```r
library(pd.hg.u133a.tag)
```

### Integration with oligo
The most common use case is automatic invocation by the `oligo` package when reading CEL files. If you have CEL files for the HG-U133A_tag platform:

```r
library(oligo)
# Read CEL files in the current directory
rawData <- read.celfiles(list.celfiles())
# The oligo package will automatically look for pd.hg.u133a.tag
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. You can load and inspect this data directly:

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID used in the platform
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **mmSequence**: (If available) contains sequences for Mismatch probes.
- **bgSequence**: (If available) contains sequences for background probes.

## Tips
- **Memory Management**: These annotation objects can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Platform Verification**: Ensure your CEL files match the "HG-U133A_tag" platform; using the wrong `pdInfo` package will result in incorrect mapping or errors during preprocessing.
- **Feature IDs**: The `fid` column in the sequence data is the internal identifier used by the `oligo` package to link sequences to intensity values.

## Reference documentation
- [pd.hg.u133a.tag Reference Manual](./references/reference_manual.md)