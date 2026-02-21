---
name: bioconductor-bsgenome.sscrofa.ucsc.susscr3
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Sscrofa.UCSC.susScr3.html
---

# bioconductor-bsgenome.sscrofa.ucsc.susscr3

name: bioconductor-bsgenome.sscrofa.ucsc.susscr3
description: Access and analyze the full genome sequences for Sus scrofa (Pig) based on the UCSC susScr3 assembly. Use this skill when performing genomic analysis in R that requires the pig reference genome, such as sequence extraction, motif searching, or coordinate mapping.

# bioconductor-bsgenome.sscrofa.ucsc.susscr3

## Overview

This package provides a `BSgenome` data object containing the complete genome sequences for *Sus scrofa* (Pig) as provided by UCSC (assembly susScr3, August 2011). It is built on the `Biostrings` infrastructure, allowing for efficient sequence manipulation and genome-wide calculations.

## Loading and Initialization

To use the genome data, load the package and optionally assign the genome object to a shorter variable name:

```r
library(BSgenome.Sscrofa.UCSC.susScr3)
genome <- BSgenome.Sscrofa.UCSC.susScr3
```

## Basic Genome Operations

### Inspecting the Genome
View metadata, available sequences (chromosomes), and their lengths:

```r
# Display genome metadata
genome

# Get sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)
```

### Accessing Sequences
Retrieve specific chromosome sequences as `DNAString` objects:

```r
# Access via $ operator
chr1_seq <- genome$chr1

# Access via [[ operator
chr2_seq <- genome[["chr2"]]
```

### Extracting Subsequences
Use `getSeq` to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes:

```r
# Extract a specific range
sub_seq <- getSeq(genome, "chr1", start=1000, end=2000)

# Extract multiple ranges using a GRanges object
library(GenomicRanges)
gr <- GRanges(c("chr1:100-200", "chr2:500-600"))
multi_seqs <- getSeq(genome, gr)
```

## Common Workflows

### Motif Searching
Search for specific DNA patterns across the entire genome or specific chromosomes:

```r
library(Biostrings)

# Define a pattern
pattern <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(pattern, genome$chr1)

# For genome-wide searching, iterate through chromosomes or use vmatchPattern
```

### Calculating GC Content
Analyze the nucleotide composition of specific regions:

```r
# Calculate GC content for a region
region <- getSeq(genome, "chr1", start=1, end=10000)
letterFrequency(region, letters="GC", as.prob=TRUE)
```

## Tips
- Ensure the `BSgenome` and `Biostrings` packages are installed to provide the necessary methods for the `BSgenome` object.
- Use `seqinfo(genome)` to get a summary of the sequence information including genome build and circularity flags.
- When working with large-scale analyses, prefer `getSeq` with `GRanges` to minimize memory overhead.

## Reference documentation
- [BSgenome.Sscrofa.UCSC.susScr3](./references/reference_manual.md)