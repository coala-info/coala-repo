---
name: bioconductor-pd.genomewidesnp.6
description: This package provides the annotation and infrastructure required to process Affymetrix Genome-Wide Human SNP Array 6.0 data. Use when user asks to perform low-level processing, normalization, or genotyping of SNP 6.0 CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.genomewidesnp.6.html
---

# bioconductor-pd.genomewidesnp.6

## Overview
The `pd.genomewidesnp.6` package is a Bioconductor annotation package specifically designed for the Affymetrix Genome-Wide Human SNP Array 6.0. It provides the SQLite-based infrastructure required by the `oligo` package to map probe sequences to their genomic locations and to define the physical layout of the array. This package is essential for low-level processing, including calibration, normalization, and genotyping of SNP 6.0 data.

## Installation
To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pd.genomewidesnp.6")
```

## Typical Workflow
This package is rarely called directly by the user; instead, it is loaded automatically by the `oligo` package when reading CEL files from the SNP 6.0 platform.

### 1. Loading Data
When you read CEL files using `read.celfiles()`, the `oligo` package identifies the platform and attempts to load `pd.genomewidesnp.6`.

```r
library(oligo)
library(pd.genomewidesnp.6)

# Path to your CEL files
celFiles <- list.celfiles(path = "path/to/cels", full.names = TRUE)

# The package is used here to create the FeatureSet object
rawData <- read.celfiles(celFiles)
```

### 2. Genotyping (CRLMM)
The primary use case for this annotation package is performing genotyping using the Corrected Robust Linear Model with Maximum likelihood (CRLMM).

```r
library(crlmm)

# Genotyping the SNP 6.0 data
# This relies on the pd.genomewidesnp.6 infrastructure
genotypes <- crlmm(celFiles)
```

### 3. Accessing Annotation Database
You can inspect the underlying SQLite database to see probe-to-SNP mappings.

```r
# Get the connection to the annotation database
conn <- db(pd.genomewidesnp.6)

# List tables (e.g., snp_probes, featureSet)
dbListTables(conn)

# Example: Querying the first few rows of the featureSet table
dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 5")
```

## Tips
- **Memory Management**: SNP 6.0 arrays are high-density (1.8 million markers). Ensure your R session has sufficient RAM, or use the `ff` package integration provided by `oligo` to handle data on disk.
- **Package Dependency**: If `read.celfiles` throws an error regarding "pd.genomewidesnp.6 not found," ensure the package is explicitly installed, as it is a large data package not included with the base `oligo` installation.
- **Platform Verification**: This package is strictly for the "GenomeWideSNP_6" chip. Do not use it for SNP 5.0 or other Affymetrix platforms.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)