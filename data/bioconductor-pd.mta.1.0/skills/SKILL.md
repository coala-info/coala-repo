---
name: bioconductor-pd.mta.1.0
description: This package provides platform design and annotation data for the Affymetrix Mouse Transcriptome Array 1.0. Use when user asks to preprocess MTA 1.0 CEL files using the oligo package, access probe sequences, or retrieve feature-level mapping for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mta.1.0.html
---

# bioconductor-pd.mta.1.0

name: bioconductor-pd.mta.1.0
description: Annotation package for the Affymetrix MTA-1_0 (Mouse Transcriptome Array 1.0). Use this skill when processing Mouse Transcriptome Array 1.0 CEL files using the oligo package, requiring platform design information, probe sequences, or feature-level annotation.

# bioconductor-pd.mta.1.0

## Overview
The `pd.mta.1.0` package is a Bioconductor annotation package specifically designed for the Affymetrix Mouse Transcriptome Array 1.0 (MTA 1.0). It provides the necessary platform design information required by the `oligo` package to preprocess raw intensity data (CEL files). It contains mapping between probes, probe sets, and their physical locations on the array, as well as probe sequence information.

## Workflow and Usage

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on MTA 1.0 data, but can be loaded manually:

```r
library(pd.mta.1.0)
```

### Integration with oligo
The primary use case is providing the annotation environment for `read.celfiles`. When reading CEL files from the Mouse Transcriptome Array 1.0, `oligo` identifies this package as the required annotation provider.

```r
library(oligo)
# Read CEL files; pd.mta.1.0 is used under the hood
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for GC-content based normalization or sequence-specific analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Package Details
- **Platform**: Affymetrix Mouse Transcriptome Array 1.0.
- **Database**: The package uses an SQLite database to store feature-level annotations.
- **Object Type**: The main annotation object is an instance of the `PlatformDesign` class (defined in `oligoClasses`).

## Tips
- Ensure `oligo` is installed, as `pd.mta.1.0` is a data-only package meant to support `oligo` workflows.
- If you encounter errors regarding "Annotation package not found," ensure this package is installed via `BiocManager::install("pd.mta.1.0")`.
- For gene-level or transcript-level metadata (symbols, Entrez IDs), you may need the corresponding chip-specific annotation package (e.g., `mta10sttranscriptcluster.db`) in addition to this platform design package.

## Reference documentation
- [pd.mta.1.0 Reference Manual](./references/reference_manual.md)