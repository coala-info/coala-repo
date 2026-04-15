---
name: bioconductor-bsgenome.cjacchus.ucsc.caljac4
description: This package provides the full genome sequences for the Common Marmoset (Callithrix jacchus) based on the UCSC calJac4 assembly for use in R. Use when user asks to access marmoset reference sequences, retrieve chromosome lengths, extract specific genomic sub-sequences, or perform genome-wide motif searching.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cjacchus.UCSC.calJac4.html
---

# bioconductor-bsgenome.cjacchus.ucsc.caljac4

name: bioconductor-bsgenome.cjacchus.ucsc.caljac4
description: Access and analyze the full genome sequences for Callithrix jacchus (Marmoset) using the UCSC calJac4 assembly. Use this skill when performing genomic analysis in R that requires the marmoset reference genome, including sequence extraction, chromosome length retrieval, and genome-wide motif searching.

# bioconductor-bsgenome.cjacchus.ucsc.caljac4

## Overview

The `BSgenome.Cjacchus.UCSC.calJac4` package is a data provider package containing the full genome sequences for the Common Marmoset (*Callithrix jacchus*) as provided by UCSC (assembly version calJac4, May 2020). It wraps these sequences into a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Loading and Inspecting the Genome

To use the genome, you must first load the package and the object.

```r
library(BSgenome.Cjacchus.UCSC.calJac4)

# Assign to a shorter variable for convenience
genome <- BSgenome.Cjacchus.UCSC.calJac4

# View genome metadata
genome

# List available sequences (chromosomes/scaffolds)
seqnames(genome)

# Get chromosome lengths
seqlengths(genome)
```

## Accessing Sequences

You can retrieve specific chromosome sequences as `DNAString` objects.

```r
# Access a specific chromosome (e.g., Chromosome 1)
chr1_seq <- genome$chr1
# Alternatively:
chr1_seq <- genome[["chr1"]]

# Get a specific sub-sequence (e.g., first 100 bases of chr2)
getSeq(genome, "chr2", start=1, end=100)

# Get sequences for multiple genomic ranges
library(GenomicRanges)
gr <- GRanges(seqnames=c("chr1", "chrX"), 
              ranges=IRanges(start=c(100, 500), end=c(150, 550)))
getSeq(genome, gr)
```

## Genome-wide Motif Searching

Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a specific chromosome
matchPattern(motif, genome$chr1, fixed=FALSE)

# Search across the entire genome
# Note: This returns a GRangesList
matches <- vmatchPattern(motif, genome, fixed=FALSE)
```

## Usage Tips

- **Memory Management**: `BSgenome` objects use "on-disk" caching. Loading the package doesn't load the entire genome into RAM, but accessing a specific chromosome (e.g., `genome$chr1`) will load that entire chromosome into memory.
- **Coordinate System**: UCSC genomes use 1-based indexing in R/Bioconductor, consistent with standard R conventions.
- **Masks**: Check if the genome contains built-in masks (e.g., for repeat regions) by inspecting `masknames(genome)`.

## Reference documentation

- [BSgenome.Cjacchus.UCSC.calJac4 Reference Manual](./references/reference_manual.md)