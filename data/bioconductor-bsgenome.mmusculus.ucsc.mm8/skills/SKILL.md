---
name: bioconductor-bsgenome.mmusculus.ucsc.mm8
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmusculus.UCSC.mm8.html
---

# bioconductor-bsgenome.mmusculus.ucsc.mm8

name: bioconductor-bsgenome.mmusculus.ucsc.mm8
description: Provides full genome sequences for Mus musculus (Mouse) based on the UCSC mm8 build (Feb. 2006). Use this skill when you need to access mouse genomic sequences, retrieve specific chromosome data, extract upstream promoter regions, or perform genome-wide motif searching using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.mmusculus.ucsc.mm8

## Overview

The `BSgenome.Mmusculus.UCSC.mm8` package is a data-rich Bioconductor annotation package containing the complete genome sequence for the Mus musculus (mouse) mm8 assembly. It stores sequences as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Mmusculus.UCSC.mm8")
library(BSgenome.Mmusculus.UCSC.mm8)
```

## Basic Usage

### Accessing Genome Metadata
Once loaded, you can inspect the genome object to see available sequences and their lengths.

```r
genome <- BSgenome.Mmusculus.UCSC.mm8
genome
seqlengths(genome)
seqnames(genome)
```

### Retrieving Chromosome Sequences
Individual chromosomes can be accessed using the `$` operator or double brackets.

```r
# Access chromosome 1
chr1_seq <- genome$chr1 

# Access via string name
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 1000 bp of chr3)
sub_seq <- subseq(genome$chr3, start=1, end=1000)
```

## Common Workflows

### Extracting Upstream (Promoter) Sequences
To extract sequences upstream of genes, combine this package with `GenomicFeatures`.

```r
library(GenomicFeatures)

# Load a compatible TranscriptDb (ensure it matches mm8)
txdb <- makeTxDbFromUCSC(genome="mm8", table="knownGene")

# Get gene coordinates
gn <- sort(genes(txdb))

# Define upstream regions (e.g., 1000bp)
up1000 <- flank(gn, width=1000)

# Extract the actual sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern` or `vmatchPattern` from the `Biostrings` package.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAA")

# Search on a specific chromosome
matches_chr1 <- matchPattern(motif, genome$chr1)

# Search across all chromosomes
all_matches <- vmatchPattern(motif, genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" caching. Loading the package does not load the entire genome into RAM, but accessing specific chromosomes (e.g., `genome$chr1`) will load that sequence into memory.
- **Version Consistency**: Always ensure that your annotation objects (like `TxDb` or `GRanges`) are based on the **mm8** assembly to avoid coordinate mismatches.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Mmusculus.UCSC.mm8 Reference Manual](./references/reference_manual.md)