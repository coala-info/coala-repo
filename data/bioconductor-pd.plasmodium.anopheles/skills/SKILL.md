---
name: bioconductor-pd.plasmodium.anopheles
description: This package provides annotation and platform design data for the Affymetrix Plasmodium/Anopheles combined genome microarray. Use when user asks to process Affymetrix Plasmodium/Anopheles CEL files, perform probe-level analysis using the oligo package, or access probe sequence data for these specific chips.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.plasmodium.anopheles.html
---


# bioconductor-pd.plasmodium.anopheles

name: bioconductor-pd.plasmodium.anopheles
description: Annotation package for the Plasmodium/Anopheles genome array. Use this skill when working with Affymetrix Plasmodium/Anopheles combined genome chips in R, specifically for low-level processing, probe-level analysis, and mapping probe sequences using the oligo package.

# bioconductor-pd.plasmodium.anopheles

## Overview
The `pd.plasmodium.anopheles` package is a specialized annotation data package for Bioconductor. It provides the platform design information required to analyze Affymetrix microarrays designed for *Plasmodium falciparum* and *Anopheles gambiae*. It is primarily used as a backend dependency for the `oligo` package to facilitate feature-level preprocessing (like RMA) and to provide access to probe sequence data.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.plasmodium.anopheles)
```

### 2. Integration with oligo
This package provides the infrastructure for the `oligo` package to understand the chip layout.
```r
library(oligo)

# Read CEL files (the package will be used automatically if the chip ID matches)
affyData <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(affyData)
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-based analysis.
```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)

# Access specific sequence information
# Example: Get the sequence for a specific feature ID
pmSequence[pmSequence$fid == 12345, ]
```

### 4. Data Objects
The package contains several internal data objects used for different probe types:
- `pmSequence`: Sequences for Perfect Match probes.
- `mmSequence`: Sequences for Mismatch probes (if present on the array).
- `bgSequence`: Sequences for background probes.

## Tips
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when loading large datasets with `oligo`.
- **Automatic Selection**: You rarely need to call functions inside `pd.plasmodium.anopheles` directly; its main role is providing the SQLite database and sequence data that `oligo` queries in the background.
- **Platform Design**: This package was built using `pdInfoBuilder`. If you need to find the physical coordinates of probes, use the `db(pd.plasmodium.anopheles)` connection to query the underlying SQLite database.

## Reference documentation
- [pd.plasmodium.anopheles Reference Manual](./references/reference_manual.md)