---
name: bioconductor-pd.x.tropicalis
description: This package provides platform design and probe sequence information for Xenopus tropicalis microarrays. Use when user asks to process Affymetrix data for Western clawed frogs, map probe IDs to sequences, or perform preprocessing with the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.x.tropicalis.html
---

# bioconductor-pd.x.tropicalis

name: bioconductor-pd.x.tropicalis
description: Annotation package for Xenopus tropicalis (Western clawed frog) microarrays. Use when working with the 'oligo' or 'bioc-pmc' packages to process Affymetrix or similar platform data for X. tropicalis, specifically for mapping probe IDs to sequences and managing platform design information.

# bioconductor-pd.x.tropicalis

## Overview
The `pd.x.tropicalis` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for analyzing Xenopus tropicalis microarrays. It is primarily designed to work as a backend for the `oligo` package to enable preprocessing, normalization, and sequence-level analysis of expression data.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on compatible CEL files, but can be loaded manually:

```r
library(pd.x.tropicalis)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is essential for background correction methods that rely on probe sequence (like GCRMA) or for verifying probe targets.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID in the platform design
```

### Integration with oligo
This package is a "pdInfo" object. When reading CEL files for Xenopus tropicalis, the `oligo` package uses this annotation to understand the chip layout.

```r
library(oligo)

# Example workflow:
# 1. Read CEL files (automatically detects pd.x.tropicalis if headers match)
# rawData <- read.celfiles(filenames)

# 2. Get probe information through the oligo interface
# pm_indices <- pmindex(rawData)
# pm_seqs <- getSeq(pd.x.tropicalis)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the feature ID (`fid`) and the actual nucleotide sequence for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure you have sufficient RAM when loading `pmSequence` for genome-wide arrays.
- **Platform Matching**: This package is specific to the platform design for *Xenopus tropicalis*. Ensure your CEL file headers match this specific annotation provider.
- **Dependency**: Always ensure the `oligo` package is installed, as `pd.x.tropicalis` is rarely used in isolation.

## Reference documentation
- [pd.x.tropicalis Reference Manual](./references/reference_manual.md)