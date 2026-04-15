---
name: bioconductor-bsgenome.btaurus.ucsc.bostau3
description: This package provides the full genome sequences for Bos taurus based on the UCSC bosTau3 assembly. Use when user asks to access bovine genomic sequences, retrieve chromosome lengths, extract specific genomic regions, or perform genome-wide motif searching in R.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau3.html
---

# bioconductor-bsgenome.btaurus.ucsc.bostau3

name: bioconductor-bsgenome.btaurus.ucsc.bostau3
description: Provides full genome sequences for Bos taurus (Cow) based on the UCSC bosTau3 build (Aug. 2006). Use this skill when you need to access bovine genomic sequences, retrieve chromosome lengths, extract specific genomic regions (like upstream promoters), or perform genome-wide motif searching in R using Bioconductor.

# bioconductor-bsgenome.btaurus.ucsc.bostau3

## Overview

The `BSgenome.Btaurus.UCSC.bosTau3` package is a data-only annotation package containing the full genome sequence for the cow (*Bos taurus*). It is built upon the `BSgenome` infrastructure, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Loading and Basic Usage

To use the genome data, load the package and assign the genome object to a variable for easier access:

```r
library(BSgenome.Btaurus.UCSC.bosTau3)

# Reference the genome object
genome <- BSgenome.Btaurus.UCSC.bosTau3

# View metadata and available sequences
genome

# Get chromosome lengths
seqlengths(genome)

# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1 
# or
chr1_seq <- genome[["chr1"]]
```

## Common Workflows

### Extracting Specific Sequences
Use `getSeq()` to extract sequences for specific genomic ranges. This is the preferred method for handling multiple regions simultaneously.

```r
library(GenomicRanges)

# Define regions of interest
my_regions <- GRanges(seqnames = c("chr1", "chr2"),
                      ranges = IRanges(start = c(100, 500), end = c(200, 600)))

# Extract sequences
extracted_seqs <- getSeq(genome, my_regions)
```

### Extracting Upstream (Promoter) Sequences
You can combine this package with `GenomicFeatures` to extract sequences upstream of annotated genes.

```r
library(GenomicFeatures)

# Create a TxDb object for bosTau3 (ensure the build matches!)
txdb <- makeTxDbFromUCSC(genome = "bosTau3", tablename = "refGene")

# Get gene coordinates
gn <- sort(genes(txdb))

# Get 1000bp upstream of the TSS
up1000 <- flank(gn, width = 1000)

# Extract the actual DNA sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
To search for a specific DNA pattern across the entire bovine genome:

```r
library(Biostrings)

# Define a motif
motif <- DNAString("TATAAT")

# Search on a specific chromosome
matches <- matchPattern(motif, genome$chr1)

# For genome-wide searches, iterate through chromosomes or use vmatchPattern
```

## Implementation Tips
- **Build Consistency**: Always ensure that your annotation objects (TxDb, OrgDb, or GRanges) are based on the `bosTau3` assembly. Using coordinates from `bosTau8` or `ARS-UCD1.2` with this package will result in incorrect data.
- **Memory Management**: BSgenome objects use "lazy loading," meaning sequences are only loaded into memory when accessed. However, extracting very large regions or the entire genome into a single object can consume significant RAM.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) by inspecting `masks(genome$chr1)`.

## Reference documentation

- [BSgenome.Btaurus.UCSC.bosTau3 Reference Manual](./references/reference_manual.md)