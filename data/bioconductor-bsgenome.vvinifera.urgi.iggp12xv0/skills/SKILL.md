---
name: bioconductor-bsgenome.vvinifera.urgi.iggp12xv0
description: This package provides the full reference nuclear genome sequences for Vitis vinifera (grapevine) PN40024 assembly IGGP 12Xv0. Use when user asks to access grapevine chromosome sequences, extract genomic subsequences, calculate nucleotide frequencies, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Vvinifera.URGI.IGGP12Xv0.html
---


# bioconductor-bsgenome.vvinifera.urgi.iggp12xv0

name: bioconductor-bsgenome.vvinifera.urgi.iggp12xv0
description: Provides the full reference nuclear genome sequences for Vitis vinifera (grapevine) PN40024 (IGGP version 12Xv0). Use this skill when you need to access, analyze, or manipulate the grapevine genome in R, including retrieving chromosome sequences, calculating sequence statistics, or performing genome-wide motif searching.

# bioconductor-bsgenome.vvinifera.urgi.iggp12xv0

## Overview

The `BSgenome.Vvinifera.URGI.IGGP12Xv0` package is a data provider for the *Vitis vinifera* subsp. *vinifera* PN40024 genome assembly (IGGP 12Xv0). It stores the genome as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `BSgenome`.

## Basic Usage

### Loading the Genome
To use the genome, load the package and assign the genome object to a variable.

```r
library(BSgenome.Vvinifera.URGI.IGGP12Xv0)
genome <- BSgenome.Vvinifera.URGI.IGGP12Xv0
```

### Exploring Genome Metadata
Check the available chromosomes (sequences) and their lengths.

```r
# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Retrieving Sequences
Access specific chromosomes using standard list or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Alternative access method
chr1_seq <- genome[["chr1"]]

# View sequence details (returns a DNAString object)
chr1_seq
```

## Common Workflows

### Extracting Subsequences
Use `getSeq` to extract specific genomic regions.

```r
# Extract a specific range from chromosome 2
# Coordinates are 1-based
sub_seq <- getSeq(genome, "chr2", start=1000, end=2000)
```

### Genome-wide Motif Searching
Search for specific DNA patterns across the entire grapevine genome.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Match the motif on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Count occurrences across the whole genome
vcountPattern(motif, genome)
```

### Calculating Nucleotide Frequency
Analyze the composition of the genome or specific chromosomes.

```r
# Frequency for chromosome 1
alphabetFrequency(genome$chr1, baseOnly=TRUE)

# GC content for chromosome 1
letterFrequency(genome$chr1, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading. Accessing `genome$chr1` loads that specific chromosome into memory.
- **Coordinate System**: Like most Bioconductor packages, this genome uses a 1-based coordinate system.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`. You can pass the `genome` object directly to functions requiring a `BSgenome` or `Seqinfo` object.

## Reference documentation

- [BSgenome.Vvinifera.URGI.IGGP12Xv0 Reference Manual](./references/reference_manual.md)