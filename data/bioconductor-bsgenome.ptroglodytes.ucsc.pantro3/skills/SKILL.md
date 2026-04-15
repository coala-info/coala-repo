---
name: bioconductor-bsgenome.ptroglodytes.ucsc.pantro3
description: This package provides the Pan troglodytes (Chimp) genome sequences from the UCSC panTro3 assembly as a BSgenome data object. Use when user asks to retrieve chimp genome sequences, inspect chromosome metadata, extract specific sub-sequences, or perform genome-wide motif searching.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ptroglodytes.UCSC.panTro3.html
---

# bioconductor-bsgenome.ptroglodytes.ucsc.pantro3

## Overview

This package is a data container for the *Pan troglodytes* (Chimp) genome sequences as provided by UCSC (assembly panTro3). It stores the genome as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Basic Usage

### Loading the Genome
To use the genome, you must load the library and the specific genome object.

```r
library(BSgenome.Ptroglodytes.UCSC.panTro3)

# Assign to a shorter variable for convenience
genome <- BSgenome.Ptroglodytes.UCSC.panTro3
```

### Inspecting Genome Metadata
You can check chromosome names, lengths, and other metadata.

```r
# View available chromosomes
seqnames(genome)

# View chromosome lengths
seqlengths(genome)

# Check the organism and provider
provider(genome)
commonName(genome)
```

### Accessing Sequences
Sequences can be accessed using standard list-style or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for programmatic loops)
chr_name <- "chr2a"
seq <- genome[[chr_name]]

# Get a specific sub-sequence (e.g., first 100 bases of chr1)
sub_seq <- getSeq(genome, Names = "chr1", start = 1, end = 100)
```

## Common Workflows

### Extracting Upstream/Promoter Sequences
While upstream sequences are no longer bundled directly, they can be extracted using a `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb for panTro3
txdb <- makeTxDbFromUCSC(genome = "panTro3", table = "refGene")

# Get gene regions and flank them to get 1000bp upstream
gn <- sort(genes(txdb))
up1000 <- flank(gn, width = 1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-Wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# To search the whole genome, iterate over seqnames or use vmatchPattern
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: `BSgenome` objects use "lazy loading." Chromosomes are only loaded into memory when accessed. If working with many chromosomes, memory usage may increase; use `gc()` if necessary.
- **Coordinate Consistency**: Always ensure that your `GRanges` or `TxDb` objects are based on the `panTro3` assembly to avoid off-by-one errors or mismatched chromosome names.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) by inspecting `alphabetFrequency(genome$chr1)`.

## Reference documentation
- [BSgenome.Ptroglodytes.UCSC.panTro3](./references/reference_manual.md)