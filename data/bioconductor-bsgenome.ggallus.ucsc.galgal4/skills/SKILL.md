---
name: bioconductor-bsgenome.ggallus.ucsc.galgal4
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Ggallus.UCSC.galGal4.html
---

# bioconductor-bsgenome.ggallus.ucsc.galgal4

name: bioconductor-bsgenome.ggallus.ucsc.galgal4
description: Provides full genome sequences for Gallus gallus (Chicken) based on the UCSC galGal4 (Nov. 2011) assembly. Use this skill when you need to access chicken genomic sequences, extract specific chromosome data, perform genome-wide motif searching, or retrieve upstream/downstream sequences for chicken genes using Bioconductor.

# bioconductor-bsgenome.ggallus.ucsc.galgal4

## Overview

The `BSgenome.Ggallus.UCSC.galGal4` package is a data-driven Bioconductor package containing the complete genome sequence for *Gallus gallus* (Chicken). It provides the UCSC galGal4 assembly as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Basic Usage

### Loading the Genome
To use the package, load it into your R session. The genome object is named identically to the package.

```r
library(BSgenome.Ggallus.UCSC.galGal4)
genome <- BSgenome.Ggallus.UCSC.galGal4
```

### Exploring Genome Metadata
You can check sequence names, lengths, and other metadata:

```r
# List all chromosomes/sequences
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Check the organism and provider
organism(genome)
provider(genome)
```

### Accessing Specific Sequences
Access individual chromosomes using the `$` operator or double brackets.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string (useful for loops)
chr_name <- "chr2"
chr2_seq <- genome[[chr_name]]
```

## Common Workflows

### Extracting Subsequences
Use `getSeq()` to extract specific genomic regions. This is the preferred method for working with `GRanges` objects.

```r
library(GenomicRanges)

# Define a region of interest
roi <- GRanges(seqnames = "chr1", ranges = IRanges(start = 1000, end = 2000))

# Extract sequence
sub_seq <- getSeq(genome, roi)
```

### Extracting Upstream Promoter Sequences
Since version 3.0, upstream sequences are not pre-packaged. You must extract them using a `TxDb` object that matches the galGal4 assembly.

```r
library(GenomicFeatures)

# Create or load a TxDb for galGal4
txdb <- makeTxDbFromUCSC(genome = "galGal4", table = "refGene")

# Get gene coordinates
gn <- genes(txdb)

# Get 1000bp upstream of the TSS
up1000_coords <- flank(gn, width = 1000)
up1000_seqs <- getSeq(genome, up1000_coords)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire chicken genome.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# For genome-wide searches, iterate over seqnames or use vmatchPattern
```

## Tips and Best Practices
- **Memory Management**: `BSgenome` objects use "on-disk" caching. Accessing `genome$chr1` loads that specific chromosome into memory.
- **Coordinate Consistency**: Always ensure your annotation data (e.g., `TxDb` or `GRanges`) uses the "galGal4" assembly string to match this package.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) using `masks(genome$chr1)`.

## Reference documentation
- [BSgenome.Ggallus.UCSC.galGal4 Reference Manual](./references/reference_manual.md)