---
name: bioconductor-pd.genomewidesnp.5
description: This package provides annotation data and platform design information for the Affymetrix Genome-Wide Human SNP Array 5.0. Use when user asks to process, normalize, or analyze SNP 5.0 microarrays using the oligo or crlmm packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.genomewidesnp.5.html
---

# bioconductor-pd.genomewidesnp.5

name: bioconductor-pd.genomewidesnp.5
description: Annotation data package for the Affymetrix Genome-Wide Human SNP Array 5.0. Use this skill when processing, normalizing, or analyzing SNP 5.0 microarrays using the oligo or crlmm packages in R. It provides the necessary platform design information for feature-level preprocessing.

# bioconductor-pd.genomewidesnp.5

## Overview

The `pd.genomewidesnp.5` package is a specialized annotation resource for the Affymetrix Genome-Wide Human SNP Array 5.0. It is built using the `pdInfoBuilder` framework and is designed to work seamlessly with the `oligo` package to handle the complex layout of SNP and copy number probes on this specific platform.

This package acts as a "Platform Design" (PD) package, providing the SQLite database that maps probes to their physical locations, sequences, and target fragments.

## Usage Guidance

### Loading the Package

The package is typically loaded automatically when using functions from the `oligo` package on CEL files from the SNP 5.0 array. However, you can load it manually to verify the installation:

```r
library(pd.genomewidesnp.5)
```

### Typical Workflow with oligo

The primary use case is during the initial data import and normalization of Affymetrix CEL files.

```r
library(oligo)

# 1. List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# 2. Read intensity data
# The oligo package will automatically detect and load pd.genomewidesnp.5
raw_data <- read.celfiles(celFiles)

# 3. Preprocessing (e.g., RMA or SNPRMA)
# This step uses the annotation data to group probes correctly
normalized_data <- snprma(raw_data)
```

### Accessing Platform Metadata

You can inspect the platform information contained within the object:

```r
# Check the annotation slot of an ExpressionFeatureSet or SnpFeatureSet
annotation(raw_data)

# Get information about the database connection
db <- getPdDb(pd.genomewidesnp.5)
dbListTables(db)
```

## Tips for SNP 5.0 Analysis

- **Memory Management**: SNP 5.0 arrays are high-density. Ensure your R session has sufficient RAM, or use the `ff` package integration provided by `oligo` for large datasets.
- **Package Dependency**: This package is a data provider. It does not contain analysis functions itself; it provides the infrastructure for `oligo`, `crlmm`, and `hapmapsnp5`.
- **Genotype Calling**: For genotype calling, this package is required by the `crlmm` package to provide the probe-set mappings and fragment length information necessary for the CRLMM algorithm.

## Reference documentation

- [pd.genomewidesnp.5 Reference Manual](./references/reference_manual.md)