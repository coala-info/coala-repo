---
name: bioconductor-bsgenome.ppaniscus.ucsc.panpan1
description: This package provides the full genome sequences for Pan paniscus (Bonobo) as a BSgenome data container for R. Use when user asks to access Bonobo genome sequences, extract specific DNA sequences by coordinates, or perform genome-wide motif searching using the panPan1 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ppaniscus.UCSC.panPan1.html
---


# bioconductor-bsgenome.ppaniscus.ucsc.panpan1

name: bioconductor-bsgenome.ppaniscus.ucsc.panpan1
description: Access and analyze the full genome sequences for Pan paniscus (Bonobo) as provided by UCSC (assembly panPan1, May 2012). Use this skill when you need to perform genomic analyses in R involving the Bonobo genome, such as sequence extraction, motif searching, or coordinate-based lookups using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.ppaniscus.ucsc.panpan1

## Overview

This skill provides guidance on using the `BSgenome.Ppaniscus.UCSC.panPan1` R package. This package is a data container for the Bonobo (*Pan paniscus*) genome sequences. It stores the genome as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Ppaniscus.UCSC.panPan1)

# Assign to a shorter variable for convenience
genome <- BSgenome.Ppaniscus.UCSC.panPan1
genome
```

### Exploring Genome Metadata
You can check the available sequences (chromosomes/scaffolds) and their lengths.

```r
# List all sequence names
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Check the organism and provider version
organism(genome)
providerVersion(genome)
```

### Accessing Sequences
Sequences can be accessed using the `$` operator or `[[` by sequence name.

```r
# Access a specific scaffold/chromosome
# Note: panPan1 contains many scaffolds (e.g., AJFE01000001)
scaffold1 <- genome$AJFE01000001 

# Get a subsequence (e.g., first 100 bases of a scaffold)
getSeq(genome, "AJFE01000001", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific DNA motifs across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific scaffold
matches <- matchPattern(motif, genome$AJFE01000001)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges
If you have specific coordinates (e.g., from a BED file), use `getSeq` with a `GRanges` object.

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("AJFE01000001"), 
              ranges = IRanges(start = c(100, 500), end = c(150, 550)))

# Extract sequences for these ranges
sequences <- getSeq(genome, gr)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" caching via the `.2bit` format logic, but loading very large sequences into memory as `DNAString` objects can be intensive. Use `getSeq` with specific ranges whenever possible.
- **Scaffold Names**: The `panPan1` assembly contains many unplaced scaffolds. Always verify the exact sequence name using `seqnames(genome)` before attempting to access it.

## Reference documentation

- [BSgenome.Ppaniscus.UCSC.panPan1 Reference Manual](./references/reference_manual.md)