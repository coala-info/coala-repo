---
name: bioconductor-pd.x.laevis.2
description: This package provides platform design and annotation data for the Affymetrix Xenopus laevis 2.0 microarray. Use when user asks to process Xenopus laevis 2.0 expression data, perform RMA normalization, retrieve probe sequences, or map feature IDs using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.x.laevis.2.html
---

# bioconductor-pd.x.laevis.2

name: bioconductor-pd.x.laevis.2
description: Annotation package for the Affymetrix Xenopus laevis 2.0 microarray platform. Use when processing Xenopus laevis 2.0 expression data, specifically for low-level microarray analysis, probe sequence retrieval, and feature ID mapping in conjunction with the oligo package.

# bioconductor-pd.x.laevis.2

## Overview
The `pd.x.laevis.2` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Xenopus laevis 2.0 array. This package is primarily designed to work behind the scenes with the `oligo` package to facilitate the analysis of high-density oligonucleotide arrays.

## Usage and Workflows

### Integration with oligo
This package is typically not called directly by the user but is required by the `oligo` package when reading CEL files. When you use `read.celfiles()`, the `oligo` package identifies the chip type and loads `pd.x.laevis.2` automatically to map probes to their physical locations and sequences.

```r
library(oligo)
# Assuming .CEL files for Xenopus laevis 2.0 are in the working directory
raw_data <- read.celfiles(list.celfiles())
```

### Accessing Probe Sequences
You can manually inspect the Perfect Match (PM) probe sequences stored within the package. The data is stored in a `DataFrame` object.

```r
library(pd.x.laevis.2)

# Load the PM sequence data
data(pmSequence)

# View the first few entries
# Columns include 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Key Data Objects
- **pmSequence**: Contains the sequences for Perfect Match probes.
- **bgSequence**: Contains background probe sequences (if applicable).
- **mmSequence**: Contains Mismatch probe sequences (if applicable).

### Typical Workflow: RMA Normalization
The most common use case is performing Robust Multi-array Average (RMA) normalization on Xenopus laevis 2.0 data.

```r
library(oligo)
library(pd.x.laevis.2)

# 1. Read CEL files
affy_data <- read.celfiles(filenames = list.celfiles())

# 2. Perform RMA normalization
# The pd.x.laevis.2 package provides the mapping required for this step
eset <- rma(affy_data)

# 3. Access expression values
exp_values <- exprs(eset)
```

## Tips
- Ensure the package is installed via BiocManager: `BiocManager::install("pd.x.laevis.2")`.
- If `oligo` complains about a missing platform design package, verify that this package is installed and that your CEL files are indeed from the Xenopus laevis 2.0 platform.
- The `fid` (feature ID) in the `pmSequence` object corresponds to the row indices in the intensity matrices handled by `oligo`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)