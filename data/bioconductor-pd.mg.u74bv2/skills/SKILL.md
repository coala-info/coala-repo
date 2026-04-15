---
name: bioconductor-pd.mg.u74bv2
description: This package provides platform design information for Affymetrix Mouse Genome U74Bv2 microarrays to support low-level data analysis. Use when user asks to process .CEL files, perform RMA normalization, or retrieve probe sequences for the MG-U74Bv2 platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74bv2.html
---

# bioconductor-pd.mg.u74bv2

name: bioconductor-pd.mg.u74bv2
description: Use this skill when performing low-level analysis of Affymetrix Mouse Genome U74Bv2 microarrays. This package provides the platform design (pd) information required by the 'oligo' package to process .CEL files, including probe sequences and feature identifiers.

# bioconductor-pd.mg.u74bv2

## Overview

The `pd.mg.u74bv2` package is a Bioconductor annotation resource built with `pdInfoBuilder`. It serves as a platform design package for the Affymetrix MG-U74Bv2 (Mouse Genome U74B version 2) array. Its primary purpose is to provide the `oligo` package with the necessary mapping and sequence information to perform preprocessing, normalization (like RMA), and quality control on raw intensity data.

## Usage

This package is rarely called directly by the user; instead, it is typically loaded automatically by the `oligo` package when it detects the MG-U74Bv2 chip type.

### Integration with oligo

When reading raw data, `oligo` uses this package to understand the physical layout of the chip:

```r
library(oligo)
# Assuming .CEL files for MG-U74Bv2 are in the working directory
raw_data <- read.celfiles(list.celfiles())

# The 'pd.mg.u74bv2' package is used behind the scenes for:
# 1. Background correction
# 2. Normalization (e.g., rma(raw_data))
# 3. Summarization
```

### Accessing Probe Sequences

If you need to retrieve the actual nucleotide sequences for the Perfect Match (PM) probes on the array, you can load the sequence data manually:

```r
library(pd.mg.u74bv2)
data(pmSequence)

# View the first few sequences
head(pmSequence)
# Columns: 'fid' (feature ID) and 'sequence'
```

### Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Tips

- **Automatic Loading**: You do not usually need to call `library(pd.mg.u74bv2)` manually if you are using `read.celfiles()`; the `oligo` package will identify the correct annotation package from the CEL file header.
- **Memory**: Annotation packages can be large. Ensure your R environment has sufficient memory when processing large batches of Affymetrix arrays.
- **Platform Specificity**: This package is specific to version 2 of the U74B mouse genome array. Ensure your experimental data matches this specific platform version.

## Reference documentation

- [pd.mg.u74bv2 Reference Manual](./references/reference_manual.md)