---
name: bioconductor-bsgenome.mdomestica.ucsc.mondom5
description: This package provides the full genome sequence for the Monodelphis domestica (gray short-tailed opossum) based on the UCSC monDom5 assembly. Use when user asks to access opossum genomic sequences, extract specific chromosome sub-sequences, or perform genome-wide motif searching and sequence analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mdomestica.UCSC.monDom5.html
---

# bioconductor-bsgenome.mdomestica.ucsc.mondom5

## Overview

This package provides a structured `BSgenome` data object containing the complete genome sequences for *Monodelphis domestica* (Gray short-tailed opossum). The data is based on the UCSC monDom5 assembly (October 2006). It is designed to work seamlessly with the `BSgenome` and `Biostrings` infrastructure in Bioconductor for efficient sequence manipulation.

## Loading the Genome

To use the genome in an R session, load the library and assign the provider object to a variable for easier access:

```r
library(BSgenome.Mdomestica.UCSC.monDom5)

# Assign to a shorter variable name
genome <- BSgenome.Mdomestica.UCSC.monDom5
genome
```

## Basic Sequence Operations

### Inspecting Metadata
Check chromosome names and lengths:

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Extracting Sequences
Access specific chromosomes as `DNAString` objects:

```r
# Access via $ operator
chr1_seq <- genome$chr1

# Access via [[ operator (useful for programmatic access)
chrX_seq <- genome[["chrX"]]

# Get a specific sub-sequence (e.g., first 100 bases of chr1)
sub_seq <- getSeq(genome, "chr1", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
To find occurrences of a specific DNA pattern across the entire genome:

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome using vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges
If you have coordinates in a `GRanges` object, you can extract the underlying sequences directly:

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("chr1", "chr2"),
              ranges = IRanges(start = c(1000, 5000), end = c(1100, 5100)))

# Extract sequences for these ranges
sequences <- getSeq(genome, gr)
```

## Usage Tips
- **Memory Management**: `BSgenome` objects use "on-disk" loading. Sequences are only loaded into memory when specifically accessed (e.g., by calling `genome$chr1`).
- **Coordinate System**: This package uses the UCSC naming convention (e.g., "chr1", "chrM"). Ensure your input data matches this naming scheme or use `seqlevelsStyle(x) <- "UCSC"` to convert.
- **Masks**: Check if the genome contains built-in masks (for assembly gaps or repeats) by inspecting `masknames(genome)`.

## Reference documentation

- [BSgenome.Mdomestica.UCSC.monDom5](./references/reference_manual.md)