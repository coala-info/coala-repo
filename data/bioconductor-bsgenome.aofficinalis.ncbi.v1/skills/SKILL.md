---
name: bioconductor-bsgenome.aofficinalis.ncbi.v1
description: This package provides the full genome sequences for Asparagus officinalis (Garden asparagus) as Biostrings objects based on the NCBI Aspof.V1 assembly. Use when user asks to access the garden asparagus genome, extract specific sequence regions, search for motifs, or calculate nucleotide frequencies within the Bioconductor environment.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Aofficinalis.NCBI.V1.html
---


# bioconductor-bsgenome.aofficinalis.ncbi.v1

name: bioconductor-bsgenome.aofficinalis.ncbi.v1
description: Provides the full genome sequences for Asparagus officinalis (Garden asparagus) as provided by NCBI (assembly Aspof.V1, Feb. 2017) and stored in Biostrings objects. Use this skill when you need to access, analyze, or perform sequence operations on the garden asparagus genome within the R Bioconductor environment.

# bioconductor-bsgenome.aofficinalis.ncbi.v1

## Overview

The `BSgenome.Aofficinalis.NCBI.V1` package is a data provider package containing the complete genome sequence for *Asparagus officinalis*. It is built upon the `BSgenome` infrastructure, allowing for efficient sequence container management and integration with other Bioconductor tools like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

Key features:
- Organism: *Asparagus officinalis* (Garden asparagus)
- Assembly: Aspof.V1 (NCBI GCF_001876935.1)
- Release Date: February 2017
- Storage: Sequences are stored as `DNAString` objects.

## Basic Usage

### Loading the Genome

To use the genome, you must first load the package library.

```r
library(BSgenome.Aofficinalis.NCBI.V1)

# Assign to a shorter variable for convenience
genome <- BSgenome.Aofficinalis.NCBI.V1
```

### Exploring Genome Metadata

You can inspect the sequence names, lengths, and other metadata using standard `BSgenome` methods.

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# View specific chromosome information
genome$NW_017594314.1  # Access by name
```

### Sequence Extraction

Extract specific regions of the genome using `getSeq`.

```r
# Extract a specific range
library(GenomicRanges)
rng <- GRanges("NW_017594314.1", IRanges(start=100, end=200))
seq_segment <- getSeq(genome, rng)
```

## Common Workflows

### Genome-Wide Motif Searching

Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the entire asparagus genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAA"

# Search on a specific scaffold
matchPattern(motif, genome$NW_017594314.1)

# Search across the entire genome
# Note: This returns a GRangesList
all_matches <- vmatchPattern(motif, genome)
```

### Calculating Nucleotide Frequency

Analyze the composition of the genome or specific sequences.

```r
# Frequency for one scaffold
alphabetFrequency(genome$NW_017594314.1, baseOnly=TRUE)

# GC content calculation
letterFrequency(genome$NW_017594314.1, letters="GC", as.prob=TRUE)
```

## Tips and Best Practices

- **Memory Management**: BSgenome objects use "on-disk" loading (via `mmap`), so they are memory efficient. However, extracting very large sequences into memory as `DNAString` objects can still consume significant RAM.
- **Sequence Naming**: This package uses NCBI accessions (e.g., "NW_...") as sequence names. Ensure your `GRanges` objects use matching identifiers.
- **Coordinate System**: Like all Bioconductor sequence objects, this package uses a 1-based coordinate system.

## Reference documentation

- [BSgenome.Aofficinalis.NCBI.V1 Reference Manual](./references/reference_manual.md)