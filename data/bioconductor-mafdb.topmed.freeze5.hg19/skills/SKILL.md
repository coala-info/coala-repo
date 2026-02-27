---
name: bioconductor-mafdb.topmed.freeze5.hg19
description: This package provides access to Minor Allele Frequency data from the NHLBI TOPMed consortium freeze 5 for the hg19 human genome assembly. Use when user asks to annotate genetic variants with population frequencies, query TOPMed allele frequency data by genomic coordinates, or retrieve genomic scores for variants in the GRCh37 coordinate system.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.TOPMed.freeze5.hg19.html
---


# bioconductor-mafdb.topmed.freeze5.hg19

name: bioconductor-mafdb.topmed.freeze5.hg19
description: Access and query Minor Allele Frequency (MAF) data from the NHLBI TOPMed consortium (freeze5) for the hg19/GRCh37 human genome assembly. Use this skill when you need to annotate genetic variants with population frequency data derived from the Trans-Omics for Precision Medicine (TOPMed) project.

## Overview

The `MafDb.TOPMed.freeze5.hg19` package is a Bioconductor annotation resource providing MAF data from the NHLBI TOPMed consortium (freeze5). The data is stored as a `GScores` object. While the original TOPMed freeze5 data was based on hg38, this package provides the data lifted over to the hg19 (GRCh37) coordinate system.

To save space, MAF values $\ge 0.1$ are stored with two significant digits, and values $< 0.1$ are stored with one significant digit.

## Core Workflow

### 1. Loading the Package and Data
The data object is named identically to the package.

```r
library(MafDb.TOPMed.freeze5.hg19)
mafdb <- MafDb.TOPMed.freeze5.hg19
mafdb
```

### 2. Checking Available Populations
Use the `populations()` function to see the available frequency columns (typically "AF" for the global TOPMed frequency).

```r
populations(mafdb)
```

### 3. Querying Frequencies
Frequencies are retrieved using the `gscores()` function from the `GenomicScores` package. You can query by `GRanges` objects or specific genomic coordinates.

**Query by GRanges:**
```r
library(GenomicRanges)
# Query a specific position on chromosome 15
rng <- GRanges("15:28356859")
gscores(mafdb, rng)
```

**Query by rsID (requires SNPlocs package):**
```r
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37
rng <- snpsById(snpdb, ids="rs1129038")

# Ensure chromosome naming styles match (e.g., "15" vs "chr15")
seqlevelsStyle(rng) <- seqlevelsStyle(mafdb)

gscores(mafdb, rng)
```

## Usage Tips

- **Coordinate System:** This package is specifically for **hg19/GRCh37**. If your data is in hg38, use the `MafDb.TOPMed.freeze5.hg38` package instead.
- **Memory Management:** The `GScores` object uses lazy loading. It only loads data into memory for the specific chromosomes being queried, making it efficient for genome-wide scans.
- **Metadata:** Use `citation(mafdb)` to get the correct attribution for the TOPMed data and `organism(mafdb)` to confirm the species.
- **Missing Values:** If a variant is not present in the TOPMed freeze5 dataset, `gscores()` will return `NA`.

## Reference documentation

- [MafDb.TOPMed.freeze5.hg19 Reference Manual](./references/reference_manual.md)