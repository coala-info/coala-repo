---
name: bioconductor-bsgenome.alyrata.jgi.v1
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Alyrata.JGI.v1.html
---

# bioconductor-bsgenome.alyrata.jgi.v1

## Overview

The `BSgenome.Alyrata.JGI.v1` package is a Bioconductor data package containing the full genome sequence for *Arabidopsis lyrata* (8x Release, project ID 4002920). The data is based on the JGI V1.0 snapshot from March 24, 2011. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Installation and Loading

To use this genome data, the package must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Alyrata.JGI.v1")

library(BSgenome.Alyrata.JGI.v1)
```

## Basic Usage

### Accessing the Genome Object
The main object provided by this package is named `Alyrata`.

```r
# View genome metadata
Alyrata

# List sequence names (chromosomes and scaffolds)
seqnames(Alyrata)

# Get sequence lengths
seqlengths(Alyrata)
```

### Extracting Sequences
You can extract specific chromosome sequences using standard `BSgenome` syntax:

```r
# Access chromosome 1
chr1_seq <- Alyrata$chr1
# OR
chr1_seq <- Alyrata[["chr1"]]

# Extract a specific sub-sequence (e.g., first 100 bp of chr2)
library(Biostrings)
getSeq(Alyrata, "chr2", start=1, end=100)
```

## Common Workflows

### Genome-wide Motif Searching
Because the genome is stored as a `BSgenome` object, you can use `matchPattern` or `vmatchPattern` from the `Biostrings` package to find motifs.

```r
# Find a specific DNA pattern on chromosome 1
pattern <- "TATAAA"
matches <- matchPattern(pattern, Alyrata$chr1)

# Find all occurrences across the entire genome
all_matches <- vmatchPattern(pattern, Alyrata)
```

### Working with Genomic Ranges
This package integrates seamlessly with `GenomicRanges` for coordinate-based analysis.

```r
library(GenomicRanges)

# Define regions of interest
gr <- GRanges(seqnames = c("chr1", "chr2"), 
              ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# Get sequences for these specific ranges
sequences <- getSeq(Alyrata, gr)
```

## Tips
- **Scaffolds**: Note that Chloroplast and Mitochondrion genomes in this version are presented as scaffolds rather than named organelle chromosomes.
- **Memory**: BSgenome objects use "on-disk" loading for sequences, meaning they are memory efficient, but extracting very large sequences into memory may require significant RAM.
- **Version**: This is the JGI V1.0 snapshot. Ensure this matches the assembly version used in your other annotation files (e.g., GFF/GTF).

## Reference documentation
- [BSgenome.Alyrata.JGI.v1 Reference Manual](./references/reference_manual.md)