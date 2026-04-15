---
name: bioconductor-bsgenome.drerio.ucsc.danrer5
description: This package provides the full genome sequence for Danio rerio (Zebrafish) based on the UCSC danRer5 assembly. Use when user asks to access Zebrafish genomic sequences, analyze chromosome lengths, extract specific DNA sequences, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer5.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer5

name: bioconductor-bsgenome.drerio.ucsc.danrer5
description: Provides full genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer5 assembly (Jul. 2007). Use this skill when you need to access Zebrafish genomic sequences, analyze chromosome lengths, extract specific DNA sequences (like promoters or gene regions), or perform genome-wide motif searching in R.

# bioconductor-bsgenome.drerio.ucsc.danrer5

## Overview

The `BSgenome.Drerio.UCSC.danRer5` package is a Bioconductor data package containing the complete genome sequence for *Danio rerio* (Zebrafish). The data is stored as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Loading the Genome

To use the package, load it into your R session:

```r
library(BSgenome.Drerio.UCSC.danRer5)

# Assign to a shorter variable for convenience
genome <- BSgenome.Drerio.UCSC.danRer5
```

## Common Workflows

### 1. Inspecting Genome Metadata
You can check the available chromosomes and their respective lengths:

```r
# View sequence names (chromosomes)
seqnames(genome)

# View chromosome lengths
seqlengths(genome)

# Access specific chromosome metadata
genome[["chr1"]]
```

### 2. Extracting Sequences
You can extract specific sequences by chromosome name or by using genomic coordinates:

```r
# Get the sequence for a whole chromosome
chr1_seq <- genome$chr1

# Extract a specific sub-sequence (e.g., first 100 bases of chr1)
library(Biostrings)
sub_seq <- getSeq(genome, names="chr1", start=1, end=100)
```

### 3. Extracting Upstream/Promoter Sequences
Since upstream sequences are no longer bundled directly, use `GenomicFeatures` to extract them based on gene models:

```r
library(GenomicFeatures)

# Create a TxDb object for danRer5
txdb <- makeTxDbFromUCSC(genome="danRer5", table="refGene")

# Get gene coordinates and find 1000bp upstream (flanking)
gn <- sort(genes(txdb))
up1000 <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

### 4. Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the genome:

```r
# Search for a specific DNA pattern on chr1
pattern <- "ATGCATGC"
matches <- matchPattern(pattern, genome$chr1)

# Search across the entire genome
all_matches <- vmatchPattern(pattern, genome)
```

## Usage Tips
- **Memory Efficiency**: `BSgenome` objects use "on-disk" loading. Sequences are only loaded into memory when specifically accessed (e.g., via `[[` or `getSeq`), which saves RAM.
- **Coordinate Consistency**: Always ensure that the `TxDb` or `GRanges` objects you use match the `danRer5` assembly to avoid off-by-one errors or chromosome name mismatches.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer5 Reference Manual](./references/reference_manual.md)