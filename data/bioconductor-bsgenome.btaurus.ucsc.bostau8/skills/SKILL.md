---
name: bioconductor-bsgenome.btaurus.ucsc.bostau8
description: This package provides the full genome sequences for Bos taurus based on the UCSC bosTau8 assembly for use in R. Use when user asks to access cow genome sequences, extract DNA sub-sequences, perform genome-wide motif searching, or retrieve upstream promoter sequences.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau8.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau8

name: bioconductor-bsgenome.btaurus.ucsc.bostau8
description: Provides full genome sequences for Bos taurus (Cow) based on the UCSC bosTau8 assembly (June 2014). Use this skill when an AI agent needs to access, analyze, or extract DNA sequences from the cow genome in R, perform genome-wide motif searching, or extract upstream promoter sequences using Bioconductor tools.

# bioconductor-bsgenome.btaurus.ucsc.bostau8

## Overview

The `BSgenome.Btaurus.UCSC.bosTau8` package is a data-rich Bioconductor annotation package containing the complete genome sequence for *Bos taurus* (Cow). It is based on the UCSC bosTau8 build. The sequences are stored as `Biostrings` objects, allowing for efficient sequence manipulation and analysis within the R environment.

## Installation and Loading

To use this package, it must be installed via `BiocManager` and then loaded into the R session:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Btaurus.UCSC.bosTau8")
library(BSgenome.Btaurus.UCSC.bosTau8)
```

## Basic Usage

### Accessing Genome Data

Once loaded, the genome object is available as `BSgenome.Btaurus.UCSC.bosTau8`. You can assign it to a shorter variable for convenience.

```r
genome <- BSgenome.Btaurus.UCSC.bosTau8

# View genome metadata
genome

# List available chromosomes/sequences
seqnames(genome)

# Get sequence lengths
seqlengths(genome)

# Access a specific chromosome (e.g., Chromosome 1)
genome$chr1
# or
genome[["chr1"]]
```

### Sequence Extraction

You can extract specific sub-sequences using the `getSeq` function from the `BSgenome` package:

```r
library(BSgenome)

# Extract a specific region from Chromosome 2
# Example: first 100 nucleotides
sub_seq <- getSeq(genome, "chr2", start=1, end=100)
```

## Common Workflows

### Extracting Upstream (Promoter) Sequences

A common task is extracting sequences upstream of known genes. This requires the `GenomicFeatures` package and a compatible `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb object for bosTau8 from UCSC
refGene_txdb <- makeTxDbFromUCSC(genome="bosTau8", table="refGene")

# Extract 1000bp upstream of all transcripts
up1000seqs <- extractUpstreamSeqs(genome, refGene_txdb, width=1000)
```

### Genome-wide Motif Searching

You can search for specific DNA motifs across the entire cow genome using functions from the `Biostrings` package.

```r
library(Biostrings)

# Define a motif (e.g., a restriction site or transcription factor binding site)
motif <- DNAString("GGTACC")

# Search for the motif on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# To search the entire genome, iterate through chromosomes or use vmatchPattern
```

## Tips and Best Practices

- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, working with many large chromosomes simultaneously can still consume significant RAM.
- **Compatibility**: Always ensure that your annotation objects (like `TxDb` or `GRanges`) are based on the `bosTau8` assembly. Using coordinates from different builds (e.g., bosTau9 or UMD3.1) will result in incorrect data.
- **Masks**: Check if you need masked sequences (e.g., for repeats). This specific package provides the standard sequences; masked versions are usually separate packages (e.g., `BSgenome.Btaurus.UCSC.bosTau8.masked`).

## Reference documentation

- [BSgenome.Btaurus.UCSC.bosTau8 Reference Manual](./references/reference_manual.md)