---
name: bioconductor-pd.moe430b
description: This package provides platform design information and probe mappings for the Affymetrix Mouse Expression 430B array. Use when user asks to preprocess MOE430B CEL files, perform RMA normalization on mouse expression data, or access probe sequence information for the 430B platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.moe430b.html
---


# bioconductor-pd.moe430b

## Overview
The `pd.moe430b` package is a Bioconductor annotation package specifically designed for the Affymetrix Mouse Expression 430B (MOE430B) platform. It was built using the `pdInfoBuilder` infrastructure and is intended to be used as a "platform design" (pd) package. Its primary role is to provide the `oligo` package with the necessary mapping between probe IDs, x/y coordinates, and sequences required for preprocessing (e.g., RMA, GCRMA) and feature-level analysis.

## Usage in R

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on MOE430B CEL files, but can be loaded manually:

```r
library(pd.moe430b)
```

### Integration with oligo
When reading CEL files, `oligo` identifies the platform and looks for this package:

```r
library(oligo)
# Assuming .CEL files for MOE430B are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.moe430b' package provides the underlying geometry and sequence data
# for preprocessing steps like RMA:
eset <- rma(raw_data)
```

### Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, which is essential for background correction methods that account for GC content.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific probe sequence by its feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for Perfect Match probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch probes (if applicable).

## Workflow Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient memory when performing preprocessing on large datasets.
- **Platform Matching**: This package is specific to the **430B** array. If you are using the 430A or 430 2.0 arrays, you must use `pd.moe430a` or `pd.mouse430.2` respectively.
- **Database Connection**: Under the hood, this package uses an SQLite database to store mappings. You can access the connection via `db(raw_data)` if `raw_data` is an `FeatureStack` object from `oligo`.

## Reference documentation
- [pd.moe430b Reference Manual](./references/reference_manual.md)