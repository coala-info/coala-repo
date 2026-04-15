---
name: bioconductor-pd.cyngene.1.1.st
description: This package provides annotation and platform design information for the Affymetrix CytoScan Gene 1.1 ST array. Use when user asks to process CEL files, normalize microarray data, or retrieve probe sequences for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.cyngene.1.1.st.html
---

# bioconductor-pd.cyngene.1.1.st

name: bioconductor-pd.cyngene.1.1.st
description: Annotation and platform design information for the Affymetrix CytoScan Gene 1.1 ST array. Use when processing, normalizing, or analyzing CytoScan Gene 1.1 ST microarrays using the oligo or biomaRt packages in R.

# bioconductor-pd.cyngene.1.1.st

## Overview
The `pd.cyngene.1.1.st` package is a Bioconductor annotation package specifically designed for the Affymetrix CytoScan Gene 1.1 ST platform. It provides the necessary mapping between probe identifiers and physical locations on the array, as well as probe sequence information. It is primarily used as a backend for the `oligo` package to enable the preprocessing of .CEL files.

## Installation
To use this package, it must be installed via BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.cyngene.1.1.st")
```

## Typical Workflow
This package is rarely called directly by the user; instead, it is automatically loaded by the `oligo` package when reading CEL files from this specific platform.

### 1. Loading Data
When reading CEL files, `oligo` identifies the platform and requires this package to create a FeatureSet object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
data <- read.celfiles(celFiles)
# The 'data' object will automatically use pd.cyngene.1.1.st for annotation
```

### 2. Accessing Probe Sequences
If you need to retrieve the Perfect Match (PM) probe sequences for sequence-specific analysis (e.g., GC content correction):

```r
library(pd.cyngene.1.1.st)
data(pmSequence)
# View the first few sequences
head(pmSequence)
```
The `pmSequence` object is a `DataFrame` containing:
- `fid`: Feature identifier.
- `sequence`: The actual nucleotide sequence.

### 3. Integration with Analysis
Once the data is loaded into a FeatureSet, you can proceed with standard normalization (like RMA):

```r
eset <- rma(data)
```

## Tips
- **Memory Management**: Annotation packages for ST (Sense Target) arrays can be memory-intensive. Ensure your R session has sufficient RAM when processing large batches of CEL files.
- **Automatic Triggering**: You do not usually need to call `library(pd.cyngene.1.1.st)` manually if you are using `read.celfiles()`; the `oligo` package handles the lookup based on the CEL file header.

## Reference documentation
- [pd.cyngene.1.1.st Reference Manual](./references/reference_manual.md)