---
name: bioconductor-bsgenome.amellifera.beebase.assembly4
description: This package provides the full genome sequence for the honey bee (Apis mellifera) based on the BeeBase assembly4. Use when user asks to access honey bee chromosome sequences, calculate sequence lengths, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Amellifera.BeeBase.assembly4.html
---


# bioconductor-bsgenome.amellifera.beebase.assembly4

name: bioconductor-bsgenome.amellifera.beebase.assembly4
description: Provides full genome sequences for Apis mellifera (Honey Bee) based on the BeeBase assembly4 (Feb. 2008). Use this skill when you need to access, analyze, or perform sequence operations on the honey bee genome within R, including retrieving chromosome sequences, calculating sequence lengths, or performing genome-wide motif searching.

# bioconductor-bsgenome.amellifera.beebase.assembly4

## Overview

The `BSgenome.Amellifera.BeeBase.assembly4` package is a data-rich annotation package for Bioconductor. It contains the complete genome sequence for *Apis mellifera* (Honey Bee) as provided by BeeBase. The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis of large genomic sequences.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Amellifera.BeeBase.assembly4")
library(BSgenome.Amellifera.BeeBase.assembly4)
```

## Basic Usage

### Accessing the Genome Object
The primary object is named the same as the package. You can assign it to a shorter variable for convenience.

```r
genome <- BSgenome.Amellifera.BeeBase.assembly4
genome
```

### Exploring Sequence Information
You can check the available sequences (chromosomes/groups) and their respective lengths.

```r
# List all sequence names (e.g., Group1, Group2, etc.)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome/group sequence
# Returns a DNAString object
group1_seq <- genome$Group1 
# OR
group1_seq <- genome[["Group1"]]
```

### Sequence Analysis
Since the sequences are `DNAString` objects, you can use standard `Biostrings` functions.

```r
library(Biostrings)

# Calculate GC content for Group 1
letterFrequency(genome$Group1, letters = "GC", as.prob = TRUE)

# Extract a specific sub-sequence (e.g., first 100 bases of Group 2)
subseq(genome$Group2, start = 1, end = 100)
```

## Genome-wide Motif Searching

To search for a specific DNA motif across the entire genome, use the `vmatchPattern` function from the `Biostrings` package.

```r
# Define a motif
motif <- "TATAAT"

# Search across all chromosomes
matches <- vmatchPattern(motif, genome)

# View matches for a specific group
matches[["Group1"]]
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading the package doesn't load the entire genome into RAM, but accessing specific chromosomes (e.g., `genome$Group1`) will load that specific sequence into memory.
- **Coordinate System**: Like most Bioconductor packages, this genome uses a 1-based coordinate system.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges` and `BSgenome` infrastructure functions like `getSeq()`.

## Reference documentation

- [BSgenome.Amellifera.BeeBase.assembly4 Reference Manual](./references/reference_manual.md)