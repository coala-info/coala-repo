---
name: bioconductor-bsgenome.celegans.ucsc.ce11
description: This package provides the full genome sequences for Caenorhabditis elegans based on the UCSC ce11 assembly. Use when user asks to retrieve C. elegans chromosome sequences, extract specific genomic subsequences, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Celegans.UCSC.ce11.html
---


# bioconductor-bsgenome.celegans.ucsc.ce11

name: bioconductor-bsgenome.celegans.ucsc.ce11
description: Provides full genome sequences for Caenorhabditis elegans (Worm) based on the UCSC ce11 (Feb. 2013) assembly. Use this skill when you need to access, analyze, or manipulate the C. elegans genome in R, including retrieving chromosome sequences, calculating sequence lengths, or performing genome-wide motif searching using Biostrings.

# bioconductor-bsgenome.celegans.ucsc.ce11

## Overview

The `BSgenome.Celegans.UCSC.ce11` package is a data provider for the C. elegans genome. It stores the complete genomic sequence as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `BSgenome`.

## Basic Usage

### Loading the Genome
To use the package, load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Celegans.UCSC.ce11)
genome <- BSgenome.Celegans.UCSC.ce11
```

### Inspecting Genome Metadata
Check available chromosomes and their respective lengths.

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Retrieving Sequences
Access specific chromosome sequences as `DNAString` objects.

```r
# Access Chromosome I using $ or [[]]
chr1 <- genome$chrI
# OR
chr1 <- genome[["chrI"]]

# View sequence details
chr1
```

## Common Workflows

### Extracting Subsequences
Use `getSeq` to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes if only specific coordinates are needed.

```r
# Extract a specific region from Chromosome II
# Coordinates: 1000 to 2000
sub_seq <- getSeq(genome, "chrII", start=1000, end=2000)
```

### Genome-wide Motif Searching
The package is designed to work with `matchPattern` and `vmatchPattern` from the `Biostrings` package for finding sequences across the entire genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chrI)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges
You can use `GRanges` objects to subset the genome.

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("chrI", "chrX"), 
              ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# Get sequences for these ranges
getSeq(genome, gr)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" caching. Loading the package doesn't load the entire genome into RAM immediately, but accessing `genome$chrI` will load that specific chromosome.
- **Naming Convention**: Always use the UCSC naming convention (e.g., "chrI", "chrM") when querying this specific package.
- **Compatibility**: This package is intended for use with the `ce11` assembly. If your data is mapped to `ce10` or `WS235`, ensure you lift over coordinates or use the corresponding BSgenome package.

## Reference documentation

- [BSgenome.Celegans.UCSC.ce11 Reference Manual](./references/reference_manual.md)