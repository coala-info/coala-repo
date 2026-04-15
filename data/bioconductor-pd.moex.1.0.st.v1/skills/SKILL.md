---
name: bioconductor-pd.moex.1.0.st.v1
description: This Bioconductor package provides platform design and annotation data for the Affymetrix Mouse Exon 1.0 ST microarray. Use when user asks to process raw CEL files for Mouse Exon 1.0 ST arrays, map probe identifiers to sequences, or perform background correction and normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.moex.1.0.st.v1.html
---

# bioconductor-pd.moex.1.0.st.v1

name: bioconductor-pd.moex.1.0.st.v1
description: Annotation package for the Affymetrix MoEx-1_0-st-v1 (Mouse Exon 1.0 ST) array. Use when processing Mouse Exon ST 1.0 microarray data with the oligo package to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.moex.1.0.st.v1

## Overview

The `pd.moex.1.0.st.v1` package is a Bioconductor annotation data package specifically designed for the Affymetrix Mouse Exon 1.0 ST (MoEx-1.0-st-v1) array. It provides the necessary platform design information required by the `oligo` package to process raw CEL files, perform background correction, normalization, and summarization.

## Typical Workflow

This package is rarely used in isolation; it is automatically called by the `oligo` package when it detects the Mouse Exon 1.0 ST platform.

### 1. Loading the Package
While `oligo` usually loads this automatically, you can load it manually to inspect probe sequences:

```r
library(pd.moex.1.0.st.v1)
```

### 2. Integration with oligo
When reading CEL files for this platform, ensure this package is installed:

```r
library(oligo)

# Read CEL files in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)

# The 'rawData' object will automatically reference pd.moex.1.0.st.v1
# to understand the chip layout.
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package:

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

## Usage Tips

- **Memory Management**: Exon arrays are high-density. Ensure your R session has sufficient RAM when processing large batches of CEL files using this annotation.
- **Platform Matching**: This package is specific to version 1 (`v1`) of the Mouse Exon 1.0 ST array. Ensure your array type matches exactly.
- **Database Connection**: The package uses an SQLite backend. You can explore the underlying database structure if needed:
  ```r
  conn <- db(pd.moex.1.0.st.v1)
  dbListTables(conn)
  ```

## Reference documentation

- [pd.moex.1.0.st.v1 Reference Manual](./references/reference_manual.md)