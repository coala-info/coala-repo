---
name: bioconductor-bsgenome.mfascicularis.ncbi.5.0
description: This package provides the full genome sequences for the Macaca fascicularis (long-tailed macaque) based on the NCBI 5.0 assembly. Use when user asks to access macaque genomic sequences, extract specific chromosome data, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mfascicularis.NCBI.5.0.html
---


# bioconductor-bsgenome.mfascicularis.ncbi.5.0

name: bioconductor-bsgenome.mfascicularis.ncbi.5.0
description: Provides full genome sequences for Macaca fascicularis (long-tailed macaque) based on the NCBI Macaca_fascicularis_5.0 assembly (2013-06-12). Use this skill when you need to perform genomic analysis, sequence extraction, or motif searching specifically for the long-tailed macaque genome in R.

# bioconductor-bsgenome.mfascicularis.ncbi.5.0

## Overview

The `BSgenome.Mfascicularis.NCBI.5.0` package is a Bioconductor data package containing the complete genome sequences for *Macaca fascicularis* (long-tailed macaque). The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis within the R environment. This package is essential for researchers working on non-human primate genomics, providing the foundational sequence data for the NCBI 5.0 assembly.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Mfascicularis.NCBI.5.0")
library(BSgenome.Mfascicularis.NCBI.5.0)
```

## Basic Usage

### Accessing the Genome Object
The primary object is named after the package. You can assign it to a shorter variable for convenience:

```r
genome <- BSgenome.Mfascicularis.NCBI.5.0
genome
```

### Inspecting Sequences
You can check the available sequences (chromosomes and scaffolds) and their lengths:

```r
# List all sequence names (chromosomes, MT, and scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Extracting Specific Sequences
Sequences can be accessed using the `$` operator or double brackets `[[ ]]`. The sequence names follow the NCBI naming convention (e.g., MFA1, MFA2, MT, Scaffold_1).

```r
# Access chromosome 1
chr1 <- genome$MFA1

# Access the Mitochondrial sequence
mt_seq <- genome[["MT"]]

# View a portion of a sequence
subseq(chr1, start=1, end=100)
```

## Common Workflows

### Sequence Ordering
The sequences in this object are ordered according to the NCBI assembly report, with the exception that the Mitochondrial (MT) sequence is positioned between the chromosomes (MFA*) and the scaffolds.

### Genome-wide Motif Searching
You can use functions from the `Biostrings` package to search for specific DNA motifs across the entire genome:

```r
library(Biostrings)

# Define a pattern
pattern <- DNAString("ATGCATGC")

# Match pattern on a specific chromosome
matchPattern(pattern, genome$MFA1)

# For genome-wide searching, iterate through chromosomes or use vmatchPattern
```

### Working with Genomic Ranges
This package integrates seamlessly with `GenomicRanges` for extracting sequences from specific coordinates:

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("MFA1", "MFA2"), 
              ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# Get sequences for these ranges
getSeq(genome, gr)
```

## Tips
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, working with many large chromosomes simultaneously can still consume significant RAM.
- **Sequence Names**: Always verify the exact naming convention using `seqnames(genome)` before attempting to access specific chromosomes, as NCBI names may differ from UCSC names (e.g., "MFA1" vs "chr1").

## Reference documentation
- [Reference Manual](./references/reference_manual.md)