---
name: bioconductor-mafdb.1kgenomes.phase3.hs37d5
description: This package provides minor allele frequency data from the 1000 Genomes Project Phase 3 for the hs37d5 reference genome. Use when user asks to query population-specific allele frequencies, annotate genetic variants with MAF scores, or retrieve metadata about 1000 Genomes populations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.1Kgenomes.phase3.hs37d5.html
---

# bioconductor-mafdb.1kgenomes.phase3.hs37d5

name: bioconductor-mafdb.1kgenomes.phase3.hs37d5
description: Annotation package for Minor Allele Frequency (MAF) data from the 1000 Genomes Project Phase 3 (hs37d5/GRCh37). Use this skill to query population-specific allele frequencies for genetic variants, annotate GRanges objects with MAF scores, and retrieve metadata about the 1000 Genomes Phase 3 populations.

# bioconductor-mafdb.1kgenomes.phase3.hs37d5

## Overview

The `MafDb.1Kgenomes.phase3.hs37d5` package is a Bioconductor annotation resource providing Minor Allele Frequency (MAF) data from Phase 3 of the 1000 Genomes Project. The data is mapped to the `hs37d5` reference genome (a decoy-augmented version of GRCh37/hg19). 

The package exposes a `GScores` object (from the `GenomicScores` framework) that allows for efficient, memory-mapped querying of allele frequencies across different global populations.

## Core Workflow

### 1. Loading the Package and Data
The package loads a central `GScores` object named exactly like the package.

```r
library(MafDb.1Kgenomes.phase3.hs37d5)

# Assign to a shorter variable for convenience
mafdb <- MafDb.1Kgenomes.phase3.hs37d5
mafdb
```

### 2. Inspecting Populations
To see which 1000 Genomes populations (e.g., AF, EUR, AFR, AMR, EAS, SAS) are available for querying:

```r
populations(mafdb)
```

### 3. Querying MAF Values
Use the `gscores()` function to retrieve frequencies. You can query by `GRanges` objects or by SNP identifiers (if combined with a `SNPlocs` package).

**Query by Genomic Coordinates:**
```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

**Query by rsID (requires SNPlocs):**
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37

# Get coordinates for a specific rsID
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF
gscores(mafdb, rng_snp)
```

## Usage Tips
- **Coordinate System:** Ensure your input `GRanges` use the `hs37d5` or `GRCh37` naming convention (e.g., "1", "2", ... "X" rather than "chr1").
- **Storage Precision:** To save space, MAF values $\ge 0.1$ are stored with two significant digits, while values $< 0.1$ are stored with one significant digit.
- **Memory Efficiency:** The package uses lazy loading via the `GenomicScores` infrastructure; data for specific chromosomes is only loaded into memory when queried.
- **Metadata:** Use `citation(mafdb)` to get the correct publication reference for the 1000 Genomes Phase 3 data.

## Reference documentation
- [MafDb.1Kgenomes.phase3.hs37d5 Reference Manual](./references/reference_manual.md)