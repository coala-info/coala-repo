---
name: bioconductor-pd.u133.x3p
description: This package provides annotation and platform design data for the Affymetrix HG-U133_X3P microarray. Use when user asks to process raw CEL files from the HG-U133_X3P platform, map probe identifiers to sequences, or manage chip layout metadata using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.u133.x3p.html
---


# bioconductor-pd.u133.x3p

name: bioconductor-pd.u133.x3p
description: Annotation and platform design package for the Affymetrix HG-U133_X3P (Human Genome U133 X3P) array. Use when processing Affymetrix X3P expression data with the 'oligo' package, specifically for mapping probe identifiers to sequences and managing chip layout metadata.

# bioconductor-pd.u133.x3p

## Overview
The `pd.u133.x3p` package is a specialized annotation dataset built using `pdInfoBuilder`. It provides the necessary infrastructure for the `oligo` package to process raw CEL files from the Affymetrix HG-U133_X3P platform. It contains probe sequence information and the physical layout of the microarray, which is essential for background correction, normalization, and summarization workflows.

## Usage and Workflows

### Loading the Package
The package is typically not called directly by the user but is loaded automatically by `oligo` when reading CEL files. However, it can be loaded manually to inspect probe data:

```r
library(pd.u133.x3p)
```

### Integration with oligo
When analyzing HG-U133_X3P data, ensure this package is installed so `read.celfiles` can correctly identify the platform:

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The 'raw_data' object will automatically link to pd.u133.x3p
```

### Accessing Probe Sequences
The package stores Perfect Match (PM) probe sequences. This is useful for custom sequence-specific analysis or verifying probe properties.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific probe sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **fid**: Feature identifier corresponding to the physical location on the array.
- **sequence**: The actual nucleotide sequence of the probe.

## Tips
- **Memory Management**: These annotation packages can be large. Only load them when performing the initial preprocessing of raw data.
- **Compatibility**: This package is specifically designed for the `oligo` package. If you are using the older `affy` package, you would typically use a CDF-based environment (e.g., `hgu133x3pcdf`) instead of this `pd` (Platform Design) package.
- **Verification**: Use `db(pd.u133.x3p)` to inspect the underlying SQLite database if you need to query specific probe-to-probeset mappings manually.

## Reference documentation
- [pd.u133.x3p Reference Manual](./references/reference_manual.md)