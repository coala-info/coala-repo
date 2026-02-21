---
name: bioconductor-bsgenome.dmelanogaster.ucsc.dm2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Dmelanogaster.UCSC.dm2.html
---

# bioconductor-bsgenome.dmelanogaster.ucsc.dm2

name: bioconductor-bsgenome.dmelanogaster.ucsc.dm2
description: Access and analyze the full genome sequences for Drosophila melanogaster (UCSC version dm2, April 2004). Use this skill when you need to retrieve DNA sequences, calculate chromosome lengths, or perform genome-wide motif searching and sequence extraction for the fruit fly dm2 assembly in R.

# bioconductor-bsgenome.dmelanogaster.ucsc.dm2

## Overview

The `BSgenome.Dmelanogaster.UCSC.dm2` package is a biotype-specific data package containing the complete genome sequence for *Drosophila melanogaster* as provided by UCSC (assembly dm2). It stores sequences as `Biostrings` objects, allowing for efficient manipulation and analysis within the Bioconductor ecosystem.

## Core Workflows

### Loading the Genome
To use the package, load the library and assign the genome object to a variable for easier access.

```r
library(BSgenome.Dmelanogaster.UCSC.dm2)
genome <- BSgenome.Dmelanogaster.UCSC.dm2
```

### Inspecting Sequence Information
You can check available chromosomes and their respective lengths.

```r
# List all sequences (chromosomes/scaffolds)
seqnames(genome)

# Get lengths of all sequences
seqlengths(genome)

# Access a specific chromosome (e.g., chr2L)
genome$chr2L
# OR
genome[["chr2L"]]
```

### Extracting Sequences
Use `getSeq()` to extract specific genomic regions. This is often used in conjunction with `GenomicRanges`.

```r
library(GenomicRanges)

# Define a region of interest
gr <- GRanges(seqnames="chr3L", ranges=IRanges(start=100, end=200))

# Extract the sequence
seq <- getSeq(genome, gr)
```

### Extracting Upstream/Promoter Sequences
While upstream sequences are no longer pre-packaged, they can be extracted by combining this package with a `TxDb` object.

```r
library(GenomicFeatures)

# Create a TxDb from UCSC for dm2
txdb <- makeTxDbFromUCSC(genome="dm2", table="refGene")

# Get gene coordinates and find 1000bp upstream
gn <- sort(genes(txdb))
up1000 <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

## Usage Tips
- **Coordinate Consistency**: Always ensure that your annotation objects (like `TxDb`) use the "dm2" build to match this genome package.
- **Memory Efficiency**: BSgenome objects use "on-disk" caching. Accessing a specific chromosome (e.g., `genome$chrX`) loads that sequence into memory.
- **Searching**: For motif searching, use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package on the individual chromosome objects.

## Reference documentation

- [BSgenome.Dmelanogaster.UCSC.dm2 Reference Manual](./references/reference_manual.md)