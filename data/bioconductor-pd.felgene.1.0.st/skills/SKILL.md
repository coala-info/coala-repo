---
name: bioconductor-pd.felgene.1.0.st
description: This package provides annotation and platform design data for the Affymetrix Feline Gene 1.0 ST microarray. Use when user asks to process .CEL files, perform RMA normalization, or map probe sequences for the Feline Gene 1.0 ST platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.felgene.1.0.st.html
---

# bioconductor-pd.felgene.1.0.st

name: bioconductor-pd.felgene.1.0.st
description: Annotation package for the Affymetrix Feline Gene 1.0 ST array. Use when preprocessing or analyzing microarray data from this specific platform, typically in conjunction with the oligo package for RMA normalization and probe-level analysis.

# bioconductor-pd.felgene.1.0.st

## Overview
The `pd.felgene.1.0.st` package is a Platform Design (PD) annotation package for the Affymetrix Feline Gene 1.0 ST array. It provides the necessary mapping between probe identifiers and their physical locations or sequences on the microarray. This package is primarily used as a backend dependency for the `oligo` package to enable the processing of .CEL files.

## Installation and Loading
To use this package within an R session:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("pd.felgene.1.0.st")
library(pd.felgene.1.0.st)
```

## Typical Workflow with oligo
This package is rarely called directly by the user. Instead, it is automatically loaded by the `oligo` package when reading CEL files from the Feline Gene 1.0 ST platform.

1. **Read Data**: Use `read.celfiles()` from the `oligo` package. The function will identify the chip type and load `pd.felgene.1.0.st` automatically.
2. **Normalization**: Perform Robust Multi-array Average (RMA) normalization.
3. **Sequence Analysis**: Access probe sequences if needed for specific downstream quality control.

```R
library(oligo)

# Read CEL files in the current directory
raw_data <- read.celfiles(list.celfiles())

# The pd.felgene.1.0.st package is used here to map probes
eset <- rma(raw_data)
```

## Accessing Probe Sequences
If you need to inspect the probe sequences (Perfect Match, Background, or Mismatch), you can load the sequence data directly.

```R
library(pd.felgene.1.0.st)
data(pmSequence)

# View the first few sequences
head(pmSequence)
```

The `pmSequence` object is a `DataFrame` containing:
- `fid`: Feature ID.
- `sequence`: The actual nucleotide sequence of the probe.

## Tips
- Ensure the version of `pd.felgene.1.0.st` matches the Bioconductor release you are using to avoid compatibility issues with the `oligo` package.
- If `read.celfiles()` fails to find the annotation package, manually install it using `BiocManager::install("pd.felgene.1.0.st")`.
- This package is specific to the "ST" (Sense Target) array architecture, which differs from older 3' IVT arrays.

## Reference documentation
- [pd.felgene.1.0.st Reference Manual](./references/reference_manual.md)