---
name: bioconductor-bsgenome.hsapiens.ucsc.hg18
description: This package provides the complete genome sequences for the hg18 build of the human genome as Biostrings objects. Use when user asks to load hg18 genome sequences, extract DNA sequences for specific genomic coordinates, or perform genome-wide motif searching on the hg18 assembly.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Hsapiens.UCSC.hg18.html
---


# bioconductor-bsgenome.hsapiens.ucsc.hg18

## Overview

The `BSgenome.Hsapiens.UCSC.hg18` package is a Bioconductor data package containing the complete genome sequences for the hg18 build of the human genome. It stores sequences as `Biostrings` objects, allowing for efficient memory usage and integration with other Bioconductor packages like `GenomicRanges` and `GenomicFeatures`.

## Basic Usage

### Loading the Genome
To use the package, you must first load it into your R session.

```r
library(BSgenome.Hsapiens.UCSC.hg18)
genome <- BSgenome.Hsapiens.UCSC.hg18
```

### Inspecting Genome Metadata
You can check sequence names, lengths, and specific chromosome information.

```r
# List all chromosome/sequence names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1 
# or
chr1_seq <- genome[["chr1"]]
```

## Common Workflows

### Extracting Specific Sequences
Use `getSeq()` to extract sequences for specific genomic coordinates defined by a `GRanges` object.

```r
library(GenomicRanges)
my_range <- GRanges("chr1", IRanges(start=1000000, end=1000500))
seqs <- getSeq(genome, my_range)
```

### Extracting Upstream/Promoter Sequences
To extract upstream sequences (e.g., 1000bp upstream of genes), pair this package with a corresponding `TxDb` package.

```r
library(TxDb.Hsapiens.UCSC.hg18.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg18.knownGene

# Get gene coordinates
gn <- genes(txdb)

# Define 1000bp upstream regions
up1000_coords <- flank(gn, width=1000)

# Extract sequences
up1000_seqs <- getSeq(genome, up1000_coords)
```

### Genome-Wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern` or `vmatchPattern` from the `Biostrings` package.

```r
library(Biostrings)
pattern <- "TATAWAW" # Example TATA box motif
matches <- vmatchPattern(pattern, genome)
```

## Implementation Tips
- **Coordinate Consistency**: Always ensure that the `TxDb` or `GRanges` object you are using is based on the `hg18` assembly. Using `hg19` or `hg38` coordinates with this package will result in incorrect data or errors.
- **Memory Efficiency**: The package uses "masked" sequences or pointers to disk where possible, but loading multiple large chromosomes into memory as `DNAString` objects can be resource-intensive.
- **Sequence Naming**: UCSC naming conventions are used (e.g., "chr1", "chrM", "chrX").

## Reference documentation
- [BSgenome.Hsapiens.UCSC.hg18](./references/reference_manual.md)