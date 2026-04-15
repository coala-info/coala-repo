---
name: bioconductor-pd.charm.hg18.example
description: This package provides annotation data and probe sequences for the hg18 CHARM example tiling array platform. Use when user asks to retrieve probe sequences, process CHARM example data with the oligo package, or map feature IDs to sequences for the hg18 genome build.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.charm.hg18.example.html
---

# bioconductor-pd.charm.hg18.example

name: bioconductor-pd.charm.hg18.example
description: Provides annotation data for the pd.charm.hg18.example platform. Use when working with CHARM (Comprehensive High-throughput Arrays for Relative Methylation) hg18 example data in R, specifically for probe sequence retrieval and integration with the oligo package.

# bioconductor-pd.charm.hg18.example

## Overview
The `pd.charm.hg18.example` package is a specialized annotation package built using `pdInfoBuilder`. It serves as a data container for probe information (specifically PM, MM, and background sequences) for the hg18 CHARM example array. It is designed to be used in conjunction with the `oligo` package for preprocessing and analyzing tiling array data.

## Usage and Workflows

### Loading the Package
To use the annotation data, load the package in your R session:

```r
library(pd.charm.hg18.example)
```

### Accessing Probe Sequences
The package provides sequence data for Perfect Match (PM), Mismatch (MM), and Background (BG) probes stored as `DataFrame` objects.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing other sequence types (if applicable)
# data(mmSequence)
# data(bgSequence)
```

### Integration with oligo
This package is typically not called directly by the user for complex functions but is instead loaded automatically by the `oligo` package when processing `.CEL` files or `FeatureSet` objects associated with this specific array design.

```r
library(oligo)
# When reading CEL files, oligo uses this package to map probes
# example_data <- read.celfiles(filenames)
```

## Tips
- **Data Structure**: Sequences are stored in a `DataFrame` with two primary columns: `fid` (feature ID) and `sequence`.
- **Memory**: Annotation packages can be large; ensure you have sufficient RAM when loading multiple `pdInfo` packages.
- **Platform Specificity**: This package is specific to the hg18 (Human Genome Build 36) example version of the CHARM array.

## Reference documentation
- [pd.charm.hg18.example Reference Manual](./references/reference_manual.md)