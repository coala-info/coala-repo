---
name: bioconductor-pd.ag
description: This package provides annotation and platform design metadata for the Affymetrix Arabidopsis GeneChip array. Use when user asks to process Arabidopsis microarray data, map probe identifiers to sequences, or manage chip layout information for .CEL files using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ag.html
---

# bioconductor-pd.ag

name: bioconductor-pd.ag
description: Annotation package for the Affymetrix ag (Arabidopsis GeneChip) array. Use this skill when processing Affymetrix Arabidopsis microarray data using the oligo or xps packages, specifically for mapping probe identifiers to sequences and managing chip layout information.

# bioconductor-pd.ag

## Overview

The `pd.ag` package is a Bioconductor annotation data package specifically designed for the Affymetrix Arabidopsis GeneChip (ag). It was built using the `pdInfoBuilder` framework and serves as a platform design (pd) package. Its primary role is to provide the `oligo` package with the necessary metadata to correctly identify probe locations, sequences, and types (PM, MM, background) during the preprocessing of .CEL files.

## Typical Workflow

The `pd.ag` package is rarely called directly by the user; instead, it is loaded automatically by high-level analysis packages when they encounter Arabidopsis GeneChip data.

### 1. Loading the Package
To manually inspect the package or ensure it is available:

```r
library(pd.ag)
```

### 2. Integration with oligo
When reading CEL files, the `oligo` package uses `pd.ag` to create a FeatureSet object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())
# oligo will automatically look for and use pd.ag
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
library(pd.ag)
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

## Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Usage Tips

- **Automatic Triggering**: If you receive an error in `oligo` stating "The annotation package, pd.ag, could not be found," install it via `BiocManager::install("pd.ag")`.
- **Memory Management**: These annotation objects can be large. Only load them if you need to perform sequence-specific probeset analysis.
- **Platform Specificity**: This package is strictly for the "ag" (Arabidopsis) array. Do not use it for the "ath1121501" (Arabidopsis ATH1 Genome Array) which uses `pd.ath1.121501`.

## Reference documentation

- [pd.ag Reference Manual](./references/reference_manual.md)