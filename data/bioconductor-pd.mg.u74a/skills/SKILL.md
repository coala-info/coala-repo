---
name: bioconductor-pd.mg.u74a
description: This package provides platform design and annotation data for the Affymetrix Murine Genome U74A microarray. Use when user asks to process MgU74A microarray data, map probe identifiers to sequences, or perform normalization using the oligo framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74a.html
---


# bioconductor-pd.mg.u74a

name: bioconductor-pd.mg.u74a
description: Annotation package for the Murine Genome U74A (MgU74A) Affymetrix array. Use when processing Affymetrix MgU74A microarray data with the 'oligo' or 'biocLite' frameworks to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.mg.u74a

## Overview
The `pd.mg.u74a` package is a specialized annotation data package built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Murine Genome U74A array. It is primarily designed to work as a backend for the `oligo` package to facilitate preprocessing, normalization, and analysis of high-density oligonucleotide arrays.

## Typical Workflow

### Loading the Package
To use the annotation data, load the package alongside the `oligo` package:

```r
library(oligo)
library(pd.mg.u74a)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) and Mismatch (MM) probes. This is often used for background correction or sequence-specific analysis.

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
When reading CEL files from the MgU74A platform, the `oligo` package automatically searches for this package to create a FeatureSet object.

```r
# Example: Reading CEL files
# celFiles <- list.celfiles()
# rawData <- read.celfiles(celFiles)

# The 'rawData' object will automatically link to pd.mg.u74a 
# if the CEL files are from the MgU74A platform.
```

## Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for the Perfect Match probes.
- `mmSequence`: A `DataFrame` containing the sequences for the Mismatch probes (if applicable).
- `bgSequence`: Background probe sequences used for specific normalization algorithms.

## Usage Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient memory when loading `pmSequence`.
- **Platform Matching**: This package is specific to the "u74a" version of the murine genome array. Ensure it matches your specific chip version (e.g., do not confuse with u74av2).
- **Functionality**: Most users will not call functions within `pd.mg.u74a` directly but will instead rely on `oligo` methods like `rma()` or `snprma()` which utilize this package internally.

## Reference documentation
- [pd.mg.u74a Reference Manual](./references/reference_manual.md)