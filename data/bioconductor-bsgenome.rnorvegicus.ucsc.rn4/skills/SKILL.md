---
name: bioconductor-bsgenome.rnorvegicus.ucsc.rn4
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Rnorvegicus.UCSC.rn4.html
---

# bioconductor-bsgenome.rnorvegicus.ucsc.rn4

name: bioconductor-bsgenome.rnorvegicus.ucsc.rn4
description: Provides full genome sequences for Rattus norvegicus (Rat) based on the UCSC rn4 assembly (Nov. 2004). Use this skill when you need to access genomic sequences, extract specific chromosome data, or perform genome-wide motif searching for the rn4 rat genome in R.

# bioconductor-bsgenome.rnorvegicus.ucsc.rn4

## Overview

The `BSgenome.Rnorvegicus.UCSC.rn4` package is a Bioconductor data package containing the complete genome sequence for the rat (*Rattus norvegicus*). The data is stored as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Installation and Loading

To use this package, it must be installed via `BiocManager`:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("BSgenome.Rnorvegicus.UCSC.rn4")

# Load the package
library(BSgenome.Rnorvegicus.UCSC.rn4)
```

## Basic Usage

### Accessing the Genome Object
The main object is named after the package:

```r
genome <- BSgenome.Rnorvegicus.UCSC.rn4
genome
```

### Inspecting Sequences
You can check chromosome names and lengths:

```r
seqnames(genome)
seqlengths(genome)
```

### Extracting Specific Chromosomes
Access individual chromosomes using the `$` or `[[` operator:

```r
chr1_seq <- genome$chr1
# Or
chr1_seq <- genome[["chr1"]]
```

## Common Workflows

### Extracting Subsequences
Use `getSeq()` to extract specific genomic regions. This is often paired with a `GRanges` object.

```r
library(GenomicRanges)
my_region <- GRanges("chr1", IRanges(start=1000, end=2000))
seqs <- getSeq(genome, my_region)
```

### Extracting Upstream/Promoter Sequences
While older versions included pre-computed upstream sequences, the current standard is to extract them using a `TxDb` object:

```r
library(TxDb.Rnorvegicus.UCSC.rn4.ensGene)
txdb <- TxDb.Rnorvegicus.UCSC.rn4.ensGene

# Get gene coordinates
gn <- genes(txdb)

# Define 1000bp upstream (flanking)
up1000 <- flank(gn, width=1000)

# Extract sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
You can search for specific DNA patterns across the entire genome using `matchPattern` from the `Biostrings` package:

```r
library(Biostrings)
pattern <- "TATA"
# Search on a specific chromosome
matchPattern(pattern, genome$chr1)
```

## Tips
- **Memory Management**: `BSgenome` objects use "lazy loading," meaning sequences are only loaded into memory when accessed.
- **Compatibility**: Always ensure your `TxDb` or `EnsDb` annotation package matches the genome assembly (`rn4`). Using `rn5` or `rn6` annotations with this package will result in incorrect coordinate mapping.
- **Masks**: Check if the genome contains masked sequences (e.g., for repeats) by inspecting the object metadata.

## Reference documentation
- [BSgenome.Rnorvegicus.UCSC.rn4](./references/reference_manual.md)