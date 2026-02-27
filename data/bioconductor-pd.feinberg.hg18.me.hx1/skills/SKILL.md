---
name: bioconductor-pd.feinberg.hg18.me.hx1
description: This package provides annotation data and probe sequences for the Feinberg HG18 ME HX1 microarray platform. Use when user asks to retrieve probe sequences, map probe IDs to genomic locations, or preprocess raw CEL files from this specific NimbleGen platform using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.feinberg.hg18.me.hx1.html
---


# bioconductor-pd.feinberg.hg18.me.hx1

name: bioconductor-pd.feinberg.hg18.me.hx1
description: Annotation data for the Feinberg HG18 ME HX1 microarray platform. Use this skill when working with DNA methylation or genomic tiling data from this specific NimbleGen/Feinberg platform, specifically for retrieving probe sequences and mapping probe IDs to genomic locations using the oligo package.

# bioconductor-pd.feinberg.hg18.me.hx1

## Overview

The `pd.feinberg.hg18.me.hx1` package is a Bioconductor annotation package (Platform Design package) built using `pdInfoBuilder`. It provides the necessary metadata and sequence information for the Feinberg HG18 ME HX1 microarray. This package is primarily designed to be used as a backend for the `oligo` package to facilitate the preprocessing and analysis of raw microarray data (CEL files).

## Usage in R

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.feinberg.hg18.me.hx1)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes, which is essential for background correction and normalization algorithms that rely on probe sequence composition (like GC content).

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
This package provides the infrastructure for `oligo` functions. When you read data using `read.celfiles()`, `oligo` uses this package to understand the chip layout.

```r
library(oligo)

# Example workflow:
# 1. Read CEL files (the pd package is detected automatically)
# affyData <- read.celfiles(filenames)

# 2. Get probe information
# probe_info <- getProbeInfo(affyData)
```

### Data Structures
- **pmSequence**: A `DataFrame` object containing:
  - `fid`: Feature ID (numeric index).
  - `sequence`: The actual nucleotide sequence of the probe.
- **bgSequence / mmSequence**: While referenced in the index, these typically point to the same sequence data structure for background or mismatch probes if applicable to this specific tiling array design.

## Tips
- This package is specific to the **HG18** (Human Genome Build 36) assembly. Ensure your downstream genomic analysis (like peak calling or annotation) uses the correct genome version.
- If you encounter errors regarding "missing platform design," ensure this package is installed: `BiocManager::install("pd.feinberg.hg18.me.hx1")`.

## Reference documentation

- [pd.feinberg.hg18.me.hx1 Reference Manual](./references/reference_manual.md)