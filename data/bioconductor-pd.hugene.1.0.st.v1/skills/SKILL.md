---
name: bioconductor-pd.hugene.1.0.st.v1
description: This package provides annotation and platform design information for the Affymetrix Human Gene 1.0 ST v1 microarray. Use when user asks to process .CEL files, perform RMA normalization, or map probe identifiers for this specific Affymetrix platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hugene.1.0.st.v1.html
---

# bioconductor-pd.hugene.1.0.st.v1

name: bioconductor-pd.hugene.1.0.st.v1
description: Annotation and platform design information for the Affymetrix GeneChip Human Gene 1.0 ST v1 array. Use this skill when processing or analyzing .CEL files from this specific microarray platform using the oligo or xps packages in R.

# bioconductor-pd.hugene.1.0.st.v1

## Overview

The `pd.hugene.1.0.st.v1` package is a Bioconductor annotation package specifically designed for the Affymetrix Human Gene 1.0 ST v1 array. It provides the necessary mapping between probe identifiers, sequences, and physical locations on the chip. This package is primarily used as a backend dependency for the `oligo` package to enable preprocessing, normalization (like RMA), and quality control of "Gene ST" (Whole Transcript) arrays.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.hugene.1.0.st.v1)
```

### 2. Integration with oligo
When analyzing Human Gene 1.0 ST v1 data, use the `read.celfiles` function. The `oligo` package will identify the platform and use this annotation package to create a FeatureSet object.

```r
library(oligo)
# Assuming .CEL files are in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)

# The 'pd.hugene.1.0.st.v1' package is used here to map probes to probesets
eset <- rma(rawData)
```

### 3. Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for sequence-specific analysis (e.g., GC-content studies).

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# Columns: 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

## Key Functions and Data Objects

- **`pd.hugene.1.0.st.v1`**: The main annotation object containing the SQLite database connection for probe-to-gene mappings.
- **`pmSequence`**: A `DataFrame` containing the sequences for the Perfect Match probes.
- **`bgSequence`**: Background probe sequences (if applicable/available via the `data(pmSequence)` call).

## Usage Tips

- **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient RAM when processing large batches of Gene ST arrays.
- **Platform Verification**: Ensure your samples were actually run on the "v1" version of the Human Gene 1.0 ST array; using the wrong version (e.g., v2 or the newer HuGene 2.0 ST) will result in incorrect mappings.
- **Database Queries**: The package uses an SQLite backend. Advanced users can access the underlying database using `db(pd.hugene.1.0.st.v1)` to perform custom SQL queries on probe geometries.

## Reference documentation

- [pd.hugene.1.0.st.v1 Reference Manual](./references/reference_manual.md)