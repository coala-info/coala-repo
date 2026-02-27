---
name: bioconductor-pd.mg.u74c
description: This package provides platform design and annotation data for the Affymetrix Murine Genome U74C array. Use when user asks to process MG-U74C CEL files, access probe sequences, or manage feature-level annotations using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74c.html
---


# bioconductor-pd.mg.u74c

name: bioconductor-pd.mg.u74c
description: Annotation package for the Affymetrix MG-U74C (Murine Genome U74C) array. Use this skill when working with the pd.mg.u74c R package to manage platform design information, probe sequences, and feature-level annotations for the oligo package.

# bioconductor-pd.mg.u74c

## Overview
The `pd.mg.u74c` package is a Bioconductor annotation data package specifically built using `pdInfoBuilder` for the Affymetrix Murine Genome U74C array. It provides the necessary mapping between probe identifiers and physical locations/sequences required by the `oligo` package for preprocessing and analyzing microarrays.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded alongside the `oligo` package.

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.mg.u74c")
library(pd.mg.u74c)
library(oligo)
```

## Typical Workflow
This package is primarily used automatically by the `oligo` package when reading CEL files from the MG-U74C platform.

1.  **Loading Data**: When you use `read.celfiles()`, the `oligo` package identifies the platform and loads `pd.mg.u74c` to provide the layout information.
2.  **Preprocessing**: Functions like `rma()` or `backgroundCorrect()` utilize the platform design information contained in this package.
3.  **Accessing Probe Sequences**: You can manually inspect the probe sequences if needed for custom analysis.

## Accessing Sequence Data
The package contains sequence information for Perfect Match (PM) probes, and where applicable, Mismatch (MM) or Background (BG) probes.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Accessing specific probe sequences
# 'fid' corresponds to the feature ID on the array
```

## Key Data Objects
- **pmSequence**: A `DataFrame` object containing the sequences for PM probes. It has two columns: `fid` (feature ID) and `sequence`.
- **bgSequence**: Sequence data for background probes (if available).
- **mmSequence**: Sequence data for mismatch probes (if available).

## Tips
- **Automatic Integration**: You rarely need to call functions directly from `pd.mg.u74c`. Its main role is to provide the SQLite database and sequence data that `oligo` uses in the background.
- **Memory Management**: These annotation packages can be large. Ensure you have sufficient RAM when processing large batches of MG-U74C CEL files.
- **Platform Verification**: If `oligo` fails to recognize the array type, manually check the `annotation` slot of your `FeatureSet` object to ensure it is set to `"pd.mg.u74c"`.

## Reference documentation
- [pd.mg.u74c Reference Manual](./references/reference_manual.md)