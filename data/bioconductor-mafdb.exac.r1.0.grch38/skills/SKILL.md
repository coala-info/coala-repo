---
name: bioconductor-mafdb.exac.r1.0.grch38
description: This package provides access to minor allele frequency data from the Exome Aggregation Consortium release 1.0 for the GRCh38 genome build. Use when user asks to annotate human genetic variants with population-specific allele frequencies, query ExAC data by genomic coordinates, or filter variants based on frequency in the GRCh38 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.ExAC.r1.0.GRCh38.html
---


# bioconductor-mafdb.exac.r1.0.grch38

name: bioconductor-mafdb.exac.r1.0.grch38
description: Access and query minor allele frequency (MAF) data from the Exome Aggregation Consortium (ExAC) release 1.0, lifted over to the GRCh38 genome build. Use this skill when you need to annotate human genetic variants with population-specific allele frequencies within R.

# bioconductor-mafdb.exac.r1.0.grch38

## Overview

The `MafDb.ExAC.r1.0.GRCh38` package is a Bioconductor annotation resource providing minor allele frequencies (MAF) from the Exome Aggregation Consortium (ExAC). It exposes data as a `GScores` object, which is managed by the `GenomicScores` infrastructure. This specific version contains data originally from GRCh37 that has been lifted over to the **GRCh38** assembly.

Key characteristics:
- **Data Source**: ExAC release 1.0 (approx. 60,706 humans).
- **Storage**: Optimized for memory; MAF values $\ge 0.1$ use two significant digits, while values $< 0.1$ use one.
- **Object Class**: `GScores`.

## Basic Usage

### Loading the Package and Data
The data object is named identically to the package.

```r
library(MafDb.ExAC.r1.0.GRCh38)

# Assign the GScores object to a shorter variable name
mafdb <- MafDb.ExAC.r1.0.GRCh38
mafdb
```

### Checking Available Populations
ExAC contains data for several global populations. Use `populations()` to see the available headers.

```r
populations(mafdb)
```

### Querying Allele Frequencies
You can query frequencies using genomic coordinates (as `GRanges` objects) or by RS identifiers (if used in conjunction with a `SNPlocs` package).

#### By Genomic Coordinates
```r
library(GenomicRanges)

# Query a specific position on GRCh38
# Example: 15:28111713
rng <- GRanges("chr15:28111713")
gscores(mafdb, rng)
```

#### By RS Identifier
To query by RS ID, you must first resolve the coordinates using a corresponding `SNPlocs` package for GRCh38.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)

snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng_rs <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_rs)
```

## Workflow Integration

1. **Variant Annotation**: Use this package in bioinformatics pipelines to filter common variants (e.g., MAF > 0.01) or to prioritize rare variants in exome sequencing studies.
2. **Lifting Over**: Note that these coordinates are already in GRCh38. If your input data is in GRCh37, ensure you use the corresponding `MafDb.ExAC.r1.0.hs37d5` package or perform a liftover on your ranges first.
3. **Memory Management**: The package loads data into memory only as chromosomes are queried, making it efficient for large-scale annotation.

## Tips
- **Metadata**: Use `citation(mafdb)` to get the correct publication reference for your research.
- **Missing Values**: If a variant is not present in the ExAC database, the returned score will be `NA`.
- **Precision**: Remember that values are rounded to save space (1 or 2 significant digits depending on the frequency magnitude).

## Reference documentation
- [MafDb.ExAC.r1.0.GRCh38 Reference Manual](./references/reference_manual.md)