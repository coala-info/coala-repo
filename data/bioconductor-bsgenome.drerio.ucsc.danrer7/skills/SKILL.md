---
name: bioconductor-bsgenome.drerio.ucsc.danrer7
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Drerio.UCSC.danRer7.html
---

# bioconductor-bsgenome.drerio.ucsc.danrer7

## Overview

The `BSgenome.Drerio.UCSC.danRer7` package is a Bioconductor data package containing the complete genome sequence for *Danio rerio* (Zebrafish). It uses the UCSC danRer7 assembly. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the Bioconductor ecosystem.

## Basic Usage

### Loading the Genome
To use the package, load it into your R session:

```r
library(BSgenome.Drerio.UCSC.danRer7)
genome <- BSgenome.Drerio.UCSC.danRer7
```

### Exploring Genome Metadata
You can check available chromosomes and their respective lengths:

```r
# List all sequences (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome
genome$chr1  # or genome[["chr1"]]
```

### Extracting Sequences
Use `getSeq()` from the `BSgenome` package to extract specific genomic regions.

```r
# Extract a specific range from chromosome 1
library(Biostrings)
rng <- GRanges("chr1", IRanges(start=1000, end=2000))
seq <- getSeq(genome, rng)
```

## Common Workflows

### Extracting Upstream (Promoter) Sequences
Since version 3.0, upstream sequences are no longer pre-packaged. You can generate them using `GenomicFeatures`:

```r
library(GenomicFeatures)

# Create a TxDb object for danRer7
txdb <- makeTxDbFromUCSC(genome="danRer7", table="refGene")

# Get gene coordinates and flank them to get 1000bp upstream
gn <- sort(genes(txdb))
up1000 <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire zebrafish genome:

```r
# Example: Searching for a specific hexamer
pattern <- "GAATTC"
match_list <- vmatchPattern(pattern, genome)

# View matches on a specific chromosome
match_list$chr1
```

## Tips and Best Practices
- **Coordinate Consistency**: Always ensure that your `TxDb` or `GRanges` objects are based on the `danRer7` assembly to avoid coordinate mismatches.
- **Memory Management**: BSgenome objects use "on-disk" loading (via `mmap`), so they are memory efficient. However, extracting very large numbers of sequences into memory (e.g., `getSeq` on all genes) can still consume significant RAM.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) by inspecting `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Drerio.UCSC.danRer7](./references/reference_manual.md)