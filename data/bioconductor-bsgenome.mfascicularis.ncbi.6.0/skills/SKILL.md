---
name: bioconductor-bsgenome.mfascicularis.ncbi.6.0
description: This package provides the full genome sequences for Macaca fascicularis based on the NCBI assembly Macaca_fascicularis_6.0 as a BSgenome object. Use when user asks to access Crab-eating macaque genomic sequences, perform motif searching, or analyze nucleotide frequencies within the Bioconductor environment.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mfascicularis.NCBI.6.0.html
---


# bioconductor-bsgenome.mfascicularis.ncbi.6.0

name: bioconductor-bsgenome.mfascicularis.ncbi.6.0
description: Provides the full genome sequences for Macaca fascicularis (Crab-eating macaque) based on the NCBI assembly Macaca_fascicularis_6.0 (GCA_011100615.1). Use this skill when you need to access, analyze, or perform sequence operations on the Cynomolgus monkey genome within the R/Bioconductor environment.

# bioconductor-bsgenome.mfascicularis.ncbi.6.0

## Overview

This package is a Bioconductor data provider containing the complete genome sequences for *Macaca fascicularis* (Crab-eating macaque). The data is based on the NCBI assembly version 6.0 and is stored as a `BSgenome` object. This allows for efficient sequence retrieval, motif searching, and integration with other Bioconductor tools like `GenomicRanges` and `Biostrings`.

## Loading the Genome

To use the genome in an R session, load the library and assign the genome object to a variable:

```r
library(BSgenome.Mfascicularis.NCBI.6.0)
genome <- BSgenome.Mfascicularis.NCBI.6.0
```

## Common Workflows

### 1. Inspecting Genome Metadata
Check the available sequences (chromosomes/scaffolds) and their lengths:

```r
# View sequence names
seqnames(genome)

# View sequence lengths
seqlengths(genome)

# Check the assembly version and provider
metadata(genome)
```

### 2. Retrieving Sequences
Extract specific chromosomes or sub-sequences:

```r
# Access a specific chromosome (e.g., Chromosome 1)
chr1 <- genome[["1"]]

# Get a specific sub-sequence (e.g., first 100bp of Chromosome 2)
getSeq(genome, "2", start=1, end=100)
```

### 3. Genome-wide Motif Searching
Search for specific DNA patterns across the entire genome using the `matchPattern` function from the `Biostrings` package:

```r
library(Biostrings)
# Define a motif
motif <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(motif, genome[["1"]])

# To search across all chromosomes, use vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

### 4. Calculating Nucleotide Frequency
Analyze the composition of the genome:

```r
# GC content for a specific chromosome
alphabetFrequency(genome[["1"]], as.prob=TRUE)
```

## Usage Tips
- **Object Class**: The main object is a `BSgenome` object. Functions that work on `BSgenome` objects (found in the `BSgenome` software package) are applicable here.
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading for sequences, meaning they are memory-efficient and only load specific sequences into RAM when accessed.
- **Naming Convention**: This package uses NCBI sequence naming (e.g., "1", "2", "X") rather than UCSC naming (e.g., "chr1"). Use `seqlevelsStyle(genome) <- "UCSC"` if you need to convert styles for compatibility with other datasets.

## Reference documentation

- [BSgenome.Mfascicularis.NCBI.6.0 Reference Manual](./references/reference_manual.md)