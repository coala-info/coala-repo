---
name: bioconductor-pd.felgene.1.1.st
description: This package provides annotation data and platform design information for the Affymetrix Feline Gene 1.1 ST microarray. Use when user asks to process Feline Gene 1.1 ST .CEL files, map probes to sequences, or perform RMA normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.felgene.1.1.st.html
---


# bioconductor-pd.felgene.1.1.st

name: bioconductor-pd.felgene.1.1.st
description: Provides annotation data for the Affymetrix Feline Gene 1.1 ST (felgene.1.1.st) array. Use this skill when performing low-level analysis of Feline Gene 1.1 ST microarray data, specifically when using the oligo package to process .CEL files, map probes to sequences, or perform RMA normalization.

# bioconductor-pd.felgene.1.1.st

## Overview

The `pd.felgene.1.1.st` package is a Platform Design (PD) annotation package for the Affymetrix Feline Gene 1.1 ST array. It was built using the `pdInfoBuilder` package and is intended to be used in conjunction with the `oligo` package for the analysis of Gene ST arrays. It contains the probe sequence information and the mapping between feature identifiers (fid) and sequences required for preprocessing.

## Usage and Workflows

### Integration with oligo
This package is rarely used standalone. Its primary purpose is to provide the underlying platform geometry and sequence data to the `oligo` package. When you read .CEL files from a Feline Gene 1.1 ST array, `oligo` will automatically look for this package.

```r
library(oligo)

# Read CEL files; oligo uses pd.felgene.1.1.st automatically if the headers match
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences stored in the package.

```r
library(pd.felgene.1.1.st)

# Load the PM sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with columns 'fid' and 'sequence'
head(pmSequence)
```

### Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- Ensure this package is installed in your R library when using `oligo` to process Feline Gene 1.1 ST data, or `read.celfiles` will throw an error regarding missing platform design information.
- The package is platform-independent and works on all operating systems supported by Bioconductor.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)