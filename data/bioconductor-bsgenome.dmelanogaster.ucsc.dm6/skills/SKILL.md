---
name: bioconductor-bsgenome.dmelanogaster.ucsc.dm6
description: This package provides the complete genome sequence for Drosophila melanogaster based on the UCSC dm6 assembly for efficient sequence manipulation and analysis. Use when user asks to load the fly genome, extract upstream sequences, or perform genome-wide motif searching.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Dmelanogaster.UCSC.dm6.html
---


# bioconductor-bsgenome.dmelanogaster.ucsc.dm6

## Overview

The `BSgenome.Dmelanogaster.UCSC.dm6` package is a data-centric Bioconductor package containing the complete genome sequence for *Drosophila melanogaster*. It stores the sequence data in `Biostrings` objects, allowing for efficient sequence manipulation and analysis. This package is typically used in conjunction with `BSgenome`, `Biostrings`, and `GenomicFeatures` for genomic workflows.

## Key Workflows and Usage

### Loading the Genome
To use the genome data, you must load the package and assign the genome object to a variable for easier access.

```r
library(BSgenome.Dmelanogaster.UCSC.dm6)
genome <- BSgenome.Dmelanogaster.UCSC.dm6
```

### Exploring Genome Metadata
You can inspect the sequence names and lengths to understand the assembly structure.

```r
# List all chromosome/scaffold names
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., chr2L)
genome$chr2L 
# or
genome[["chr2L"]]
```

### Extracting Upstream Sequences
A common task is extracting promoter or upstream regions. This requires a `TxDb` object (gene model) that matches the dm6 assembly.

```r
library(GenomicFeatures)

# Create a TxDb object from UCSC for dm6
txdb <- makeTxDbFromUCSC("dm6", tablename="refGene")

# Extract 1000bp upstream of all genes
up1000seqs <- extractUpstreamSeqs(genome, txdb, width=1000)
```

### Genome-wide Motif Searching
You can use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific DNA motifs across the entire fly genome.

```r
library(Biostrings)

# Define a motif
motif <- "TATAAT"

# Search on a specific chromosome
matchPattern(motif, genome$chr3L)

# For genome-wide searching, refer to the BSgenome "GenomeSearching" vignette
# vignette("GenomeSearching", package="BSgenome")
```

## Tips and Best Practices
- **Compatibility**: Always ensure that your annotation objects (like `TxDb` or `GRanges`) use the "dm6" naming convention to match this package.
- **Memory Efficiency**: BSgenome objects use "on-disk" caching via the `2bit` format, meaning they are memory efficient. However, extracting very large numbers of sequences into memory (like `up1000seqs`) can consume significant RAM.
- **Coordinate Systems**: UCSC uses 1-based closed coordinates in R/Bioconductor, consistent with other `GenomicRanges` objects.

## Reference documentation
- [BSgenome.Dmelanogaster.UCSC.dm6 Reference Manual](./references/reference_manual.md)