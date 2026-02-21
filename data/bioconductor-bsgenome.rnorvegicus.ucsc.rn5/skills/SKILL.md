---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn5
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn5.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn5

name: bioconductor-bsgenome.rnorvegicus.ucsc.rn5
description: Provides full genome sequences for Rattus norvegicus (Rat) based on the UCSC rn5 assembly (March 2012). Use this skill when you need to access rat genomic sequences, extract specific chromosome data, or perform genome-wide sequence analysis (like motif searching or flanking sequence extraction) using Bioconductor's BSgenome framework.

# bioconductor-bsgenome.rnorvegicus.ucsc.rn5

## Overview
The `BSgenome.Rnorvegicus.UCSC.rn5` package is a data-only Bioconductor annotation package containing the complete genome sequence for the rat (*Rattus norvegicus*). The sequences are stored as `Biostrings` objects, allowing for efficient memory management and high-speed sequence operations. This package is specifically for the **rn5** assembly version.

## Installation and Loading
To use this package, it must be installed via `BiocManager` and loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Rnorvegicus.UCSC.rn5")
library(BSgenome.Rnorvegicus.UCSC.rn5)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package:

```r
genome <- BSgenome.Rnorvegicus.UCSC.rn5
genome
```

### Inspecting Sequence Information
You can check available chromosomes and their lengths:

```r
# List all sequences (chromosomes, scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
genome$chr1
# OR
genome[["chr1"]]
```

## Common Workflows

### Extracting Specific Sequences
Use `getSeq()` to extract specific genomic ranges. This is often used in conjunction with `GenomicRanges`.

```r
library(GenomicRanges)

# Define a region of interest
my_range <- GRanges("chr1", IRanges(start=1000000, end=1000500))

# Extract the DNA sequence
dna_seq <- getSeq(genome, my_range)
```

### Extracting Upstream/Promoter Sequences
Since version 3.0, upstream sequences are no longer pre-packaged. You must extract them using a corresponding `TxDb` package:

```r
library(TxDb.Rnorvegicus.UCSC.rn5.refGene)
txdb <- TxDb.Rnorvegicus.UCSC.rn5.refGene

# Get gene coordinates
gn <- genes(txdb)

# Get 1000bp upstream (promoters)
up1000_coords <- flank(gn, width=1000)
up1000_seqs <- getSeq(genome, up1000_coords)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome:

```r
# Search for a specific hexamer on chr1
matchPattern("GAATTC", genome$chr1)

# For genome-wide searches, iterate through chromosomes or use vmatchPattern
```

## Tips and Best Practices
- **Assembly Matching**: Always ensure your annotation objects (like `TxDb` or `OrgDb`) match the **rn5** assembly. Using coordinates from rn6 or rn7 with this package will result in incorrect data.
- **Memory Efficiency**: Accessing `genome$chr1` loads that chromosome into memory. If working with many chromosomes, consider using `getSeq()` with a `GRanges` object to load only the necessary segments.
- **Standard Chromosome Names**: This package uses UCSC naming conventions (e.g., "chr1", "chrM").

## Reference documentation
- [BSgenome.Rnorvegicus.UCSC.rn5 Reference Manual](./references/reference_manual.md)