---
name: bioconductor-bsgenome.hsapiens.ncbi.grch38
description: This package provides the full genome sequences for Homo sapiens based on the NCBI GRCh38 assembly for use in R. Use when user asks to access human genomic sequences, perform genome-wide motif searching, or calculate nucleotide frequencies using the BSgenome framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.NCBI.GRCh38.html
---

# bioconductor-bsgenome.hsapiens.ncbi.grch38

name: bioconductor-bsgenome.hsapiens.ncbi.grch38
description: Provides the full genome sequences for Homo sapiens (Human) based on the NCBI GRCh38 assembly (2013-12-17). Use this skill when you need to access, analyze, or manipulate human genomic sequences in R, perform genome-wide motif searching, or extract specific chromosome sequences using Biostrings and BSgenome frameworks.

# bioconductor-bsgenome.hsapiens.ncbi.grch38

## Overview
The `BSgenome.Hsapiens.NCBI.GRCh38` package is a data-rich Bioconductor annotation package containing the complete genome sequence for *Homo sapiens* as provided by NCBI (Assembly GRCh38). The sequences are stored as `DNAString` objects, allowing for efficient memory usage and integration with the `Biostrings` and `BSgenome` software suites.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Hsapiens.NCBI.GRCh38")
library(BSgenome.Hsapiens.NCBI.GRCh38)
```

## Basic Usage
The main object is named `BSgenome.Hsapiens.NCBI.GRCh38`. You can assign it to a shorter variable for convenience.

### Exploring the Genome
```r
# Assign to a shorter variable
genome <- BSgenome.Hsapiens.NCBI.GRCh38

# View genome metadata
genome

# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the genome build and organism
organism(genome)
provider(genome)
release_date(genome)
```

### Accessing Sequences
Sequences can be accessed using list-style double bracket notation.
```r
# Extract Chromosome 1
chr1 <- genome[["1"]]
chr1

# Extract a specific sub-sequence (e.g., first 100 nucleotides of Chromosome 2)
sub_seq <- subseq(genome[["2"]], start = 1, end = 100)
```

## Common Workflows

### Genome-wide Motif Searching
You can use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the entire genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a specific chromosome
matches_chr1 <- matchPattern(motif, genome[["1"]], fixed = FALSE)

# Search across all chromosomes
all_matches <- vmatchPattern(motif, genome, fixed = FALSE)
```

### Calculating Nucleotide Frequencies
```r
# Calculate ACGT frequencies for Chromosome X
alphabetFrequency(genome[["X"]], baseOnly = TRUE)

# Calculate GC content for a specific region
chr1_seq <- genome[["1"]]
gc_content <- letterFrequency(chr1_seq, letters = "GC", as.prob = TRUE)
```

## Tips and Best Practices
- **Memory Management**: Loading entire chromosomes into memory as `DNAString` objects is efficient, but be cautious when performing operations on all chromosomes simultaneously.
- **Sequence Naming**: This package uses NCBI naming conventions (e.g., "1", "2", "X", "MT") rather than UCSC conventions (e.g., "chr1", "chrM"). Use `seqlevelsStyle(genome) <- "UCSC"` if you need to convert styles for compatibility with other packages.
- **Coordinate System**: Remember that R and Bioconductor use a 1-based coordinate system.

## Reference documentation
- [BSgenome.Hsapiens.NCBI.GRCh38 Reference Manual](./references/reference_manual.md)