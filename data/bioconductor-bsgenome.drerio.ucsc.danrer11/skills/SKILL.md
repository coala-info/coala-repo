---
name: bioconductor-bsgenome.drerio.ucsc.danrer11
description: This package provides the complete genome sequence for the Zebrafish based on the UCSC danRer11 assembly. Use when user asks to access Zebrafish genomic sequences, extract specific chromosome subsequences, retrieve promoter sequences, or perform genome-wide motif searching.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer11.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer11

## Overview

The `BSgenome.Drerio.UCSC.danRer11` package is a data-rich Bioconductor annotation package containing the complete genome sequence for the Zebrafish (*Danio rerio*). The data is based on the UCSC danRer11 assembly (May 2017). Sequences are stored as `BSgenome` objects, which allow for efficient memory management and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Drerio.UCSC.danRer11")
library(BSgenome.Drerio.UCSC.danRer11)
```

## Core Workflows

### 1. Accessing Genome Metadata
Once loaded, the genome object is available as `BSgenome.Drerio.UCSC.danRer11`.

```r
genome <- BSgenome.Drerio.UCSC.danRer11

# View general metadata
genome

# List all sequence names (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)
```

### 2. Extracting Specific Sequences
You can retrieve sequences for specific chromosomes using standard list or dollar-sign notation. The returned object is a `DNAString`.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string index
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 100 bases of chr1)
sub_seq <- subseq(genome$chr1, start=1, end=100)
```

### 3. Extracting Upstream (Promoter) Sequences
A common workflow involves using `GenomicFeatures` to extract sequences upstream of known genes.

```r
library(GenomicFeatures)

# Create a TxDb object for danRer11 (requires internet connection or local cache)
txdb <- makeTxDbFromUCSC(genome="danRer11", table="refGene")

# Extract 1000bp upstream of all transcripts
up1000seqs <- extractUpstreamSeqs(genome, txdb, upstream=1000)
```

### 4. Genome-Wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific motifs across the genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# Search across the entire genome
all_matches <- vmatchPattern(motif, genome)
```

## Usage Tips
- **Memory Efficiency**: `BSgenome` objects use "lazy loading." The sequences are not loaded into RAM until you specifically access a chromosome (e.g., via `genome$chr1`).
- **Coordinate Consistency**: Always ensure that your `TxDb` or `GRanges` objects are based on the `danRer11` build to avoid coordinate mismatches.
- **Masks**: Check if the genome contains masks (e.g., for repeat regions) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer11 Reference Manual](./references/reference_manual.md)