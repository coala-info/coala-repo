---
name: bioconductor-mafdb.esp6500si.v2.ssa137.grch38
description: This package provides Minor Allele Frequency data from the NHLBI Exome Sequencing Project for the GRCh38 genome build. Use when user asks to query MAF values for human variants, retrieve allele frequencies by genomic coordinates, or check available populations in the ESP6500SI-V2 dataset.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/MafDb.ESP6500SI.V2.SSA137.GRCh38.html
---


# bioconductor-mafdb.esp6500si.v2.ssa137.grch38

name: bioconductor-mafdb.esp6500si.v2.ssa137.grch38
description: Annotation package for Minor Allele Frequency (MAF) data from the NHLBI Exome Sequencing Project (ESP) release ESP6500SI-V2, lifted over to the GRCh38 genome build. Use this skill to query MAF values for human variants using GenomicScores methods.

# bioconductor-mafdb.esp6500si.v2.ssa137.grch38

## Overview

This package provides access to Minor Allele Frequency (MAF) data from 6,503 exomes (ESP6500SI-V2). The data is stored as a `GScores` object. Note that while the data is mapped to GRCh38, the original variants were called on GRCh37 and lifted over; non-SNVs were discarded during this process. MAF values are stored with reduced precision (two significant digits for MAF >= 0.1, one for MAF < 0.1) to optimize memory.

## Core Workflows

### Loading the Database
The package loads a `GScores` object named exactly like the package.

```r
library(MafDb.ESP6500SI.V2.SSA137.GRCh38)
mafdb <- MafDb.ESP6500SI.V2.SSA137.GRCh38
```

### Checking Available Populations
Use the `populations()` function to see which ethnic groups or cohorts are available for querying.

```r
populations(mafdb)
```

### Querying MAF Values
You can query frequencies using `GRanges` objects or specific genomic coordinates.

**By Genomic Coordinates:**
```r
library(GenomicRanges)
# Query a specific position on Chromosome 15
gscores(mafdb, GRanges("15:28111713"))
```

**By RS Identifier (requires SNPlocs):**
To query by RS ID, you must first resolve the coordinate using a corresponding SNPlocs package.
```r
library(SNPlocs.Hsapiens.dbSNP149.GRCh38)
snpdb <- SNPlocs.Hsapiens.dbSNP149.GRCh38
rng <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng)
```

## Usage Tips
- **Memory Management:** The `GScores` object loads data into memory only as specific chromosomes or populations are queried.
- **Coordinate System:** Ensure your input coordinates are based on **GRCh38**. Using GRCh37 coordinates will result in incorrect frequency assignments.
- **SNVs Only:** This specific package only contains SNVs. If you are looking for Indels from the ESP project, they may have been discarded during the liftover process for this specific annotation object.
- **Precision:** Be aware that MAF values are rounded (e.g., a value of 0.000123 might be stored as 0.0001).

## Reference documentation

- [MafDb.ESP6500SI.V2.SSA137.GRCh38 Reference Manual](./references/reference_manual.md)