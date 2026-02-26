---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro6
description: This package provides the full genome sequence for the Chimpanzee (Pan troglodytes) based on the UCSC panTro6 assembly for use in R. Use when user asks to extract sequences, search for motifs, calculate GC content, or perform coordinate-based lookups using the Chimp reference genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro6.html
---


# bioconductor-bsgenome.ptroglodytes.ucsc.pantro6

name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro6
description: Access and analyze the full genome sequences for Pan troglodytes (Chimpanzee) using the UCSC panTro6 assembly (Jan. 2018). Use this skill when performing genomic analysis in R that requires the Chimp reference genome, including sequence extraction, motif searching, or coordinate-based lookups.

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro6

## Overview

The `BSgenome.Ptroglodytes.UCSC.panTro6` package is a data-driven Bioconductor package providing the complete genome sequence for *Pan troglodytes* (Chimpanzee) as represented by the UCSC panTro6 assembly. It stores sequences as `Biostrings` objects, allowing for efficient memory management and integration with the broader Bioconductor ecosystem (e.g., `GenomicRanges`, `BSgenome`, and `Biostrings`).

## Loading and Inspection

To use the genome, load the package and assign the object to a variable for easier access.

```r
library(BSgenome.Ptroglodytes.UCSC.panTro6)

# Assign to a shorter variable name
genome <- BSgenome.Ptroglodytes.UCSC.panTro6

# Inspect genome metadata
genome
metadata(genome)

# List sequence names (chromosomes/scaffolds)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
head(seqlengths(genome))
```

## Accessing Sequences

Sequences can be accessed by chromosome name using standard list or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1
# Or
chr1_seq <- genome[["chr1"]]

# View a snippet of the sequence
chr1_seq
```

## Common Workflows

### Extracting Specific Subsequences
Use `getSeq()` from the `BSgenome` package to extract specific regions. This is more memory-efficient than loading entire chromosomes.

```r
library(BSgenome)

# Extract a specific range
my_range <- GRanges("chr1", IRanges(start=1000, end=2000))
sub_seq <- getSeq(genome, my_range)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern` or `vmatchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr2)

# Search across the entire genome (returns a GRangesList)
all_matches <- vmatchPattern(motif, genome)
```

### Calculating GC Content
Calculate the GC content for specific regions or chromosomes.

```r
# GC content for a specific sequence
letterFrequency(genome$chr1, letters="GC", as.prob=TRUE)
```

## Tips
- **Memory Management**: Avoid loading all chromosomes into memory simultaneously. Use `getSeq()` with `GRanges` to pull only the data needed for your analysis.
- **Coordinate Systems**: Ensure your input coordinates (e.g., from BED files) match the UCSC naming convention (e.g., "chr1", "chr2") used by this package.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation

- [BSgenome.Ptroglodytes.UCSC.panTro6 Reference Manual](./references/reference_manual.md)