---
name: bioconductor-pd.zebrafish
description: This package provides platform design and annotation data for the Affymetrix Zebrafish genome microarray. Use when user asks to process zebrafish microarray data, map probe identifiers to sequences, or provide platform information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.zebrafish.html
---


# bioconductor-pd.zebrafish

name: bioconductor-pd.zebrafish
description: Annotation package for the Zebrafish genome (Affymetrix Zebrafish GeneChip). Use this skill when working with zebrafish microarray data in R, specifically for mapping probe identifiers to sequences and providing platform design information for the 'oligo' or 'eeR' packages.

# bioconductor-pd.zebrafish

## Overview
The `pd.zebrafish` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Zebrafish genome array. It is primarily designed to work in tandem with the `oligo` package to facilitate the preprocessing and analysis of zebrafish microarray data.

## Typical Workflow

### 1. Loading the Package
To use the annotation data, load the library in your R session:
```r
library(pd.zebrafish)
```

### 2. Integration with oligo
This package is rarely used in isolation. It is automatically called by the `oligo` package when reading CEL files from a Zebrafish array:
```r
library(oligo)
# Assuming .CEL files are in the current directory
affyData <- read.celfiles(list.celfiles())
# oligo uses pd.zebrafish automatically to identify probe locations and types
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom quality control or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Accessing a specific sequence by feature ID
# pmSequence[pmSequence$fid == 123, ]
```

## Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large datasets with `oligo`.
- **Platform Matching**: This package is specific to the standard Affymetrix Zebrafish GeneChip. If you are using a different zebrafish array (e.g., Zebrafish Gene 1.0 ST), you may need a different `pd.package`.
- **Database Connection**: The package uses an SQLite database backend. You can see the connection information by typing `pd.zebrafish`.

## Reference documentation
- [pd.zebrafish Reference Manual](./references/reference_manual.md)