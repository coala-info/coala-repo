---
name: bioconductor-bsgenome.celegans.ucsc.ce2
description: This package provides the full genome sequences for Caenorhabditis elegans based on the UCSC ce2 build. Use when user asks to access genomic sequences, check chromosome lengths, extract specific DNA ranges, or perform genome-wide motif searching for the ce2 version of the C. elegans genome.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Celegans.UCSC.ce2.html
---


# bioconductor-bsgenome.celegans.ucsc.ce2

name: bioconductor-bsgenome.celegans.ucsc.ce2
description: Provides full genome sequences for Caenorhabditis elegans (Worm) based on the UCSC ce2 build (March 2004). Use this skill when you need to access genomic sequences, chromosome lengths, or perform sequence analysis (like motif searching or extracting upstream regions) specifically for the ce2 version of the C. elegans genome in R.

# bioconductor-bsgenome.celegans.ucsc.ce2

## Overview

The `BSgenome.Celegans.UCSC.ce2` package is a data annotation package containing the complete genome sequence for *Caenorhabditis elegans* as provided by UCSC (version ce2). The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the Bioconductor ecosystem.

## Loading and Inspecting the Genome

To use the package, first load it into your R session. The genome object is named identically to the package.

```R
library(BSgenome.Celegans.UCSC.ce2)

# Assign to a shorter variable for convenience
genome <- BSgenome.Celegans.UCSC.ce2

# List available chromosomes/sequences
seqnames(genome)

# Check chromosome lengths
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome I)
genome$chrI
# or
genome[["chrI"]]
```

## Common Workflows

### Extracting Sequences
You can extract specific genomic ranges using the `getSeq()` function from the `BSgenome` package.

```R
# Extract a specific coordinate range from Chromosome II
my_range <- GRanges("chrII", IRanges(start=100, end=200))
seqs <- getSeq(genome, my_range)
```

### Extracting Upstream Sequences (Promoters)
While upstream sequences are no longer bundled directly in the package, they can be extracted by combining this package with `GenomicFeatures`.

```R
library(GenomicFeatures)

# Create a TxDb object for ce2 (requires internet connection or local cache)
txdb <- makeTxDbFromUCSC(genome="ce2", table="refGene")

# Get gene coordinates
gn <- sort(genes(txdb))

# Define 1000bp upstream regions
up1000_coords <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000_seqs <- getSeq(genome, up1000_coords)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern`.

```R
# Search for a specific motif on Chromosome V
motif <- "TATAAT"
matches <- matchPattern(motif, genome$chrV)

# To search the whole genome, use a loop or lapply across seqnames
```

## Usage Tips
- **Build Consistency**: Always ensure that your annotation objects (like `TxDb` or `GRanges`) are based on the `ce2` build to avoid coordinate mismatches.
- **Memory Efficiency**: `BSgenome` objects use "on-disk" caching. Loading the package does not immediately load all sequences into RAM; they are loaded as you access specific chromosomes.
- **Coordinate System**: UCSC uses 1-based indexing in R/Bioconductor contexts for these objects.

## Reference documentation

- [BSgenome.Celegans.UCSC.ce2 Reference Manual](./references/reference_manual.md)