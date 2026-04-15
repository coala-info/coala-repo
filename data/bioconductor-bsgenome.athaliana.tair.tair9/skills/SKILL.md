---
name: bioconductor-bsgenome.athaliana.tair.tair9
description: This package provides the full genome sequences for Arabidopsis thaliana based on the TAIR9 release as Biostrings objects. Use when user asks to load Arabidopsis thaliana genome sequences, retrieve specific chromosome sub-sequences, or perform genome-wide motif searching and sequence analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Athaliana.TAIR.TAIR9.html
---

# bioconductor-bsgenome.athaliana.tair.tair9

## Overview

The `BSgenome.Athaliana.TAIR.TAIR9` package is a Bioconductor data package containing the full genome sequences for *Arabidopsis thaliana* as provided by TAIR (TAIR9 Genome Release). The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis. Note that while TAIR10 is a common annotation release, it uses the same underlying genome assembly as TAIR9.

## Installation

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Athaliana.TAIR.TAIR9")
```

## Basic Usage

### Loading the Genome

```r
library(BSgenome.Athaliana.TAIR.TAIR9)

# Assign to a shorter variable for convenience
genome <- BSgenome.Athaliana.TAIR.TAIR9
```

### Exploring Genome Metadata

```r
# List available chromosomes/sequences
seqnames(genome)

# Get chromosome lengths
seqlengths(genome)

# Check the organism and provider information
organism(genome)
provider(genome)
release_date(genome)
```

### Retrieving Sequences

You can access specific chromosomes using the `$` operator or double brackets:

```r
# Access Chromosome 1
chr1 <- genome$Chr1

# Access via string name
chr2 <- genome[["Chr2"]]

# Get a specific sub-sequence (e.g., first 100 nucleotides of Chr3)
sub_seq <- getSeq(genome, "Chr3", start=1, end=100)
```

## Common Workflows

### Sequence Statistics

Calculate nucleotide frequencies or GC content across a chromosome:

```r
library(Biostrings)

# Calculate nucleotide frequency for Chromosome 1
alphabetFrequency(genome$Chr1)

# Calculate GC content
letterFrequency(genome$Chr1, letters="GC", as.prob=TRUE)
```

### Genome-wide Motif Searching

To find all occurrences of a specific DNA motif (e.g., a TATA box) across the genome:

```r
# Define the motif
motif <- DNAString("TATAAA")

# Match the motif on Chromosome 1
matches <- matchPattern(motif, genome$Chr1)

# To search across all chromosomes, use vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges

The package integrates seamlessly with `GenomicRanges` for extracting sequences from specific coordinates:

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("Chr1", "Chr2"),
              ranges = IRanges(start = c(100, 500), end = c(150, 600)))

# Extract sequences for these ranges
sequences <- getSeq(genome, gr)
```

## Tips

- **Memory Efficiency**: BSgenome objects use "on-disk" caching. Loading the package does not immediately load all sequences into RAM; they are loaded as you access specific chromosomes.
- **Naming Convention**: Ensure you use the correct chromosome naming prefix (e.g., "Chr1", "ChrM" for mitochondria, "ChrC" for chloroplast) as defined in `seqnames(genome)`.
- **Compatibility**: This package is compatible with all Bioconductor tools that accept `BSgenome` objects, such as `BSgenome::forgeBSgenomeDataPkg` or `PWMEnrich`.

## Reference documentation

- [BSgenome.Athaliana.TAIR.TAIR9 Reference Manual](./references/reference_manual.md)