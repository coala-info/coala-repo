---
name: bioconductor-bsgenome.amellifera.ucsc.apimel2
description: This package provides the full genome sequences for the honey bee (Apis mellifera) based on the UCSC apiMel2 assembly for use in R. Use when user asks to access honey bee genomic sequences, extract specific DNA sub-sequences, retrieve chromosome lengths, or perform genome-wide motif searching.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Amellifera.UCSC.apiMel2.html
---


# bioconductor-bsgenome.amellifera.ucsc.apimel2

name: bioconductor-bsgenome.amellifera.ucsc.apimel2
description: Access and analyze the full genome sequences for Apis mellifera (Honey Bee) using the UCSC apiMel2 assembly (Jan. 2005). Use this skill when performing genomic analysis in R that requires the honey bee reference genome, including sequence extraction, chromosome length retrieval, and genome-wide motif searching.

# bioconductor-bsgenome.amellifera.ucsc.apimel2

## Overview

The `BSgenome.Amellifera.UCSC.apiMel2` package is a data provider package for Bioconductor. It contains the full genome sequences for *Apis mellifera* (Honey Bee) as provided by UCSC (assembly apiMel2). The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis of large genomic sequences within the R environment.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Amellifera.UCSC.apiMel2")
library(BSgenome.Amellifera.UCSC.apiMel2)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package. You can assign it to a shorter variable for convenience.

```r
genome <- BSgenome.Amellifera.UCSC.apiMel2
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
genome$Group1 
# OR
genome[["Group1"]]
```

### Sequence Extraction
Use `getSeq` from the `BSgenome` package to extract specific sub-sequences.

```r
library(BSgenome)

# Extract a specific range from Group1
sub_seq <- getSeq(genome, "Group1", start=100, end=150)
```

## Common Workflows

### Genome-wide Motif Searching
To search for a specific DNA motif across the entire honey bee genome, use the `matchPattern` function from the `Biostrings` package in combination with `vapply` or `lapply` over the sequences.

```r
library(Biostrings)

# Define the motif
motif <- "TATAAT"

# Search on a specific group
matches <- matchPattern(motif, genome$Group1)

# To search across all sequences, refer to the 'GenomeSearching' vignette
# in the BSgenome software package:
# vignette("GenomeSearching", package="BSgenome")
```

## Tips
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed.
- **Compatibility**: This package is designed to work seamlessly with other Bioconductor packages like `GenomicRanges`, `Biostrings`, and `BSgenome`.
- **Assembly Version**: Note that `apiMel2` is an older assembly (2005). Ensure this matches the coordinates of your experimental data (e.g., SNP locations or ChIP-seq peaks).

## Reference documentation

- [BSgenome.Amellifera.UCSC.apiMel2 Reference Manual](./references/reference_manual.md)