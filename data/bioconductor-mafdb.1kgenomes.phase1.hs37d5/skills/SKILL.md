---
name: bioconductor-mafdb.1kgenomes.phase1.hs37d5
description: This package provides minor allele frequency data from the 1000 Genomes Project Phase 1 for the hs37d5 reference genome. Use when user asks to retrieve population-specific allele frequencies, query genetic variants by genomic coordinates, or look up MAF scores using RS identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.1Kgenomes.phase1.hs37d5.html
---


# bioconductor-mafdb.1kgenomes.phase1.hs37d5

name: bioconductor-mafdb.1kgenomes.phase1.hs37d5
description: Annotation package for Minor Allele Frequency (MAF) data from the 1000 Genomes Project Phase 1 (hs37d5/GRCh37). Use this skill to retrieve population-specific allele frequencies for human genetic variants using GScores methods.

# bioconductor-mafdb.1kgenomes.phase1.hs37d5

## Overview

The `MafDb.1Kgenomes.phase1.hs37d5` package provides access to Minor Allele Frequency (MAF) data from Phase 1 of the 1000 Genomes Project, mapped to the `hs37d5` (GRCh37) reference genome. The data is stored as a `GScores` object, which allows for efficient querying of frequencies across different global populations without loading the entire dataset into memory.

## Core Workflow

### 1. Loading the Package and Data
The data object is named identically to the package.

```r
library(MafDb.1Kgenomes.phase1.hs37d5)

# Assign the GScores object to a shorter variable name
mafdb <- MafDb.1Kgenomes.phase1.hs37d5
mafdb
```

### 2. Checking Available Populations
Use the `populations()` function to see which ethnic groups or meta-populations are available for querying.

```r
populations(mafdb)
```

### 3. Querying Allele Frequencies
You can query frequencies using `GRanges` objects or SNP identifiers. This requires the `GenomicScores` package.

**By Genomic Coordinates:**
```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

**By RS Identifier (requires SNPlocs package):**
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for a specific RS ID
rng_rs <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_rs)
```

## Implementation Details

- **Storage Precision:** To optimize memory, MAF values $\ge 0.1$ are stored with two significant digits. Values $< 0.1$ are stored with one significant digit.
- **Reference Genome:** This package is strictly for the **hs37d5** (GRCh37) assembly. Ensure your input coordinates match this version.
- **Object Class:** The data is a `GScores` object. Advanced manipulation methods (like filtering by frequency) are documented in the `GenomicScores` software package.

## Reference documentation

- [MafDb.1Kgenomes.phase1.hs37d5 Reference Manual](./references/reference_manual.md)