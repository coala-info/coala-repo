---
name: bioconductor-mafdb.exac.r1.0.nontcga.grch38
description: This package provides minor allele frequency data from the ExAC v1.0 non-TCGA subset lifted over to the GRCh38 assembly. Use when user asks to retrieve population-specific allele frequencies, filter germline variants using non-cancer reference data, or query ExAC scores by genomic coordinates or RS identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.ExAC.r1.0.nonTCGA.GRCh38.html
---

# bioconductor-mafdb.exac.r1.0.nontcga.grch38

## Overview

This package provides a `GScores` object containing Minor Allele Frequency (MAF) data from ExAC v1.0, specifically filtered to exclude TCGA (The Cancer Genome Atlas) samples. This "nonTCGA" subset is often preferred for germline variation filtering in cancer studies to avoid bias. While the original ExAC data was aligned to GRCh37, this package provides the data lifted over to the **GRCh38** assembly.

MAF values are stored with optimized precision:
- MAF >= 0.1: Two significant digits.
- MAF < 0.1: One significant digit.

## Core Workflow

### 1. Loading the Package and Data
The data is exposed as a `GScores` object named after the package.

```r
library(MafDb.ExAC.r1.0.nonTCGA.GRCh38)

# Assign to a shorter variable for convenience
mafdb <- MafDb.ExAC.r1.0.nonTCGA.GRCh38
mafdb
```

### 2. Checking Available Populations
ExAC contains data for several distinct global populations. Use `populations()` to see the available metadata columns.

```r
populations(mafdb)
# Common outputs: AF (Global), AF_AFR (African), AF_AMR (Admixed American), 
# AF_ASJ (Ashkenazi Jewish), AF_EAS (East Asian), AF_FIN (Finnish), 
# AF_NFE (Non-Finnish European), AF_OTH (Other), AF_SAS (South Asian)
```

### 3. Querying Frequencies
You can query frequencies using genomic coordinates (as `GRanges` objects) or by RS identifiers (if used in conjunction with a `SNPlocs` package).

**By Genomic Coordinates:**
Note: Ensure coordinates are for GRCh38.

```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28111713")
gscores(mafdb, rng)
```

**By RS Identifier:**
Requires a corresponding `SNPlocs` package for coordinate lookup.

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for a specific SNP
rng_snp <- snpsById(snpdb, ids="rs1129038")

# Retrieve MAF scores
gscores(mafdb, rng_snp)
```

## Usage Tips
- **Memory Management**: The package loads data into memory only as specific chromosomes or populations are queried. You do not need to worry about the total size of the ExAC dataset.
- **LiftOver Awareness**: Because these data were lifted over from GRCh37 to GRCh38, a very small percentage of variants might have been lost or shifted. Always verify critical variants if discrepancies arise between assembly versions.
- **Non-TCGA Context**: Use this specific version of the ExAC MafDb when your analysis requires a reference population that is strictly "healthy" or at least not confounded by somatic variants present in TCGA.

## Reference documentation

- [MafDb.ExAC.r1.0.nonTCGA.GRCh38 Reference Manual](./references/reference_manual.md)