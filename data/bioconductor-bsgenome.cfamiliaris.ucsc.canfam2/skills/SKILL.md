---
name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam2
description: This package provides the full genome sequence for Canis lupus familiaris based on the UCSC canFam2 assembly. Use when user asks to access dog genomic sequences, extract specific chromosomal regions, calculate sequence statistics, or perform genome-wide motif searching for the canFam2 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cfamiliaris.UCSC.canFam2.html
---

# bioconductor-bsgenome.cfamiliaris.ucsc.canfam2

name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam2
description: Provides full genome sequences for Canis lupus familiaris (Dog) based on the UCSC canFam2 assembly (May 2005). Use this skill when an AI agent needs to access dog genomic sequences, extract specific chromosomal regions, calculate sequence statistics, or perform genome-wide motif searching for the canFam2 assembly in R.

# bioconductor-bsgenome.cfamiliaris.ucsc.canfam2

## Overview

The `BSgenome.Cfamiliaris.UCSC.canFam2` package is a data-driven Bioconductor annotation package containing the complete genome sequence for the dog (*Canis lupus familiaris*). It uses the UCSC canFam2 assembly. The sequences are stored as `Biostrings` objects, allowing for efficient manipulation and analysis of large genomic data.

## Core Workflows

### Loading the Genome
To use the package, you must load it and then reference the genome object.

```r
library(BSgenome.Cfamiliaris.UCSC.canFam2)
genome <- BSgenome.Cfamiliaris.UCSC.canFam2
```

### Inspecting Genome Metadata
You can check sequence names, lengths, and other metadata.

```r
# List all chromosomes/scaffolds
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the organism and provider
provider(genome)
commonName(genome)
```

### Accessing Specific Sequences
Sequences can be accessed using standard list-style or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for loops)
chr_name <- "chrX"
chrx_seq <- genome[[chr_name]]

# View a portion of the sequence
subseq(genome$chr1, start=1, end=100)
```

### Extracting Genomic Regions
Use `getSeq()` to extract specific coordinates, often in conjunction with `GenomicRanges`.

```r
library(GenomicRanges)

# Define a region of interest
gr <- GRanges(seqnames="chr1", ranges=IRanges(start=1000000, end=1000500))

# Extract the sequence
region_seq <- getSeq(genome, gr)
```

### Extracting Upstream/Promoter Sequences
A common workflow involves extracting sequences upstream of gene transcription start sites (TSS).

```r
library(GenomicFeatures)

# Note: Ensure the TxDb matches the canFam2 assembly
txdb <- makeTranscriptDbFromUCSC("canFam2", "refGene")
gn <- sort(genes(txdb))

# Get 1000bp upstream
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" loading (via `mmap`), so they are memory efficient. However, extracting very large portions of the genome into memory as `DNAString` objects can still consume significant RAM.
- **Assembly Matching**: Always ensure your annotation sources (TxDb, BED files, etc.) are specifically for the `canFam2` assembly. Using coordinates from `canFam3` or `canFam4` will result in incorrect data or errors.
- **Motif Searching**: For genome-wide searches, use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package directly on the genome object or specific chromosomes.

## Reference documentation

- [BSgenome.Cfamiliaris.UCSC.canFam2](./references/reference_manual.md)