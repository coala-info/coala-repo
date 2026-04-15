---
name: bioconductor-pd.rae230a
description: This package provides platform design and annotation data for the Affymetrix Rat Expression 230A array to support preprocessing and normalization. Use when user asks to process CEL files from the rae230a platform, perform RMA normalization on rat expression data, or access probe sequence information for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rae230a.html
---

# bioconductor-pd.rae230a

## Overview
The `pd.rae230a` package is a Bioconductor annotation interface specifically designed for the Affymetrix Rat Expression 230A array. It provides the necessary platform design information required by the `oligo` package to perform preprocessing, normalization (like RMA), and quality control of CEL files. It contains probe sequence information and mapping between feature IDs and sequences.

## Typical Workflow

### 1. Loading the Package
The package is typically loaded automatically when reading CEL files with `oligo`, but can be called directly:
```r
library(pd.rae230a)
```

### 2. Integration with oligo
The primary use case is providing the platform design (pd) object to `read.celfiles`. The `oligo` package identifies the chip type and looks for this annotation package.

```r
library(oligo)
# Read CEL files - pd.rae230a is used under the hood
raw_data <- read.celfiles(filenames = list.celfiles())

# Perform RMA normalization
eset <- rma(raw_data)
```

### 3. Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe sequences by Feature ID
# Example: Get sequence for feature ID 100
pmSequence[pmSequence$fid == 100, ]
```

## Usage Tips
- **Memory Management**: This package uses `SQLite` and `ff` to handle large annotation datasets efficiently. Ensure you have sufficient disk space for temporary files if working with large datasets.
- **Platform Specificity**: This package is strictly for the `rae230a` design. For the newer "Rat Genome 230 2.0" array (which contains more probes), use `pd.rat230.2`.
- **Database Connection**: You can inspect the underlying database using `db(pd.rae230a)`, though direct SQL queries are rarely needed for standard workflows.

## Reference documentation
- [pd.rae230a Reference Manual](./references/reference_manual.md)