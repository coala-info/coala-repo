---
name: bioconductor-mafdb.topmed.freeze5.hg38
description: This package provides minor allele frequency data from the NHLBI TOPMed consortium freeze 5 for the hg38 genome build. Use when user asks to retrieve population-specific allele frequencies, annotate human genetic variants with TOPMed data, or query genomic scores by coordinates or RS ID.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.TOPMed.freeze5.hg38.html
---

# bioconductor-mafdb.topmed.freeze5.hg38

name: bioconductor-mafdb.topmed.freeze5.hg38
description: Annotation package for minor allele frequency (MAF) data from the NHLBI TOPMed consortium (freeze 5) for the hg38 genome build. Use this skill when you need to retrieve or annotate human genetic variants with population-specific allele frequencies derived from the Trans-Omics for Precision Medicine (TOPMed) project.

# bioconductor-mafdb.topmed.freeze5.hg38

## Overview

The `MafDb.TOPMed.freeze5.hg38` package is a specialized Bioconductor annotation resource. It stores Minor Allele Frequency (MAF) data from the NHLBI TOPMed consortium (Freeze 5) mapped to the hg38 (GRCh38) reference genome. The data is exposed as a `GScores` object, which allows for efficient, on-demand querying of frequencies across chromosomes without loading the entire dataset into memory.

Key characteristics:
- **Data Source**: NHLBI TOPMed Freeze 5 (approx. 60,000 whole genomes).
- **Genome Build**: hg38 / GRCh38.
- **Storage**: MAF values $\ge$ 0.1 are stored with two significant digits; values < 0.1 use one significant digit to optimize space.
- **Interface**: Uses the `GenomicScores` framework.

## Installation

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("MafDb.TOPMed.freeze5.hg38")
```

## Basic Usage

### Loading the Package and Object
The package automatically creates a `GScores` object named after the package.

```r
library(MafDb.TOPMed.freeze5.hg38)

# Assign to a shorter variable for convenience
mafdb <- MafDb.TOPMed.freeze5.hg38
mafdb
```

### Checking Available Populations
TOPMed data in this package typically represents a global frequency, but you can verify the available metadata:

```r
populations(mafdb)
```

### Querying Frequencies by Genomic Coordinates
You can query frequencies using `GRanges` objects. Ensure the `seqlevelsStyle` matches (TOPMed usually uses "UCSC" style, e.g., "chr1").

```r
library(GenomicRanges)

# Query a specific position on chromosome 15
rng <- GRanges("chr15:28111713")
gscores(mafdb, rng)
```

### Querying Frequencies by RS ID
To query by RS ID, you must first resolve the coordinates using a SNP location package (like `SNPlocs.Hsapiens.dbSNP155.GRCh38`).

```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38

# Get coordinates for a specific SNP
rng <- snpsById(snpdb, ids="rs1129038")

# Match sequence styles (e.g., from NCBI to UCSC)
seqlevelsStyle(rng) <- seqlevelsStyle(mafdb)

# Retrieve MAF
gscores(mafdb, rng)
```

## Workflow Integration

### Annotating a VCF or Variant Table
When working with a list of variants, use `gscores()` to append frequency data to your existing `GRanges` object.

```r
# Assume 'my_variants' is a GRanges object
annotated_variants <- gscores(mafdb, my_variants)

# The MAF values are stored in the metadata columns (mcols)
head(mcols(annotated_variants))
```

## Tips and Best Practices
- **Memory Efficiency**: The package uses lazy loading. It only reads data from disk when a specific chromosome is queried.
- **Coordinate Matching**: Always verify that your input `GRanges` uses the `hg38` build and that the `seqlevelsStyle` (e.g., "chr1" vs "1") matches the `mafdb` object. Use `seqlevelsStyle(rng) <- seqlevelsStyle(mafdb)` to be safe.
- **Significant Digits**: Remember that very rare variants (MAF < 0.1) are rounded to one significant digit. This is a design choice to reduce the package footprint.

## Reference documentation
- [MafDb.TOPMed.freeze5.hg38 Reference Manual](./references/reference_manual.md)