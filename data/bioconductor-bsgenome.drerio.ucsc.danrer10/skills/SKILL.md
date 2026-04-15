---
name: bioconductor-bsgenome.drerio.ucsc.danrer10
description: This package provides the full genome sequences for Danio rerio (Zebrafish) based on the UCSC danRer10 assembly for use in R. Use when user asks to access Zebrafish genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream sequences for gene models.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer10.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer10

name: bioconductor-bsgenome.drerio.ucsc.danrer10
description: Provides the full genome sequences for Danio rerio (Zebrafish) as provided by UCSC (danRer10, Sep. 2014) and stored in Biostrings objects. Use this skill when you need to access Zebrafish genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream sequences for gene models in R.

# bioconductor-bsgenome.drerio.ucsc.danrer10

## Overview

The `BSgenome.Drerio.UCSC.danRer10` package is a data-rich Bioconductor annotation package containing the complete genome assembly for *Danio rerio* (Zebrafish) based on the UCSC danRer10 build. It allows researchers to programmatically access DNA sequences for all chromosomes and scaffolds using the `BSgenome` and `Biostrings` frameworks.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Drerio.UCSC.danRer10)
genome <- BSgenome.Drerio.UCSC.danRer10
```

### Inspecting Genome Metadata
You can check sequence lengths, chromosome names, and other metadata:

```r
# View sequence lengths
seqlengths(genome)

# View chromosome names
seqnames(genome)

# Get the organism name
organism(genome)
```

### Accessing Specific Sequences
Sequences can be accessed using standard list-style or dollar-sign notation.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for loops)
chr_name <- "chr10"
specific_seq <- genome[[chr_name]]

# View the first 100 bases of chromosome 1
head(genome$chr1, 100)
```

## Common Workflows

### Extracting Upstream Sequences
A common task is extracting promoter or upstream regions. This requires the `GenomicFeatures` package and a compatible `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb object for danRer10
refGene_txdb <- makeTxDbFromUCSC("danRer10", "refGene")

# Extract 1000bp upstream of all genes
up1000seqs <- extractUpstreamSeqs(genome, refGene_txdb, width=1000)
```

### Genome-wide Motif Searching
You can search for specific DNA motifs across the entire Zebrafish genome using `matchPattern` or `vmatchPattern` from the `Biostrings` package.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAA")

# Search on a specific chromosome
matches_chr1 <- matchPattern(motif, genome$chr1)

# Search across all chromosomes (returns a GRanges or MIndex object)
# Note: This can be memory intensive
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, extracting sequences for all chromosomes simultaneously can consume significant RAM.
- **Coordinate Consistency**: Always ensure that your annotation objects (like `TxDb` or `GRanges`) are based on the `danRer10` assembly to avoid coordinate mismatches.
- **Masks**: Check if you need masked sequences (e.g., for repeats). This specific package provides the standard sequences; for masked versions, look for `BSgenome.Drerio.UCSC.danRer10.masked`.

## Reference documentation

- [BSgenome.Drerio.UCSC.danRer10 Reference Manual](./references/reference_manual.md)