---
name: bioconductor-bsgenome.scerevisiae.ucsc.saccer3
description: This package provides the full genome sequence for Saccharomyces cerevisiae based on the UCSC sacCer3 build. Use when user asks to access yeast genomic sequences, analyze chromosome lengths, perform motif searching, or extract specific DNA sequences from the sacCer3 reference genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Scerevisiae.UCSC.sacCer3.html
---

# bioconductor-bsgenome.scerevisiae.ucsc.saccer3

name: bioconductor-bsgenome.scerevisiae.ucsc.saccer3
description: Provides the full genome sequence for Saccharomyces cerevisiae (Yeast) based on the UCSC sacCer3 build (April 2011). Use this skill when an AI agent needs to access yeast genomic sequences, analyze chromosome lengths, perform motif searching, or extract specific DNA sequences from the sacCer3 reference genome using R and Bioconductor.

# bioconductor-bsgenome.scerevisiae.ucsc.saccer3

## Overview

The `BSgenome.Scerevisiae.UCSC.sacCer3` package is a data-driven Bioconductor package containing the complete genome sequence for *Saccharomyces cerevisiae*. It stores the sequence data in `Biostrings` objects, allowing for efficient sequence manipulation and analysis. This package is essential for bioinformatics workflows involving yeast genomics, such as peak annotation, sequence extraction for intervals, and genome-wide pattern matching.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Scerevisiae.UCSC.sacCer3")
library(BSgenome.Scerevisiae.UCSC.sacCer3)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package. You can assign it to a shorter variable for convenience:

```r
genome <- BSgenome.Scerevisiae.UCSC.sacCer3
genome
```

### Exploring Sequence Information
Check chromosome names and their respective lengths:

```r
# List all chromosome/sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the genome build and organism
organism(genome)
provider(genome)
release_date(genome)
```

### Extracting Sequences
You can access individual chromosome sequences as `DNAString` objects:

```r
# Access Chromosome I by name
chr1 <- genome$chrI 
# OR
chr1 <- genome[["chrI"]]

# View the first 100 bases of Chromosome I
subseq(chr1, start=1, end=100)
```

## Common Workflows

### Extracting Sequences for Specific Ranges
Use `getSeq()` to extract sequences for specific genomic coordinates defined by a `GRanges` object:

```r
library(GenomicRanges)

# Define regions of interest
query_regions <- GRanges(
  seqnames = c("chrI", "chrII"),
  ranges = IRanges(start = c(100, 500), end = c(150, 550))
)

# Extract sequences
sequences <- getSeq(genome, query_regions)
```

### Genome-wide Motif Searching
To find occurrences of a specific DNA pattern across the entire yeast genome:

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAA")

# Search across all chromosomes
matches <- vmatchPattern(motif, genome)
matches
```

## Tips and Best Practices
- **Memory Efficiency**: The genome is loaded lazily. Accessing `genome$chrI` loads that specific chromosome into memory.
- **Coordinate System**: UCSC genomes use 1-based indexing in R/Bioconductor.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`, `Biostrings`, and `BSgenome` infrastructure functions.
- **Mitochondrial DNA**: The yeast mitochondrial genome is included as `chrM`.

## Reference documentation

- [BSgenome.Scerevisiae.UCSC.sacCer3 Reference Manual](./references/reference_manual.md)