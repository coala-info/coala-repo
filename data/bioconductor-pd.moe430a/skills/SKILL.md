---
name: bioconductor-pd.moe430a
description: This package provides annotation data and probe sequences for the Affymetrix Mouse Expression 430A microarray platform. Use when user asks to process MOE430A CEL files, perform RMA normalization with the oligo package, or retrieve probe sequence information for this specific mouse array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.moe430a.html
---

# bioconductor-pd.moe430a

name: bioconductor-pd.moe430a
description: Provides annotation data for the Affymetrix Mouse Expression 430A (MOE430A) platform. Use this skill when processing or analyzing MOE430A microarray data in R, specifically when using the 'oligo' package for preprocessing, feature-level analysis, or retrieving probe sequence information.

# bioconductor-pd.moe430a

## Overview

The `pd.moe430a` package is a platform design (PD) annotation package for the Affymetrix Mouse Expression 430A microarray. It was built using the `pdInfoBuilder` infrastructure and is specifically designed to work with the `oligo` package. It provides the necessary mapping between probe identifiers, physical locations on the array, and probe sequences (PM, MM, and background).

## Typical Workflow

### Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.moe430a)
```

### Accessing Probe Sequences
You can access the sequence data for Perfect Match (PM) probes, which is stored as a `DataFrame`.

```r
# Load the sequence data
data(pmSequence)

# View the structure (columns: fid, sequence)
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence[pmSequence$fid == some_id, ]
```

### Integration with oligo
This package acts as the backend for `oligo` functions. When you have an `ExpressionFeatureSet` object created from MOE430A CEL files, `oligo` uses this package to:
1. Perform RMA or GCRMA normalization.
2. Map probes to probesets.
3. Retrieve probe sequences for sequence-specific background correction.

```r
library(oligo)
# Assuming celFiles is a list of .CEL files for MOE430A
rawData <- read.celfiles(celFiles)

# The 'pd.moe430a' package is used here internally
eset <- rma(rawData)
```

## Data Objects

- `pmSequence`: A `DataFrame` containing the sequences for Perfect Match probes.
- `mmSequence`: (If applicable) Sequences for Mismatch probes.
- `bgSequence`: (If applicable) Sequences for background probes.

Each sequence object contains:
- `fid`: The feature identifier (integer).
- `sequence`: The actual nucleotide sequence (character).

## Tips
- Ensure `oligo` is installed, as `pd.moe430a` is rarely used in isolation.
- If you encounter errors regarding "package not found" when reading CEL files, manually install this package using `BiocManager::install("pd.moe430a")`.

## Reference documentation

- [pd.moe430a Reference Manual](./references/reference_manual.md)