---
name: bioconductor-pd.mirna.4.0
description: This package provides platform design and annotation data for the Affymetrix miRNA 4.0 array. Use when user asks to process miRNA 4.0 CEL files, normalize array data using the oligo package, or retrieve probe sequences for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mirna.4.0.html
---


# bioconductor-pd.mirna.4.0

name: bioconductor-pd.mirna.4.0
description: Annotation package for the Affymetrix miRNA 4.0 array. Use when processing, normalizing, or analyzing miRNA 4.0 array data in R, specifically when using the oligo package to handle CEL files, map probes, or retrieve probe-level sequences for this specific platform.

# bioconductor-pd.mirna.4.0

## Overview
The `pd.mirna.4.0` package is a Bioconductor annotation resource providing the platform design information for the Affymetrix miRNA 4.0 array. It is built using `pdInfoBuilder` and is primarily intended to be used as a backend for the `oligo` package. It contains the mapping between probe identifiers and their physical locations or sequences on the array.

## Usage
This package is rarely called directly by the user. Instead, it is loaded automatically by the `oligo` package when processing miRNA 4.0 CEL files.

### Loading the Package
```r
library(pd.mirna.4.0)
```

### Integration with oligo
When analyzing miRNA 4.0 data, ensure this package is installed so that `read.celfiles` can correctly identify the array platform:

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences stored in the package:

```r
library(pd.mirna.4.0)
data(pmSequence)

# View the first few sequences
head(pmSequence)

# The object is a DataFrame with columns: 'fid' (feature ID) and 'sequence'
```

## Workflows

### Standard Preprocessing
1. Load the `oligo` library.
2. Use `read.celfiles()` to import miRNA 4.0 data. The `pd.mirna.4.0` package will be used to provide the necessary annotation metadata.
3. Use `rma()` or `normalize()` for background correction and normalization.

### Sequence Analysis
If you need to perform sequence-specific analysis (e.g., GC content calculation or cross-hybridization checks), use the `pmSequence` dataset to retrieve the 25-mer sequences associated with each feature ID.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)