---
name: bioconductor-bsgenome.scerevisiae.ucsc.saccer1
description: This package provides the full genome sequence for Saccharomyces cerevisiae based on the UCSC sacCer1 assembly for use within the Bioconductor framework. Use when user asks to access yeast genomic sequences, retrieve chromosome lengths, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Scerevisiae.UCSC.sacCer1.html
---

# bioconductor-bsgenome.scerevisiae.ucsc.saccer1

name: bioconductor-bsgenome.scerevisiae.ucsc.saccer1
description: Provides the full genome sequence for Saccharomyces cerevisiae (Yeast) as provided by UCSC (build sacCer1, Oct. 2003). Use this skill when an AI agent needs to access yeast genomic sequences, analyze chromosome lengths, or perform genome-wide motif searching using Bioconductor's BSgenome framework in R.

# bioconductor-bsgenome.scerevisiae.ucsc.saccer1

## Overview

This package is a data provider for the *Saccharomyces cerevisiae* (Yeast) genome, specifically the UCSC sacCer1 assembly. It stores the genome as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Usage and Workflows

### Loading the Genome
To use the genome, you must load the package and assign the genome object to a variable for easier access.

```r
library(BSgenome.Scerevisiae.UCSC.sacCer1)
genome <- BSgenome.Scerevisiae.UCSC.sacCer1
```

### Inspecting Genome Metadata
You can check the available chromosomes (sequences) and their respective lengths.

```r
# List all chromosome names
seqnames(genome)

# Get lengths of all chromosomes
seqlengths(genome)

# Check the organism and provider version
metadata(genome)
```

### Accessing Specific Sequences
Chromosomes can be accessed using the `$` operator or double brackets `[[ ]]`. The returned object is a `DNAString`.

```r
# Access Chromosome 1
chr1_seq <- genome$chr1

# Access using a string variable
chr_name <- "chrIV"
chriv_seq <- genome[[chr_name]]

# Get a subsequence (e.g., first 100 bases of chr1)
sub_seq <- subseq(genome$chr1, start=1, end=100)
```

### Genome-Wide Motif Searching
Because the genome is stored as a `BSgenome` object, you can use `matchPattern` or `vmatchPattern` from the `Biostrings` package to find sequences across the entire genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a single chromosome
matches_chr1 <- matchPattern(motif, genome$chr1)

# Search across all chromosomes
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading or efficient caching. You do not need to manually load every chromosome into memory at once.
- **Coordinate System**: UCSC versions like `sacCer1` use the "chr" prefix (e.g., `chrI`, `chrII`). Ensure your GRanges objects or annotation data use matching naming conventions.
- **Assembly Version**: Note that `sacCer1` is an older assembly (2003). If your research requires the most recent yeast genome, verify if `sacCer3` is more appropriate.

## Reference documentation

- [BSgenome.Scerevisiae.UCSC.sacCer1 Reference Manual](./references/reference_manual.md)