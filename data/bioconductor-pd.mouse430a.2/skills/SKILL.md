---
name: bioconductor-pd.mouse430a.2
description: This package provides annotation data and probe sequences for the Affymetrix Mouse Genome 430A 2.0 Array. Use when user asks to process raw CEL files from Mouse 430A 2.0 microarrays, retrieve probe sequence data, or perform feature-level preprocessing using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mouse430a.2.html
---


# bioconductor-pd.mouse430a.2

name: bioconductor-pd.mouse430a.2
description: Provides annotation data for the Affymetrix Mouse Genome 430A 2.0 Array. Use this skill when processing or analyzing Affymetrix mouse430a2 microarrays in R, specifically when using the oligo package to handle raw CEL files, retrieve probe sequences, or perform feature-level preprocessing.

# bioconductor-pd.mouse430a.2

## Overview

The `pd.mouse430a.2` package is a Platform Design (PD) annotation package for the Affymetrix Mouse Genome 430A 2.0 Array. It was built using the `pdInfoBuilder` package and is specifically designed to work in tandem with the `oligo` package. It contains the mapping information between probes and their physical locations on the chip, as well as sequence data for Perfect Match (PM) and Mismatch (MM) probes.

## Usage

### Loading the Package

Load the package into the R environment:

```R
library(pd.mouse430a.2)
```

### Integration with oligo

This package is typically not called directly by the user but is loaded automatically by the `oligo` package when reading CEL files from the Mouse 430A 2.0 platform.

```R
library(oligo)

# Read CEL files; oligo will automatically look for pd.mouse430a.2
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences

You can access the sequence data for the probes on this array using the `pmSequence` dataset. This is useful for custom quality control or sequence-specific analysis.

```R
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences
# fid corresponds to the feature ID used in the oligo objects
```

### Available Datasets

The package provides several internal datasets representing different probe types:
- `pmSequence`: Sequences for Perfect Match probes.
- `mmSequence`: Sequences for Mismatch probes (if applicable).
- `bgSequence`: Sequences for background probes.

## Tips

- **Automatic Detection**: Ensure this package is installed if you encounter errors in `oligo::read.celfiles()` stating that the annotation package for "Mouse430A_2" is missing.
- **Memory Management**: PD packages can be large. If working with many arrays, ensure your R session has sufficient memory to hold the annotation environment.
- **Feature IDs**: Use the `fid` column in the sequence dataframes to map sequences back to the expression features in your `ExpressionSet` or `FeatureSet` objects.

## Reference documentation

- [pd.mouse430a.2 Reference Manual](./references/reference_manual.md)