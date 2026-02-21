---
name: bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1.html
---

# bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1

name: bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1
description: A specialized skill for working with the Bioconductor BSgenome data package for Cryptococcus neoformans var. grubii KN99 (ASM221672v1). Use this skill when you need to access full genome sequences, chromosome lengths, or perform genomic motif searching for this specific fungal strain in R.

# bioconductor-bsgenome.cneoformansvargrubiikn99.ncbi.asm221672v1

## Overview

This skill provides guidance on using the `BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1` R package. This package contains the full genome sequence for *Cryptococcus neoformans var. grubii* KN99, based on the NCBI assembly ASM221672v1 (Accession: GCA_002216725.1). It is primarily used for bioinformatics workflows involving sequence extraction, coordinate-based analysis, and genome-wide motif searching.

## Loading and Basic Usage

To use the genome in an R session, load the library and assign the genome object:

```r
library(BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1)

# Assign to a shorter variable for convenience
genome <- BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1
```

### Inspecting the Genome

You can check the available sequences (chromosomes/scaffolds) and their lengths:

```r
# List all sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View metadata about the assembly
genome
```

### Accessing Sequences

Sequences can be accessed using the `$` operator or `[[` with the sequence name (e.g., NCBI accession numbers like CP022321.1):

```r
# Access a specific chromosome/scaffold
chr1 <- genome$CP022321.1

# Get a subsequence (e.g., first 100 bases)
sub_seq <- subseq(genome$CP022321.1, start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching

Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific DNA motifs across the genome:

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search across the entire genome
matches <- vmatchPattern(motif, genome)

# Convert to a GRanges object for further analysis
library(GenomicRanges)
match_ranges <- as(matches, "GRanges")
```

### Extracting Sequences from Coordinates

If you have a set of genomic coordinates (e.g., in a BED file or GRanges object), use `getSeq` to extract the underlying DNA:

```r
# Example GRanges
my_regions <- GRanges(seqnames = c("CP022321.1"), 
                      ranges = IRanges(start = c(100, 500), end = c(150, 550)))

# Extract sequences
sequences <- getSeq(genome, my_regions)
```

## Tips

- **Memory Management**: BSgenome objects use "on-disk" loading, meaning sequences are only loaded into memory when accessed.
- **Sequence Naming**: Ensure your sequence names match the NCBI accessions used in this package (e.g., `CP022321.1`) when performing overlaps or joins with other genomic data.
- **Compatibility**: This package is designed to work seamlessly with `GenomicRanges`, `Biostrings`, and `GenomicFeatures`.

## Reference documentation

- [BSgenome.CneoformansVarGrubiiKN99.NCBI.ASM221672v1 Reference Manual](./references/reference_manual.md)