---
name: bioconductor-mafdb.gnomad.r2.0.1.grch38
description: This package provides access to minor allele frequency data from gnomAD release 2.0.1 lifted over to the GRCh38 genome build. Use when user asks to retrieve population-specific allele frequencies, query genomic variants by coordinates or RS identifiers, and annotate or filter variants based on rarity within the R/Bioconductor environment.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.gnomAD.r2.0.1.GRCh38.html
---


# bioconductor-mafdb.gnomad.r2.0.1.grch38

name: bioconductor-mafdb.gnomad.r2.0.1.grch38
description: Access and query minor allele frequency (MAF) data from the Genome Aggregation Database (gnomAD) release 2.0.1, specifically lifted over to the GRCh38 genome build. Use this skill to retrieve population-specific allele frequencies for genomic variants, annotate VCF files, or filter variants based on rarity within the R/Bioconductor environment.

# bioconductor-mafdb.gnomad.r2.0.1.grch38

## Overview

The `MafDb.gnomAD.r2.0.1.GRCh38` package is a specialized annotation container for minor allele frequency (MAF) data. It exposes gnomAD v2.0.1 data as a `GScores` object. While the original gnomAD v2.0.1 data was based on GRCh37, this package provides the data lifted over to the **GRCh38** assembly.

To save space, MAF values $\ge 0.1$ are stored with two significant digits, and values $< 0.1$ are stored with one significant digit.

## Basic Workflow

### 1. Load the Package and Data Object
The data is accessed via a `GScores` object named identically to the package.

```r
library(MafDb.gnomAD.r2.0.1.GRCh38)

# Assign the GScores object to a shorter variable
mafdb <- MafDb.gnomAD.r2.0.1.GRCh38
mafdb
```

### 2. Identify Available Populations
Use the `populations()` function to see which ethnic groups or cohorts are available for querying.

```r
populations(mafdb)
```

### 3. Query Frequencies by Genomic Coordinates
Use the `gscores()` function from the `GenomicScores` package. You must provide a `GRanges` object.

```r
library(GenomicRanges)

# Query a specific position on GRCh38
rng <- GRanges("chr15:28111713")
gscores(mafdb, rng)
```

### 4. Query Frequencies by RS Identifier
To query by RS ID, you typically need a SNP location package (like `SNPlocs.Hsapiens.dbSNP149.GRCh38`) to translate the ID into coordinates first.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for a specific SNP
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF
gscores(mafdb, rng_snp)
```

## Tips and Best Practices

*   **Memory Management**: The package loads data into memory only as specific chromosomes or populations are queried. It is efficient for both single-site lookups and bulk annotation.
*   **Genome Build**: Ensure your input `GRanges` or VCF data is strictly on the **GRCh38** assembly. Using GRCh37 coordinates will result in incorrect or missing data.
*   **Column Selection**: By default, `gscores()` returns the default MAF. You can specify specific populations using the `pop` argument in the `gscores()` function.
*   **Non-variant Sites**: If a position is not present in the gnomAD dataset, the returned score will be `NA`.

## Reference documentation

- [MafDb.gnomAD.r2.0.1.GRCh38 Reference Manual](./references/reference_manual.md)