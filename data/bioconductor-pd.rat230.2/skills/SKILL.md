---
name: bioconductor-pd.rat230.2
description: This package provides platform design annotation and probe sequence mapping for the Affymetrix Rat Expression Set 230 2.0 microarray. Use when user asks to process Rat230_2 CEL files, perform RMA normalization with the oligo package, or access probe-specific sequence data for this array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rat230.2.html
---


# bioconductor-pd.rat230.2

name: bioconductor-pd.rat230.2
description: Annotation package for the Affymetrix Rat Expression Set 230 2.0 (Rat230_2) array. Use when processing Affymetrix Rat230_2 microarrays with the 'oligo' package to map probe identifiers to sequences and manage chip-specific metadata.

# bioconductor-pd.rat230.2

## Overview

The `pd.rat230.2` package is a platform design (pd) annotation package for the Affymetrix Rat Expression Set 230 2.0 array. It was built using the `pdInfoBuilder` infrastructure and is specifically designed to work with the `oligo` package for high-level analysis of oligonucleotide arrays. It provides the necessary mapping between feature identifiers (fids) and probe sequences.

## Typical Workflow

### Loading the Package
The package is typically loaded automatically when using `oligo` functions like `read.celfiles`, but it can be loaded manually:

```r
library(pd.rat230.2)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific background correction or quality control.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific columns
# pmSequence$fid
# pmSequence$sequence
```

### Integration with oligo
This package serves as the backend for `oligo` objects. When you have an `ExpressionFeatureSet` created from Rat230_2 CEL files, `oligo` uses this package to:
1. Identify probe locations.
2. Perform RMA (Robust Multi-array Average) normalization.
3. Map probes to their respective probesets.

```r
library(oligo)
# Assuming 'celfiles' is a vector of paths to .CEL files
# rawData <- read.celfiles(celfiles)
# The 'pd.rat230.2' package is used here to provide the chip layout
```

## Usage Tips
- **Memory Management**: The `pmSequence` object can be large. Only load it if you need to perform sequence-level analysis.
- **Compatibility**: Ensure that the version of `pd.rat230.2` matches the Bioconductor release of your `oligo` package to avoid schema mismatches.
- **Data Structure**: The sequences are stored in a `DataFrame` (from the `S4Vectors` package), not a standard R `data.frame`.

## Reference documentation
- [pd.rat230.2 Reference Manual](./references/reference_manual.md)