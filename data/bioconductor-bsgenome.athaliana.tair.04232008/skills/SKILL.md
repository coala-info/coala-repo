---
name: bioconductor-bsgenome.athaliana.tair.04232008
description: This package provides the full genome sequences for Arabidopsis thaliana based on the 2008 TAIR snapshot as a BSgenome object for R. Use when user asks to access Arabidopsis genome sequences, extract specific subsequences, search for motifs, or calculate nucleotide frequencies for the TAIR 04-23-2008 version.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Athaliana.TAIR.04232008.html
---


# bioconductor-bsgenome.athaliana.tair.04232008

name: bioconductor-bsgenome.athaliana.tair.04232008
description: Access and analyze the full genome sequences for Arabidopsis thaliana (TAIR version from April 23, 2008). Use this skill when you need to perform genomic analysis, motif searching, or sequence extraction specifically for the 2008 TAIR snapshot of the Arabidopsis genome within an R environment.

# bioconductor-bsgenome.athaliana.tair.04232008

## Overview

This package provides a `BSgenome` data object containing the complete genome sequences for *Arabidopsis thaliana* based on the TAIR snapshot from April 23, 2008. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and genome-wide calculations.

## Installation and Loading

To use this genome data, ensure the package is installed and loaded in your R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Athaliana.TAIR.04232008")
library(BSgenome.Athaliana.TAIR.04232008)
```

## Basic Usage

### Accessing Genome Metadata
Once loaded, the genome object is available under the name `BSgenome.Athaliana.TAIR.04232008`.

```r
# Assign to a shorter variable for convenience
genome <- BSgenome.Athaliana.TAIR.04232008

# View sequence names (chromosomes)
seqnames(genome)

# View chromosome lengths
seqlengths(genome)
```

### Extracting Sequences
You can access individual chromosomes using the `$` or `[[` operators. The returned object is a `DNAString`.

```r
# Access Chromosome 1
chr1_seq <- genome$chr1

# Access via index or string
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 100 bases of chr3)
sub_seq <- getSeq(genome, "chr3", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Because this package integrates with the `Biostrings` and `BSgenome` infrastructure, you can search for specific patterns across the entire genome.

```r
library(Biostrings)

# Define a pattern
pattern <- DNAString("ATGCMG")

# Match pattern on a specific chromosome
matches <- matchPattern(pattern, genome$chr1)

# Count occurrences across all chromosomes
vcountPattern(pattern, genome)
```

### Calculating Nucleotide Frequency
Analyze the composition of the genome or specific regions.

```r
# Frequency for Chromosome 1
alphabetFrequency(genome$chr1, baseOnly=TRUE)

# GC content for a specific range
letterFrequency(sub_seq, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: `BSgenome` objects use "lazy loading." Sequences are only loaded into memory when specifically accessed (e.g., by calling `genome$chr1`).
- **Coordinate System**: This package uses the TAIR 04-23-2008 snapshot. Ensure your annotation data (GFF, BED files) matches this specific version to avoid coordinate shifts.
- **Compatibility**: Use this package in conjunction with `GenomicRanges` for interval-based analysis.

## Reference documentation

- [BSgenome.Athaliana.TAIR.04232008 Reference Manual](./references/reference_manual.md)