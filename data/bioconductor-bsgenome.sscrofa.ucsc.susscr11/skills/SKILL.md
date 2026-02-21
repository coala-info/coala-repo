---
name: bioconductor-bsgenome.sscrofa.ucsc.susscr11
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Sscrofa.UCSC.susScr11.html
---

# bioconductor-bsgenome.sscrofa.ucsc.susscr11

name: bioconductor-bsgenome.sscrofa.ucsc.susscr11
description: Provides full genome sequences for Sus scrofa (Pig) based on the UCSC susScr11 assembly (Feb. 2017). Use this skill when an AI agent needs to access pig genomic sequences, perform genome-wide motif searching, or analyze sequence data for the susScr11 assembly using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.sscrofa.ucsc.susscr11

## Overview

The `BSgenome.Sscrofa.UCSC.susScr11` package is a data provider for the pig (*Sus scrofa*) genome. It stores the complete genome sequence as a `BSgenome` object, allowing for efficient sequence retrieval, pattern matching, and integration with other Bioconductor packages like `GenomicRanges` and `Biostrings`.

## Loading and Accessing the Genome

To use the genome in an R session, load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Sscrofa.UCSC.susScr11)

# Assign to a shorter variable name
genome <- BSgenome.Sscrofa.UCSC.susScr11

# View genome metadata
genome

# List all sequences (chromosomes and scaffolds)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)
```

## Sequence Retrieval

You can extract specific chromosome sequences or sub-sequences using standard Biostrings syntax.

```r
# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1
# Alternative syntax
chr1_seq <- genome[["chr1"]]

# Get a specific sub-sequence (e.g., first 100bp of chr2)
getSeq(genome, "chr2", start=1, end=100)

# Get sequences for multiple genomic ranges (requires GenomicRanges)
library(GenomicRanges)
gr <- GRanges(seqnames=c("chr1", "chr5"), 
              ranges=IRanges(start=c(100, 500), end=c(150, 550)))
getSeq(genome, gr)
```

## Genome-Wide Motif Searching

The package is frequently used to find occurrences of specific DNA patterns across the entire pig genome.

```r
# Search for a specific DNA pattern on chr1
matchPattern("ATGCATGC", genome$chr1)

# For genome-wide searching, use vmatchPattern
# This returns a GRangesList of all matches
pattern <- "TATAAT"
matches <- vmatchPattern(pattern, genome)
```

## Usage Tips

- **Memory Management**: BSgenome objects use "on-disk" caching. Loading the package does not load the entire genome into RAM, but accessing a specific chromosome (e.g., `genome$chr1`) will load that specific sequence into memory.
- **Coordinate System**: This package uses the UCSC coordinate system (1-based, inclusive) and UCSC naming conventions (e.g., "chr1", "chrM").
- **Compatibility**: Ensure your annotation data (like TxDb or EnsDb objects) matches the `susScr11` assembly version to avoid coordinate mismatches.

## Reference documentation

- [BSgenome.Sscrofa.UCSC.susScr11 Reference Manual](./references/reference_manual.md)