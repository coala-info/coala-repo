---
name: bioconductor-bsgenome.gaculeatus.ucsc.gasacu1
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Gaculeatus.UCSC.gasAcu1.html
---

# bioconductor-bsgenome.gaculeatus.ucsc.gasacu1

## Overview

This package is a Bioconductor data resonance (BSgenome) object containing the complete genome sequence for the stickleback (*Gasterosteus aculeatus*). The data is based on the UCSC gasAcu1 assembly. It allows for efficient programmatic access to chromosome sequences, sequence lengths, and sub-sequence extraction using standard Biostrings and GenomicRanges workflows.

## Loading and Basic Usage

To use the genome in an R session, load the library and assign the genome object:

```r
library(BSgenome.Gaculeatus.UCSC.gasAcu1)

# Access the genome object
genome <- BSgenome.Gaculeatus.UCSC.gasAcu1

# View metadata and available sequences
genome
seqinfo(genome)
seqlengths(genome)
```

## Sequence Extraction

You can access specific chromosomes or extract sequences based on genomic coordinates.

### Accessing Chromosomes
```r
# Access chromosome I
chr1_seq <- genome$chrI 
# Or using the double bracket notation
chr1_seq <- genome[["chrI"]]
```

### Extracting Specific Regions
Use `getSeq()` to extract specific ranges. This is the preferred method for extracting multiple regions (e.g., promoters or exons).

```r
library(GenomicRanges)

# Define a region of interest
my_range <- GRanges("chrI", IRanges(start=1000, end=2000))

# Get the sequence
seq_data <- getSeq(genome, my_range)
```

## Common Workflows

### Extracting Upstream (Promoter) Sequences
Since version 3.0, upstream sequences are not pre-packaged but can be generated using a `TxDb` object that matches the `gasAcu1` assembly.

```r
library(GenomicFeatures)

# Create or load a TxDb for gasAcu1
txdb <- makeTxDbFromUCSC(genome="gasAcu1", table="refGene")

# Get gene coordinates and find 1000bp upstream
gn <- sort(genes(txdb))
up1000 <- flank(gn, width=1000)

# Extract the sequences from the BSgenome object
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire stickleback genome using `matchPattern` or `vmatchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chrI)

# Search across the whole genome
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Coordinate Consistency**: Always ensure your `GRanges` or `TxDb` objects use the `gasAcu1` build to avoid coordinate shifts.
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading a specific chromosome (e.g., `genome$chrI`) loads it into memory as a `DNAString`.
- **Naming Convention**: UCSC stickleback chromosomes use Roman numerals (e.g., `chrI`, `chrII`, `chrM`).

## Reference documentation
- [BSgenome.Gaculeatus.UCSC.gasAcu1 Reference Manual](./references/reference_manual.md)