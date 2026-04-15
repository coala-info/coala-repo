---
name: bioconductor-bsgenome.vvinifera.urgi.iggp12xv2
description: This package provides the full reference nuclear genome sequences for Vitis vinifera (grapevine) version 12Xv2 within the BSgenome framework. Use when user asks to extract grapevine sequences, search for motifs across the Vitis vinifera genome, or perform coordinate-based genomic lookups in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Vvinifera.URGI.IGGP12Xv2.html
---

# bioconductor-bsgenome.vvinifera.urgi.iggp12xv2

name: bioconductor-bsgenome.vvinifera.urgi.iggp12xv2
description: Provides the full reference nuclear genome sequences for Vitis vinifera subsp. vinifera PN40024 (IGGP version 12Xv2). Use this skill when you need to perform genomic analysis on grapevine, including sequence extraction, motif searching, or coordinate-based lookups using the BSgenome framework in R.

# bioconductor-bsgenome.vvinifera.urgi.iggp12xv2

## Overview

This package is a Bioconductor data container (BSgenome object) for the *Vitis vinifera* (grapevine) genome assembly version 12Xv2. It provides the genomic sequences for the PN40024 cultivar, which is near-homozygous. This skill facilitates the programmatic access to these sequences for tasks such as extracting specific gene regions, calculating GC content, or identifying transcription factor binding sites across the grapevine genome.

## Usage and Workflows

### Loading the Genome
To use the genome, you must first load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Vvinifera.URGI.IGGP12Xv2)
genome <- BSgenome.Vvinifera.URGI.IGGP12Xv2
```

### Exploring Genome Metadata
Check chromosome names, lengths, and other assembly information.

```r
# List all chromosome/scaffold names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Accessing Sequences
You can access specific chromosomes using the `$` or `[[` operators. The returned object is a `DNAString`.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string name
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 100 nucleotides of chr1)
sub_seq <- getSeq(genome, "chr1", start=1, end=100)
```

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific sequences across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAWAW"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1, fixed=FALSE)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome, fixed=FALSE)
```

### Working with Genomic Ranges
If you have a `GRanges` object (e.g., from a BED file or gene annotation), you can extract all corresponding sequences at once.

```r
library(GenomicRanges)

# Define regions of interest
regions <- GRanges(seqnames=c("chr1", "chr2"), 
                   ranges=IRanges(start=c(100, 500), end=c(200, 600)))

# Extract sequences for these regions
region_seqs <- getSeq(genome, regions)
```

## Tips
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, working with many large chromosomes simultaneously can still consume significant RAM.
- **Coordinate System**: Bioconductor uses a 1-based coordinate system.
- **Masks**: Check if the genome contains masks (e.g., for repeat regions) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Vvinifera.URGI.IGGP12Xv2 Reference Manual](./references/reference_manual.md)