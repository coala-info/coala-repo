---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac2
description: This package provides the full genome sequences for the Rhesus macaque based on the UCSC rheMac2 assembly. Use when user asks to access Rhesus monkey DNA sequences, extract genomic ranges, search for motifs, or retrieve promoter sequences using Bioconductor.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac2.html
---


# bioconductor-bsgenome.mmulatta.ucsc.rhemac2

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac2
description: Provides full genome sequences for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac2 assembly (Jan. 2006). Use this skill when an AI agent needs to access, analyze, or extract DNA sequences from the Rhesus macaque genome in R, specifically for tasks involving genomic coordinates, motif searching, or upstream sequence extraction using Bioconductor.

## Overview

The `BSgenome.Mmulatta.UCSC.rheMac2` package is a data-rich Bioconductor annotation package containing the complete genome sequence for the Rhesus macaque (*Macaca mulatta*). The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment. This package is essential for researchers working with Rhesus genomic data who require a standardized reference genome.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Mmulatta.UCSC.rheMac2")
library(BSgenome.Mmulatta.UCSC.rheMac2)
```

## Basic Usage

### Accessing Genome Metadata
Once loaded, the genome object is available under the name `BSgenome.Mmulatta.UCSC.rheMac2`. You can also use the alias `Mmulatta`.

```r
# View genome object details
genome <- BSgenome.Mmulatta.UCSC.rheMac2
genome

# List sequence names (chromosomes)
seqnames(genome)

# Get sequence lengths
seqlengths(genome)
```

### Extracting Sequences
You can extract specific chromosomes or sub-sequences using standard R indexing or the `getSeq` function.

```r
# Access a specific chromosome (e.g., Chromosome 1)
chr1_seq <- genome$chr1 
# Alternatively: genome[["chr1"]]

# Extract a specific genomic range
library(GenomicRanges)
my_range <- GRanges("chr1", IRanges(start=1000, end=2000))
getSeq(genome, my_range)
```

## Common Workflows

### Extracting Upstream (Promoter) Sequences
Since version 3.0, upstream sequences are no longer pre-bundled. They must be extracted manually using a `TxDb` object that matches the `rheMac2` assembly.

```r
library(GenomicFeatures)

# Create a TranscriptDb from UCSC for rheMac2
txdb <- makeTxDbFromUCSC(genome="rheMac2", table="refGene")

# Get gene coordinates and find 1000bp upstream
gn <- genes(txdb)
up1000 <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find specific motifs across the genome.

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAA")

# Search on a specific chromosome
matchPattern(motif, genome$chr1)

# For genome-wide searches, iterate over seqnames or use specialized BSgenome functions
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "lazy loading," but extracting very large sequences into memory can still be intensive. Work with `GRanges` to extract only the regions of interest.
- **Assembly Matching**: Always ensure that your annotation data (TxDb, BED files, etc.) matches the `rheMac2` assembly version to avoid coordinate shifts.
- **Provider**: This package specifically uses the UCSC naming convention (e.g., "chr1", "chrM").

## Reference documentation
- [BSgenome.Mmulatta.UCSC.rheMac2 Reference Manual](./references/reference_manual.md)