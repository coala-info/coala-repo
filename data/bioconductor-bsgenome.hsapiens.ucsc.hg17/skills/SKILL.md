---
name: bioconductor-bsgenome.hsapiens.ucsc.hg17
description: This package provides the full genome sequences for the hg17 assembly of the human genome as Biostrings objects. Use when user asks to load hg17 sequences, extract specific genomic regions, or perform genome-wide motif searching on the May 2004 human assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg17.html
---


# bioconductor-bsgenome.hsapiens.ucsc.hg17

## Overview

The `BSgenome.Hsapiens.UCSC.hg17` package is a data-driven Bioconductor package containing the full genome sequences for the hg17 (May 2004) assembly of the human genome. It stores sequences as `Biostrings` objects, allowing for efficient memory management and high-performance sequence analysis.

## Core Workflows

### Loading the Genome
To use the package, you must load it and optionally assign the provider object to a shorter variable name.

```r
library(BSgenome.Hsapiens.UCSC.hg17)
genome <- BSgenome.Hsapiens.UCSC.hg17
```

### Inspecting Sequence Information
You can view available chromosomes and their respective lengths.

```r
# List all sequences (chromosomes)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1 
# or
chr1_seq <- genome[["chr1"]]
```

### Extracting Subsequences
Use `getSeq()` to extract specific genomic regions. This is the preferred method for retrieving sequences based on coordinates.

```r
# Extract a specific range
my_range <- GRanges("chr1", IRanges(start=1000000, end=1000500))
seq <- getSeq(genome, my_range)
```

### Extracting Upstream/Promoter Sequences
While upstream sequences are no longer bundled as separate objects, they can be extracted by combining this package with `GenomicFeatures`.

```r
library(GenomicFeatures)
# Ensure the TxDb matches the hg17 genome
txdb <- makeTxDbFromUCSC(genome="hg17", table="knownGene")
gn <- genes(txdb)

# Get 1000bp upstream of all genes
up1000_coords <- flank(gn, width=1000)
up1000_seqs <- getSeq(genome, up1000_coords)
```

## Genome-Wide Motif Searching
To search for specific patterns across the entire hg17 genome, use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package.

```r
library(Biostrings)
pattern <- "TATAAA" # Example TATA box
matches <- vmatchPattern(pattern, genome)
```

## Usage Tips
- **Memory Efficiency**: The sequences are loaded into memory on-demand (lazy loading). Accessing `genome$chr1` will load that specific chromosome into RAM.
- **Coordinate Consistency**: Always ensure that any annotation objects (like `TxDb` or `GRanges`) use the "hg17" genome build to avoid off-by-one errors or chromosome name mismatches.
- **Masks**: Check if the genome object contains masks (e.g., for assembly gaps or repeats) by inspecting `alphabetFrequency(genome$chr1)`.

## Reference documentation
- [BSgenome.Hsapiens.UCSC.hg17](./references/reference_manual.md)