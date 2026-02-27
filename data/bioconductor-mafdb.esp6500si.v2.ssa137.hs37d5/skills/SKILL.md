---
name: bioconductor-mafdb.esp6500si.v2.ssa137.hs37d5
description: This package provides access to Minor Allele Frequency data from the NHLBI Exome Sequencing Project for the hs37d5 genome build. Use when user asks to retrieve population-specific allele frequencies, query genomic variants by coordinates, or access ESP6500SI-V2 MAF scores.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.ESP6500SI.V2.SSA137.hs37d5.html
---


# bioconductor-mafdb.esp6500si.v2.ssa137.hs37d5

name: bioconductor-mafdb.esp6500si.v2.ssa137.hs37d5
description: Access and query Minor Allele Frequency (MAF) data from the NHLBI Exome Sequencing Project (ESP) release ESP6500SI-V2 for the hs37d5 (GRCh37) genome build. Use this skill to retrieve population-specific allele frequencies for genomic variants using GenomicScores methods.

# bioconductor-mafdb.esp6500si.v2.ssa137.hs37d5

## Overview

This package provides an annotation database for Minor Allele Frequency (MAF) data from the NHLBI Exome Sequencing Project (ESP), specifically the ESP6500SI-V2 release. The data consists of MAF values from 6,503 exomes. The data is exposed as a `GScores` object, which is managed by the `GenomicScores` framework. This specific version is mapped to the `hs37d5` (GRCh37) reference genome.

To save space, MAF values $\ge 0.1$ are stored with two significant digits, while values $< 0.1$ use one significant digit.

## Basic Usage

### Loading the Package and Data

The package automatically creates a `GScores` object named after the package.

```r
library(MafDb.ESP6500SI.V2.SSA137.hs37d5)

# Assign to a shorter variable name for convenience
mafdb <- MafDb.ESP6500SI.V2.SSA137.hs37d5
mafdb
```

### Checking Available Populations

Use the `populations()` function to see which ethnic groups or cohorts are available in the dataset.

```r
populations(mafdb)
```

## Querying Allele Frequencies

Queries are performed using the `gscores()` function. You can provide genomic coordinates as a `GRanges` object.

### Query by Genomic Coordinates

```r
library(GenomicRanges)

# Query a specific position on Chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

### Query by RS Identifier

To query by RS ID, you typically need a `SNPlocs` package corresponding to the genome build (GRCh37) to resolve the coordinates first.

```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for a specific SNP
rng <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng)
```

## Workflow Tips

1.  **Memory Management**: The `GScores` object loads data into memory only for the chromosomes being queried. However, for large-scale queries, ensure you have sufficient RAM.
2.  **Genome Build Consistency**: This package is strictly for `hs37d5` (GRCh37). If your data is in GRCh38, you must either liftover your coordinates or use the corresponding GRCh38 MafDb package.
3.  **Missing Values**: If `gscores()` returns `NA` for a position, it means the variant was not found in the ESP6500SI-V2 dataset.

## Reference documentation

- [MafDb.ESP6500SI.V2.SSA137.hs37d5 Reference Manual](./references/reference_manual.md)