---
name: bioconductor-pd.yg.s98
description: This package provides platform design and annotation data for the Affymetrix Yeast Genome S98 microarray. Use when user asks to preprocess .CEL files, map probe identifiers to sequences, or perform feature-level analysis for the yg.s98 array using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.yg.s98.html
---


# bioconductor-pd.yg.s98

name: bioconductor-pd.yg.s98
description: Annotation package for the Yeast Genome S98 (yg.s98) Affymetrix array. Use this skill when processing or analyzing yg.s98 microarray data in R, specifically when using the 'oligo' or 'biocLite' frameworks for preprocessing, feature-level analysis, or mapping probe identifiers to sequences.

# bioconductor-pd.yg.s98

## Overview
The `pd.yg.s98` package is a platform design (pd) annotation package for the Affymetrix Yeast Genome S98 array. It is primarily designed to work as a backend for the `oligo` package to enable the preprocessing of .CEL files. It contains the mapping between probe identifiers, x/y coordinates on the chip, and probe sequences.

## Typical Workflow

### Loading the Package
To use this annotation data, load the package alongside the `oligo` library:

```r
library(oligo)
library(pd.yg.s98)
```

### Data Import and Preprocessing
When reading .CEL files for the Yeast S98 array, the `oligo` package automatically searches for this package to build the `FeatureSet` object.

```r
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'annotation' slot of raw_data will be set to "pd.yg.s98"
# You can then proceed with RMA or other preprocessing
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis (e.g., GC content calculations or custom background correction).

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID used in the FeatureSet/ExpressionSet
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **mmSequence**: (If applicable) Sequences for Mismatch probes.
- **bgSequence**: (If applicable) Sequences for background probes.

## Tips
- **Automatic Integration**: You rarely need to call functions inside `pd.yg.s98` directly. Its main purpose is to provide the SQLite database schema that `oligo` uses to understand the physical layout of the S98 chip.
- **Memory Management**: These annotation objects can be large. If you are finished with the sequence data, use `rm(pmSequence)` to free up memory.
- **Verification**: Ensure the annotation string in your `FeatureSet` object matches "pd.yg.s98" to confirm the correct platform design is being used.

## Reference documentation
- [pd.yg.s98 Reference Manual](./references/reference_manual.md)