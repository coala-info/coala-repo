---
name: bioconductor-ceu1kgv
description: This tool provides integrated 1000 Genomes genotype calls and expression data for CEU HapMap lines in a unified container. Use when user asks to access the ceu1kgv dataset, perform expression quantitative trait loci (eQTL) analysis, or conduct integrative genomic studies using CEU population data.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/ceu1kgv.html
---

# bioconductor-ceu1kgv

name: bioconductor-ceu1kgv
description: Access and analyze the ceu1kgv dataset, which provides integrated 1000 Genomes genotype calls and expression data for CEU HapMap lines. Use this skill when a user needs to perform expression quantitative trait loci (eQTL) analysis or integrative genomic studies using the CEU population data in R.

# bioconductor-ceu1kgv

## Overview

The `ceu1kgv` package is a Bioconductor data experiment package that provides a unified container for expression data and genotype calls for the CEU (Utah residents with Northern and Western European ancestry) HapMap lines. It specifically integrates ArrayExpress expression data (E-MTAB-198) with 1000 Genomes Project Phase 1 genotype calls. The data is structured to work seamlessly with the `GGBase` and `snpStats` frameworks for efficient genomic analysis.

## Loading and Accessing Data

The primary way to interact with this package is through the `GGBase` function `getSS`, which retrieves a "smlSet" (SNP-matrix-linked expression set) object.

```R
library(GGBase)
library(ceu1kgv)

# Load integrated data for a specific chromosome (e.g., chromosome 22)
c22 <- getSS("ceu1kgv", "chr22")

# Inspect the object
print(c22)
```

The resulting object contains:
- **Genotype data**: Stored as a `SnpMatrix` from the `snpStats` package.
- **Expression data**: A matrix of normalized expression values (mapped to nuIDs).
- **Phenotype data**: Metadata for the 79 samples included in the integrated set.

## Typical Workflow

### 1. Data Exploration
Once the data is loaded, you can examine the dimensions and metadata to understand the scope of the SNPs and probes available.

```R
# Check number of SNPs and Probes
dim(exprs(c22)) # Expression matrix dims
nsnps(c22)      # Total number of SNPs
```

### 2. Integrative Analysis
The package is designed for use with `GGBase` tools to perform eQTL mapping. Because the genotypes are stored in `SnpMatrix` format, they are optimized for high-throughput association testing.

```R
# Example: Accessing genotype information
# Note: Usually handled via GGBase high-level functions
genotypes <- smlEnv(c22)$chr22
```

## Technical Notes

- **Genome Build**: The genotype data is typically aligned to the `hg19` (GRCh37) genome build.
- **Expression Mapping**: Probe IDs are converted to nuIDs using the `lumiHumanIDMapping` package.
- **Sample Size**: The integrated container typically focuses on a subset of samples (e.g., 79 samples) where both high-quality genotype and expression data overlap.
- **Dependencies**: This package relies heavily on `GGBase`, `snpStats`, and `Biobase`. Ensure these are loaded to manipulate the `smlSet` objects effectively.

## Reference documentation

- [Building ceu1kgv](./references/ceu1kgv.md)