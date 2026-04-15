---
name: bioconductor-bsgenome.carietinum.ncbi.v1
description: This package provides the full genome sequences for Cicer arietinum (Chickpea) based on the NCBI ASM33114v1 assembly for use in the Bioconductor environment. Use when user asks to perform genomic analysis, extract sequences, search for motifs, or calculate oligonucleotide frequencies specifically for the Chickpea genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Carietinum.NCBI.v1.html
---

# bioconductor-bsgenome.carietinum.ncbi.v1

name: bioconductor-bsgenome.carietinum.ncbi.v1
description: Provides the full genome sequences for Cicer arietinum (Chickpea) based on the NCBI ASM33114v1 assembly (Jan. 2013). Use this skill when you need to perform genomic analysis, sequence extraction, or motif searching specifically for the Chickpea genome within the Bioconductor R environment.

## Overview

The `BSgenome.Carietinum.NCBI.v1` package is a data provider package containing the complete genome sequence for *Cicer arietinum*. It stores the genomic data as `BSgenome` and `Biostrings` objects, allowing for efficient sequence manipulation and analysis. This package is essential for researchers working on chickpea genetics who require a standardized reference genome.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Carietinum.NCBI.v1")
library(BSgenome.Carietinum.NCBI.v1)
```

## Basic Usage and Sequence Inspection

Once loaded, the genome object can be assigned to a variable for easier access. You can inspect the sequence names and lengths:

```r
# Assign the genome object
genome <- BSgenome.Carietinum.NCBI.v1

# View genome metadata
genome

# List all sequence names (chromosomes/scaffolds)
seqnames(genome)

# Check sequence lengths
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
# Note: Use seqnames(genome) to find the exact string identifier
chr1 <- genome$NC_021160 # Example NCBI accession if applicable
# OR use the index
chr1 <- genome[[1]]
```

## Common Workflows

### Sequence Extraction
Extract specific sub-sequences using `getSeq`:

```r
# Extract a specific region
# Replace "chr_name" with an actual name from seqnames(genome)
my_region <- getSeq(genome, names="chr_name", start=100, end=500)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using functions from the `Biostrings` package:

```r
library(Biostrings)

# Define a pattern
pattern <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches <- matchPattern(pattern, genome[[1]])

# For genome-wide searching, refer to the GenomeSearching vignette
# vignette("GenomeSearching", package="BSgenome")
```

### Frequency Analysis
Calculate oligonucleotide frequencies (e.g., GC content):

```r
# Calculate GC content for the first sequence
alphabetFrequency(genome[[1]], as.prob=TRUE)
```

## Tips
- **Memory Management**: `BSgenome` objects use "lazy loading," meaning sequences are only loaded into memory when specifically accessed.
- **Compatibility**: This package is designed to work seamlessly with other Bioconductor tools like `GenomicRanges`, `Biostrings`, and `GenomicFeatures`.
- **Source Data**: This package is based on the NCBI assembly GCF_000331145.1 (ASM33114v1).

## Reference documentation

- [BSgenome.Carietinum.NCBI.v1 Reference Manual](./references/reference_manual.md)