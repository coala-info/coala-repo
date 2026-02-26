---
name: bioconductor-bsgenome.mfuro.ucsc.musfur1
description: This package provides the full genome sequences for the domestic ferret as a Biostrings object based on the UCSC musFur1 build. Use when user asks to access ferret genome sequences, extract DNA from specific genomic coordinates, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mfuro.UCSC.musFur1.html
---


# bioconductor-bsgenome.mfuro.ucsc.musfur1

name: bioconductor-bsgenome.mfuro.ucsc.musfur1
description: Provides the full genome sequences for Mustela putorius furo (Ferret) as provided by UCSC (build musFur1, April 2011) and stored in Biostrings objects. Use this skill when you need to access, analyze, or perform sequence operations on the ferret genome in R, including motif searching, sequence extraction, and genomic coordinate lookups.

# bioconductor-bsgenome.mfuro.ucsc.musfur1

## Overview

The `BSgenome.Mfuro.UCSC.musFur1` package is a data-driven Bioconductor annotation package containing the complete genome sequence for the domestic ferret (*Mustela putorius furo*). It provides a `BSgenome` object that allows for efficient sequence retrieval and integration with other Bioconductor workflows (like `GenomicRanges` and `Biostrings`).

## Loading and Basic Usage

To use the genome data, load the library and assign the genome object to a variable for easier access:

```r
library(BSgenome.Mfuro.UCSC.musFur1)

# Assign to a shorter variable name
genome <- BSgenome.Mfuro.UCSC.musFur1

# View genome metadata
genome

# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)
```

## Accessing Sequences

You can retrieve specific sequences using standard list or dollar-sign notation. Note that for musFur1, many sequences are scaffolds (e.g., starting with "GL").

```r
# Access a specific scaffold by name
scaffold_seq <- genome$GL896898

# Access via index
scaffold_seq <- genome[[1]]

# Extract a specific sub-sequence (e.g., first 100 bases of a scaffold)
getSeq(genome, "GL896898", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific DNA motifs across the ferret genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search a specific scaffold
matches <- matchPattern(motif, genome$GL896898)

# Search the entire genome (returns a GRangesList)
all_matches <- vmatchPattern(motif, genome)
```

### Sequence Extraction from Genomic Ranges
If you have a set of coordinates (e.g., from a BED file or a `GRanges` object), use `getSeq` to extract the underlying DNA.

```r
library(GenomicRanges)

# Define regions of interest
regions <- GRanges(seqnames = c("GL896898", "GL896899"),
                   ranges = IRanges(start = c(100, 500), end = c(150, 550)))

# Extract sequences
dna_sequences <- getSeq(genome, regions)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" loading (2bit files) to keep memory usage low. However, extracting very large sequences into memory as `DNAString` objects can be intensive.
- **Coordinate System**: UCSC versions like `musFur1` use specific naming conventions. Ensure your input data (like SNP locations or gene coordinates) matches the "GLxxxxxx" naming style used in this package.
- **Compatibility**: This package is designed to work seamlessly with `GenomicFeatures`, `BSgenome`, and `Biostrings`.

## Reference documentation

- [BSgenome.Mfuro.UCSC.musFur1 Reference Manual](./references/reference_manual.md)