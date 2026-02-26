---
name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam3
description: This package provides the full genome sequence for Canis lupus familiaris based on the UCSC canFam3 assembly for use in the Bioconductor ecosystem. Use when user asks to access dog genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream and downstream sequences for dog genes.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Cfamiliaris.UCSC.canFam3.html
---


# bioconductor-bsgenome.cfamiliaris.ucsc.canfam3

name: bioconductor-bsgenome.cfamiliaris.ucsc.canfam3
description: Provides full genome sequences for Canis lupus familiaris (Dog) based on the UCSC canFam3 build (Sep. 2011). Use this skill when you need to access dog genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream/downstream sequences for dog genes using Bioconductor.

# bioconductor-bsgenome.cfamiliaris.ucsc.canfam3

## Overview
The `BSgenome.Cfamiliaris.UCSC.canFam3` package is a data provider package containing the complete genome sequence for the dog (*Canis lupus familiaris*). It is built upon the UCSC canFam3 assembly. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R/Bioconductor ecosystem.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Cfamiliaris.UCSC.canFam3")
library(BSgenome.Cfamiliaris.UCSC.canFam3)
```

## Basic Usage
The primary object is `BSgenome.Cfamiliaris.UCSC.canFam3`, which can be assigned to a shorter variable for convenience.

### Accessing Genome Metadata
```r
genome <- BSgenome.Cfamiliaris.UCSC.canFam3

# View sequence lengths
seqlengths(genome)

# View available chromosomes/sequences
seqnames(genome)
```

### Extracting Chromosome Sequences
You can access individual chromosomes using the `$` or `[[` operators. This returns a `DNAString` object.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Alternative access
chr2_seq <- genome[["chr2"]]
```

## Common Workflows

### Extracting Specific Genomic Ranges
Use the `getSeq()` function from the `BSgenome` package to extract sequences for specific coordinates defined in a `GRanges` object.

```r
library(GenomicRanges)

# Define a region of interest
my_range <- GRanges("chr1", IRanges(start=1000000, end=1000500))

# Extract sequence
my_seq <- getSeq(genome, my_range)
```

### Extracting Upstream/Promoter Sequences
To extract sequences upstream of genes, combine this package with a `TxDb` object (like `TxDb.Cfamiliaris.UCSC.canFam3.refGene`).

```r
library(GenomicFeatures)

# Example: Extracting 1000bp upstream of genes
# Note: Requires a compatible TxDb object
txdb <- makeTxDbFromUCSC(genome="canFam3", table="refGene")
gn <- genes(txdb)
up1000 <- flank(gn, width=1000)
up1000seqs <- getSeq(genome, up1000)
```

### Genome-Wide Motif Searching
You can search for specific DNA patterns across the entire dog genome using `matchPattern` or `vmatchPattern`.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("ATGCATGC")

# Search on a specific chromosome
matches_chr1 <- matchPattern(motif, genome$chr1)

# Search across the whole genome
all_matches <- vmatchPattern(motif, genome)
```

## Tips
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading the package does not load the entire genome into RAM, but accessing specific chromosomes will.
- **Consistency**: Always ensure that the `TxDb` or `GRanges` objects you use match the `canFam3` assembly to avoid coordinate mismatches.
- **Masks**: Check if you need masked sequences (e.g., for repeats). This package provides the standard sequences; masked versions are usually in separate `.masked` packages if available.

## Reference documentation
- [BSgenome.Cfamiliaris.UCSC.canFam3](./references/reference_manual.md)