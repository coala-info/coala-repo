---
name: bioconductor-pd.elegene.1.0.st
description: This package provides platform design and annotation data for the Affymetrix C. elegans Gene 1.0 ST array. Use when user asks to process Gene 1.0 ST arrays for Caenorhabditis elegans, map probe identifiers to sequences, or perform background correction and normalization using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.elegene.1.0.st.html
---


# bioconductor-pd.elegene.1.0.st

name: bioconductor-pd.elegene.1.0.st
description: Annotation and platform design information for the Affymetrix Elegen-1_0-st-v1 (C. elegans) array. Use when processing Gene 1.0 ST arrays for Caenorhabditis elegans using the oligo or xps packages, specifically for feature-to-sequence mapping and probe-level data annotation.

# bioconductor-pd.elegene.1.0.st

## Overview

The `pd.elegene.1.0.st` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the essential platform design information for the Affymetrix C. elegans Gene 1.0 ST array. This package is a critical dependency for the `oligo` package, which uses it to map probe identifiers to their physical locations and sequences on the array, enabling background correction, normalization, and summarization of ST-type (Sense Target) arrays.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` to read CEL files, but it can be loaded manually to inspect probe sequences.

```r
library(pd.elegene.1.0.st)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID used in the oligo objects
```

### Integration with oligo
The primary use case is providing the annotation backend for `read.celfiles`.

```r
library(oligo)

# When reading CEL files for this platform, oligo identifies this package
# as the required annotation provider.
affyData <- read.celfiles(filenames = list.celfiles())

# The annotation slot will point to pd.elegene.1.0.st
annotation(affyData)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (rarely present in ST arrays, but defined in the schema).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient memory when working with high-density ST arrays.
- **Version Matching**: Ensure the version of `pd.elegene.1.0.st` matches the Bioconductor release used for your `oligo` or `xps` analysis to maintain consistency in probe mapping.
- **ST Array Specifics**: Unlike older 3' IVT arrays, Gene ST arrays have probes distributed across the entire length of the transcript. This package handles the mapping required to aggregate these probes into transcript-level summaries.

## Reference documentation

- [pd.elegene.1.0.st Reference Manual](./references/reference_manual.md)