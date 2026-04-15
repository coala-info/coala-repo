---
name: bioconductor-pd.hta.2.0
description: This package provides annotation data and probe sequences for the Affymetrix Human Transcriptome Array 2.0 to support the oligo package. Use when user asks to process HTA 2.0 CEL files, map probes to genomic targets, or access PM probe sequences for sequence-specific analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hta.2.0.html
---

# bioconductor-pd.hta.2.0

## Overview
The `pd.hta.2.0` package is a Bioconductor annotation data package specifically built using `pdInfoBuilder` for the Affymetrix Human Transcriptome Array 2.0 (HTA 2.0). It serves as a required infrastructure component for the `oligo` package to correctly map probes to their genomic targets and perform feature-level preprocessing.

## Typical Workflow

The package is rarely called directly by the user; instead, it is loaded automatically by the `oligo` package when reading CEL files from the HTA 2.0 platform.

### 1. Loading Data
When you read CEL files using `read.celfiles()`, the `oligo` package identifies the platform and attempts to load `pd.hta.2.0`.

```r
library(oligo)
# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)
# rawData will now be an HTFeatureSet object linked to pd.hta.2.0
```

### 2. Accessing Sequence Information
You can access the Perfect Match (PM) probe sequences stored within the annotation package for sequence-specific analysis (e.g., GC content correction).

```r
library(pd.hta.2.0)
data(pmSequence)

# View the first few sequences
head(pmSequence)
# Returns a DataFrame with 'fid' (feature ID) and 'sequence'
```

### 3. Integration with Analysis
Once the data is loaded with the correct annotation package, you can proceed to standard normalization:

```r
# Robust Multichip Average (RMA) normalization
eset <- rma(rawData)
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for PM probes. It includes the `fid` (feature identifier) and the actual nucleotide `sequence`.
- **bgSequence / mmSequence**: Depending on the specific array design, these provide background or mismatch sequence data if available.

## Tips
- **Installation**: Ensure the package is installed via `BiocManager::install("pd.hta.2.0")`.
- **Memory**: HTA 2.0 arrays are high-density; ensure sufficient RAM is available when loading these annotation objects alongside large CEL file sets.
- **Platform Verification**: If `read.celfiles()` fails to find the annotation, manually check the `annotation` slot of your object or ensure the package name matches the chip type exactly.

## Reference documentation
- [pd.hta.2.0 Reference Manual](./references/reference_manual.md)