---
name: bioconductor-pd.mg.u74cv2
description: This package provides platform design and annotation data for the Affymetrix Murine Genome U74C version 2 array. Use when user asks to process Affymetrix MG_U74Cv2 .CEL files, perform low-level microarray analysis with the oligo package, or access probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74cv2.html
---


# bioconductor-pd.mg.u74cv2

## Overview

The `pd.mg.u74cv2` package is a specialized Bioconductor annotation package (Platform Design) for the Affymetrix Murine Genome U74C version 2 array. It provides the essential mapping between physical grid coordinates on the chip and the biological sequences they represent. This package is primarily intended to be used as a backend dependency for the `oligo` package to enable low-level processing (like normalization and background correction) of .CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be invoked directly:

```r
library(pd.mg.u74cv2)
```

### Integration with oligo
When analyzing MG_U74Cv2 data, ensure this package is installed so `oligo` can identify the chip topology:

```r
library(oligo)
# Assuming .CEL files are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())
# oligo will automatically use pd.mg.u74cv2 to annotate raw_data
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, which is critical for sequence-specific background correction algorithms (like RMA or GCRMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific sequences
# 'fid' corresponds to the feature identifier used in oligo objects
```

### Data Structures
- **pmSequence**: A `DataFrame` object containing the feature ID (`fid`) and the actual nucleotide sequence for PM probes.
- **bgSequence / mmSequence**: If available, these provide sequences for background or Mismatch probes respectively, following the same `fid`/`sequence` format.

## Tips
- **Memory Management**: These annotation objects can be large. If you only need to perform standard normalization (RMA), you rarely need to interact with `pd.mg.u74cv2` directly; `oligo` handles the calls internally.
- **Platform Verification**: Ensure your samples are specifically for the "v2" version of the U74C array, as using the wrong platform design package will result in incorrect probe-to-gene mappings.

## Reference documentation
- [pd.mg.u74cv2 Reference Manual](./references/reference_manual.md)