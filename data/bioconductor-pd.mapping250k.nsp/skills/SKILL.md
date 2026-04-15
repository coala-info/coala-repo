---
name: bioconductor-pd.mapping250k.nsp
description: This package provides annotation data for the Affymetrix Mapping 250K NSP SNP array to support the oligo package. Use when user asks to process CEL files, normalize SNP chip data, or map probe sequences to genomic coordinates for the Mapping250K_Nsp platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mapping250k.nsp.html
---

# bioconductor-pd.mapping250k.nsp

name: bioconductor-pd.mapping250k.nsp
description: Annotation package for the Affymetrix Mapping 250K NSP SNP array. Use when processing, normalizing, or analyzing SNP chip data from the Mapping250K_Nsp platform using the oligo package.

# bioconductor-pd.mapping250k.nsp

## Overview

The `pd.mapping250k.nsp` package is a Platform Design (PD) annotation package for the Affymetrix Mapping 250K NSP (Sty/Nsp) microarray. It provides the necessary SQLite-based infrastructure for the `oligo` package to map probe sequences to genomic coordinates, SNPs, and alleles. This package is essential for low-level processing of CEL files from this specific platform.

## Usage Guidance

### Loading the Package

The package is typically loaded automatically when using `oligo` functions on compatible CEL files, but can be loaded manually:

```r
library(pd.mapping250k.nsp)
```

### Integration with oligo

This package is designed to work as a backend for the `oligo` package. It is required for functions like `read.celfiles`, `rma`, and `snprma`.

```r
library(oligo)

# Read CEL files for the 250k NSP array
celFiles <- list.celfiles(full.names = TRUE)
featureData <- read.celfiles(celFiles)

# The 'pd.mapping250k.nsp' package provides the annotation 
# information used during normalization
normalizedData <- snprma(featureData)
```

### Accessing Annotation Data

You can interact with the underlying database to retrieve probe information or SNP locations using the `db` slot of the PD object.

```r
# Get the annotation object
pkgname <- "pd.mapping250k.nsp"
conn <- db(get(pkgname))

# List tables in the annotation database
dbListTables(conn)

# Example: Querying SNP information
# dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 10")
```

## Workflow Tips

1. **Memory Management**: The 250K array is large. Ensure sufficient RAM is available when running `snprma`.
2. **Platform Matching**: This package is specific to the **NSP** version of the 250K array. For the STY version, use `pd.mapping250k.sty`.
3. **Annotation Updates**: While the PD package provides static mapping, always check Bioconductor for the latest version to ensure compatibility with current R/oligo versions.

## Reference documentation

- [pd.mapping250k.nsp Reference Manual](./references/reference_manual.md)