---
name: bioconductor-pd.mogene.1.0.st.v1
description: This package provides annotation and platform design information for the Affymetrix Mouse Gene 1.0 ST v1 array. Use when user asks to process Mouse Gene 1.0 ST v1 arrays, map probe identifiers to sequences, or provide platform-specific metadata for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mogene.1.0.st.v1.html
---


# bioconductor-pd.mogene.1.0.st.v1

name: bioconductor-pd.mogene.1.0.st.v1
description: Annotation package for the Affymetrix Mouse Gene 1.0 ST v1 platform. Use this skill when processing or analyzing GeneChip Mouse Gene 1.0 ST v1 arrays in R, specifically for mapping probe identifiers to sequences and providing platform-specific metadata for the oligo package.

# bioconductor-pd.mogene.1.0.st.v1

## Overview
The `pd.mogene.1.0.st.v1` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the essential platform design information required to analyze Affymetrix Mouse Gene 1.0 ST v1 arrays. It is primarily designed to work as a backend for the `oligo` package to facilitate preprocessing, feature-level extraction, and normalization of .CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked directly:

```r
library(pd.mogene.1.0.st.v1)
```

### Integration with oligo
This package provides the infrastructure for the `read.celfiles` function. When analyzing Mouse Gene 1.0 ST v1 data, `oligo` uses this package to map probes to their physical locations and types.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The 'pd.mogene.1.0.st.v1' package is used here to structure 'raw_data'
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, as well as background (bg) and Mismatch (mm) sequences if applicable to the design.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences by feature ID
# pmSequence[pmSequence$fid == <feature_id>, ]
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (accessible via `data(pmSequence)` aliases).
- `mmSequence`: Sequence data for mismatch probes (if present in the design).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure your R session has sufficient memory when loading large datasets with `oligo`.
- **Platform Verification**: This package is specific to version 1 ("v1") of the Mouse Gene 1.0 ST array. Ensure your array version matches this package to avoid incorrect probe mapping.
- **Database Backend**: The package uses an SQLite database to store mapping information. You can interact with the underlying database using `db(pd.mogene.1.0.st.v1)` if advanced querying of the platform design is required.

## Reference documentation
- [pd.mogene.1.0.st.v1 Reference Manual](./references/reference_manual.md)