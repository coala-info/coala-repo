---
name: bioconductor-bsgenome.vvinifera.urgi.iggp8x
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Vvinifera.URGI.IGGP8X.html
---

# bioconductor-bsgenome.vvinifera.urgi.iggp8x

name: bioconductor-bsgenome.vvinifera.urgi.iggp8x
description: Access and analyze the full reference nuclear genome sequences for Vitis vinifera (Grapevine) subsp. vinifera PN40024 (IGGP version 8X). Use this skill when performing genomic analysis in R involving the grapevine genome, including sequence extraction, motif searching, and coordinate-based queries.

# bioconductor-bsgenome.vvinifera.urgi.iggp8x

## Overview

The `BSgenome.Vvinifera.URGI.IGGP8X` package is a Bioconductor data package providing the complete reference genome for *Vitis vinifera* (PN40024). This assembly (IGGP version 8X) is derived from Pinot Noir and is near-homozygous. It is stored as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Installation and Loading

To use this genome in an R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Vvinifera.URGI.IGGP8X")

library(BSgenome.Vvinifera.URGI.IGGP8X)
```

## Basic Usage

### Accessing Genome Metadata
The genome object is named `BSgenome.Vvinifera.URGI.IGGP8X`. You can also use the alias `Vvinifera`.

```r
genome <- BSgenome.Vvinifera.URGI.IGGP8X

# View general information
genome

# List chromosome names
seqnames(genome)

# Get chromosome lengths
seqlengths(genome)
```

### Extracting Sequences
Sequences are returned as `DNAString` objects.

```r
# Access a specific chromosome
chr1_seq <- genome$chr1
# OR
chr1_seq <- genome[["chr1"]]

# Extract a specific sub-sequence (e.g., first 100 nucleotides of chr2)
getSeq(genome, "chr2", start=1, end=100)
```

## Common Workflows

### Genome-Wide Motif Searching
Use the `matchPattern` function from the `Biostrings` package to find specific sequences across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome using vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

### Working with Genomic Ranges
You can extract sequences based on `GRanges` objects, which is useful for analyzing specific features like genes or promoters.

```r
library(GenomicRanges)

# Define regions of interest
my_regions <- GRanges(seqnames = c("chr1", "chr5"),
                      ranges = IRanges(start = c(1000, 5000), end = c(1200, 5200)))

# Extract sequences for these regions
region_seqs <- getSeq(genome, my_regions)
```

## Tips
- **Memory Management**: `BSgenome` objects use "on-disk" caching. Loading the package does not load the entire genome into RAM, but accessing specific chromosomes will.
- **Coordinate System**: Like most Bioconductor packages, this genome uses a 1-based coordinate system.
- **Standardization**: Always verify that your experimental data (e.g., SNP calls or RNA-seq alignments) uses the same assembly version (IGGP 8X) to ensure coordinate compatibility.

## Reference documentation
- [BSgenome.Vvinifera.URGI.IGGP8X Reference Manual](./references/reference_manual.md)