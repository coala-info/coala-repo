---
name: bioconductor-bsgenome.drerio.ucsc.danrer6
description: This package provides the full genome sequences for Danio rerio based on the UCSC danRer6 assembly for use in R. Use when user asks to access Zebrafish genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream sequences for gene models.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer6.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer6

name: bioconductor-bsgenome.drerio.ucsc.danrer6
description: Provides full genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer6 (Dec. 2008) assembly. Use this skill when you need to access Zebrafish genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream sequences for gene models in R.

# bioconductor-bsgenome.drerio.ucsc.danrer6

## Overview

The `BSgenome.Drerio.UCSC.danRer6` package is a Bioconductor data package containing the complete genome sequence for *Danio rerio* (Zebrafish) as provided by UCSC (assembly danRer6). It stores sequences as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the Bioconductor ecosystem.

## Loading and Basic Usage

To use the genome data, load the package and assign the genome object:

```r
library(BSgenome.Drerio.UCSC.danRer6)

# Access the genome object
genome <- BSgenome.Drerio.UCSC.danRer6

# List available sequences (chromosomes/scaffolds)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (e.g., chromosome 1)
chr1_seq <- genome$chr1 
# or
chr1_seq <- genome[["chr1"]]
```

## Common Workflows

### Extracting Genomic Ranges
Use `getSeq()` from the `BSgenome` package to extract specific coordinates.

```r
library(GenomicRanges)

# Define a region of interest
gr <- GRanges("chr1", IRanges(start=1000, end=2000))

# Extract sequence
my_seq <- getSeq(genome, gr)
```

### Extracting Upstream Sequences
To get promoter or upstream regions, combine this package with a `TxDb` object (e.g., from `GenomicFeatures`).

```r
library(GenomicFeatures)

# Create or load a Transcript Database for danRer6
txdb <- makeTxDbFromUCSC(genome="danRer6", table="refGene")

# Get gene coordinates
gn <- genes(txdb)

# Get 1000bp upstream of the TSS
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire Zebrafish genome.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# For genome-wide searches, iterate through seqnames or use vmatchPattern
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, extracting very large regions or many sequences simultaneously can consume significant RAM.
- **Assembly Consistency**: Always ensure that your annotation resources (like `TxDb` or `EnsDb` objects) match the `danRer6` assembly version to avoid coordinate mismatches.
- **Masking**: Check if you need masked sequences (e.g., for repeats). This specific package provides the standard sequences; masked versions are usually separate BSgenome packages if available.

## Reference documentation

- [BSgenome.Drerio.UCSC.danRer6 Reference Manual](./references/reference_manual.md)