---
name: bioconductor-bsgenome.hsapiens.ucsc.hs1
description: This package provides the full genomic sequences for the human T2T-CHM13v2.0 assembly as a Bioconductor data object. Use when user asks to access the hs1 human genome, extract DNA sequences from specific genomic coordinates, or perform sequence analysis on the Telomere-to-Telomere assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hs1.html
---

# bioconductor-bsgenome.hsapiens.ucsc.hs1

name: bioconductor-bsgenome.hsapiens.ucsc.hs1
description: Provides the full genomic sequences for Homo sapiens (human) based on the UCSC hs1 (T2T-CHM13v2.0) assembly. Use this skill when you need to access, analyze, or manipulate the complete DNA sequences of the human genome in R, specifically for the Telomere-to-Telomere (T2T) assembly.

# bioconductor-bsgenome.hsapiens.ucsc.hs1

## Overview

The `BSgenome.Hsapiens.UCSC.hs1` package is a Bioconductor data package containing the complete genome sequence for *Homo sapiens* as provided by UCSC (assembly hs1, which corresponds to the T2T-CHM13v2.0 assembly, GenBank GCA_009914755.4). The sequences are stored as `DNAString` objects, allowing for efficient sequence analysis and integration with other Bioconductor tools like `GenomicRanges` and `Biostrings`.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Hsapiens.UCSC.hs1")
library(BSgenome.Hsapiens.UCSC.hs1)
```

## Basic Usage

### Accessing the Genome Object
The main object is named the same as the package. You can assign it to a shorter variable for convenience.

```r
genome <- BSgenome.Hsapiens.UCSC.hs1
genome
```

### Inspecting Sequence Information
You can check the available chromosomes (sequences) and their lengths:

```r
# List all sequence names (chromosomes)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# View the first few sequence lengths
head(seqlengths(genome))
```

### Extracting Specific Sequences
Individual chromosomes can be accessed using the `$` operator or `[[` operator. This returns a `DNAString` object.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access using string index
chrX_seq <- genome[["chrX"]]

# View a snippet of the sequence
print(chr1_seq)
```

## Common Workflows

### Extracting Subsequences
Use the `getSeq` function from the `BSgenome` package to extract specific genomic regions. This is more memory-efficient than loading entire chromosomes.

```r
library(BSgenome)

# Extract a specific range from chromosome 1
# Coordinates: chr1, positions 1,000,000 to 1,000,050
sub_seq <- getSeq(genome, "chr1", start=1000000, end=1000050)
```

### Working with GRanges
You can pass a `GRanges` object to `getSeq` to extract multiple regions at once.

```r
library(GenomicRanges)

# Define regions of interest
regions <- GRanges(seqnames = c("chr1", "chr2"),
                   ranges = IRanges(start = c(500, 1000), end = c(600, 1100)))

# Extract sequences for these regions
feature_seqs <- getSeq(genome, regions)
```

### Genome-wide Motif Searching
To find specific DNA patterns across the entire genome, use functions from the `Biostrings` package in combination with the genome object.

```r
library(Biostrings)

# Search for a specific motif on chr22
motif <- "TTAGGG" # Telomeric repeat
matches <- matchPattern(motif, genome$chr22)
```

## Tips
- **Memory Management**: The hs1 assembly is large. Use `getSeq()` with specific coordinates or `GRanges` rather than loading entire chromosomes into memory if you only need small regions.
- **Assembly Version**: Ensure your coordinates (BED files, etc.) are specifically for the **hs1 / T2T-CHM13v2.0** assembly. Using coordinates from GRCh38/hg38 will result in incorrect data retrieval.
- **Coordinate System**: Like most Bioconductor objects, this package uses a 1-based coordinate system.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)