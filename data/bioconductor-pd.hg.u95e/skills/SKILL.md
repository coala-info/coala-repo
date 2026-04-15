---
name: bioconductor-pd.hg.u95e
description: This package provides annotation data and platform design information for the Affymetrix Human Genome U95e microarray. Use when user asks to process HG-U95E CEL files, retrieve probe sequences, or perform probe-level analysis using the oligo framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95e.html
---

# bioconductor-pd.hg.u95e

name: bioconductor-pd.hg.u95e
description: Annotation data package for the Affymetrix Human Genome U95e (HG-U95E) platform. Use this skill when processing or analyzing HG-U95E microarray data using the 'oligo' or 'biocLite' frameworks, specifically for probe-level operations, feature identification, and sequence retrieval.

# bioconductor-pd.hg.u95e

## Overview
The `pd.hg.u95e` package is a specialized Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix HG-U95E microarray. It is primarily designed to work as a backend for the `oligo` package to enable preprocessing, normalization, and analysis of .CEL files.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be invoked directly:

```r
library(pd.hg.u95e)
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes. This is essential for algorithms that account for sequence-specific binding effects (like GC-RMA).

```r
# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
The most common workflow involves using this package transparently through the `oligo` package to create a FeatureSet object.

```r
library(oligo)

# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
data <- read.celfiles(celFiles)

# oligo will automatically look for pd.hg.u95e if the CEL files 
# are from the HG-U95E platform.
```

### Key Data Objects
- **pmSequence**: A `DataFrame` object containing probe identifiers (`fid`) and their corresponding nucleotide sequences.
- **Platform Design Info**: Internal SQLite databases that map probes to x/y coordinates and feature identifiers.

## Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Compatibility**: This package is specifically for the "e" version of the U95 series. Ensure your array type matches exactly; other U95 variants (like U95A or U95Av2) require different `pd.hg.*` packages.
- **Annotation Mapping**: For higher-level gene mapping (Entrez, Symbol), use this package in conjunction with the `hg95e.db` annotation package.

## Reference documentation
- [pd.hg.u95e Reference Manual](./references/reference_manual.md)