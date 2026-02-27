---
name: bioconductor-pd.yeast.2
description: This package provides annotation and platform design data for the Affymetrix Yeast Genome 2.0 Array. Use when user asks to process Yeast 2.0 microarray .CEL files, map probe identifiers to sequences, or perform low-level analysis using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.yeast.2.html
---


# bioconductor-pd.yeast.2

name: bioconductor-pd.yeast.2
description: Annotation and platform design data for the Affymetrix Yeast Genome 2.0 Array. Use this skill when performing low-level analysis of Yeast 2.0 microarray data in R, particularly when using the 'oligo' package to process .CEL files, extract probe sequences, or perform background correction and normalization.

# bioconductor-pd.yeast.2

## Overview

The `pd.yeast.2` package is a Platform Design (PD) annotation package for the Affymetrix Yeast Genome 2.0 Array. It provides the essential mapping between probe identifiers (fids) and their sequences. This package is primarily designed to work as a backend for the `oligo` package, enabling the processing of oligonucleotide microarrays at the feature level.

## Installation and Loading

To use this package within an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.yeast.2")

library(pd.yeast.2)
```

## Typical Workflows

### Integration with oligo
The most common use case is implicit. When you load Affymetrix Yeast 2.0 `.CEL` files using the `oligo` package, it automatically detects and loads `pd.yeast.2` to provide the chip layout and sequence information.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# oligo uses pd.yeast.2 here to map probes to probesets
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences, which is useful for custom quality control or sequence-specific normalization (like GC-content adjustment).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence is a DataFrame object
```

### Background and Mismatch Data
The package also contains placeholders or data for background (bg) and mismatch (mm) sequences if applicable to the array design:
- `data(bgSequence)`: Sequence data for background probes.
- `data(mmSequence)`: Sequence data for mismatch probes.

## Usage Tips
- **Memory Management**: PD packages can be large. If you are only performing high-level analysis (probeset level), you may not need to interact with this package directly.
- **Package Dependency**: Ensure `oligo` is installed, as `pd.yeast.2` is specifically built to be used with `oligo`'s classes and methods.
- **Data Format**: Sequences are stored in `DataFrame` objects from the `S4Vectors` package. Use standard S4 subsetting to manipulate them.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)