---
name: bioconductor-pd.mouse430.2
description: This package provides platform design and annotation data for the Affymetrix Mouse Genome 430 2.0 Array. Use when user asks to preprocess raw CEL files, map probe identifiers to sequences, or manage chip layout metadata for mouse4302 microarrays.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mouse430.2.html
---


# bioconductor-pd.mouse430.2

name: bioconductor-pd.mouse430.2
description: Annotation and platform design information for the Affymetrix Mouse Genome 430 2.0 Array. Use this skill when processing Affymetrix mouse4302 microarrays using the 'oligo' or 'eeptools' packages, specifically for mapping probe identifiers to sequences and managing chip layout metadata.

# bioconductor-pd.mouse430.2

## Overview
The `pd.mouse430.2` package is a specialized annotation data package for the Affymetrix Mouse Genome 430 2.0 Array. It was built using the `pdInfoBuilder` framework and is designed to work seamlessly with the `oligo` package for high-level analysis of oligonucleotide arrays. Its primary role is to provide the platform design information required to preprocess raw CEL files, including probe sequences and feature identifiers.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on Mouse 430 2.0 data, but can be loaded manually:

```r
library(pd.mouse430.2)
```

### Integration with oligo
The most common workflow involves reading CEL files. The `oligo` package identifies the chip type and calls `pd.mouse430.2` to provide the necessary geometry and annotation.

```r
library(oligo)
# Read CEL files in the current directory
affyData <- read.celfiles(filenames = list.celfiles())

# The 'pd.mouse430.2' package provides the platform design info
# used during preprocessing (e.g., RMA)
eset <- rma(affyData)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is useful for custom quality control or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific probe sequence by feature ID
# pmSequence is a DataFrame object
```

### Key Data Objects
- `pd.mouse430.2`: The main annotation object containing the chip layout.
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence` / `mmSequence`: Background or Mismatch sequences (if applicable to the specific array design).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **Version Consistency**: Ensure that the version of `pd.mouse430.2` matches the Bioconductor release used for your version of `oligo` to avoid compatibility issues.
- **Feature IDs**: The `fid` (Feature ID) is the internal identifier used to link sequences to the physical locations on the array.

## Reference documentation
- [pd.mouse430.2 Reference Manual](./references/reference_manual.md)