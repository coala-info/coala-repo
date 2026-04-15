---
name: bioconductor-pd.2006.07.18.hg18.refseq.promoter
description: This package provides annotation and sequence information for the pd.2006.07.18.hg18.refseq.promoter microarray platform. Use when user asks to process raw CEL files from this promoter array, perform RMA normalization, or retrieve probe sequences using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.2006.07.18.hg18.refseq.promoter.html
---

# bioconductor-pd.2006.07.18.hg18.refseq.promoter

name: bioconductor-pd.2006.07.18.hg18.refseq.promoter
description: Annotation package for the pd.2006.07.18.hg18.refseq.promoter platform. Use when processing microarray data (CEL files) from this specific hg18 RefSeq promoter array, typically in conjunction with the oligo package for low-level analysis, normalization, and probe sequence retrieval.

# bioconductor-pd.2006.07.18.hg18.refseq.promoter

## Overview
The `pd.2006.07.18.hg18.refseq.promoter` package is a Platform Design (PD) annotation package. It provides the necessary mapping and sequence information for the NimbleGen/Affymetrix-style promoter array targeting hg18 RefSeq promoter regions. It is primarily designed to be used as a backend for the `oligo` package to facilitate the preprocessing of raw intensity data.

## Installation
To install the package, use the Bioconductor manager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.2006.07.18.hg18.refseq.promoter")
```

## Typical Workflow
This package is rarely used in isolation. It is automatically called by the `oligo` package when reading CEL files associated with this platform.

### 1. Loading Data with oligo
When you use `read.celfiles()`, the `oligo` package identifies the platform and loads this annotation package to create a FeatureSet object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
```

### 2. Accessing Probe Sequences
You can manually access the probe sequence data (Perfect Match, Background, or Mismatch sequences) stored within the package.

```r
library(pd.2006.07.18.hg18.refseq.promoter)

# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### 3. Integration with Analysis
Once the data is loaded into a FeatureSet via `oligo`, you can perform standard operations like RMA normalization:

```r
# RMA normalization (uses the pd package information internally)
eset <- rma(raw_data)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the feature IDs (`fid`) and the corresponding nucleotide sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Tips
- Ensure that the version of the `pd` package matches the array design used in your experiment.
- If `oligo` fails to find the package automatically, ensure it is loaded in your R session using `library(pd.2006.07.18.hg18.refseq.promoter)`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)