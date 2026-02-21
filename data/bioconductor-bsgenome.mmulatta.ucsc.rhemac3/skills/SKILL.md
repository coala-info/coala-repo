---
name: bioconductor-bsgenome.mmulatta.ucsc.rhemac3
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Mmulatta.UCSC.rheMac3.html
---

# bioconductor-bsgenome.mmulatta.ucsc.rhemac3

name: bioconductor-bsgenome.mmulatta.ucsc.rhemac3
description: Provides full genome sequences for Macaca mulatta (Rhesus monkey) based on the UCSC rheMac3 build (Oct. 2010). Use this skill when you need to access genomic sequences, calculate sequence statistics, extract promoter/upstream regions, or perform genome-wide motif searching for the Rhesus macaque in R.

# bioconductor-bsgenome.mmulatta.ucsc.rhemac3

## Overview

The `BSgenome.Mmulatta.UCSC.rheMac3` package is a data-driven Bioconductor package containing the complete genome sequence for *Macaca mulatta*. It stores the sequence data as `Biostrings` objects, allowing for efficient memory management and high-performance sequence analysis. This package is essential for bioinformatics workflows involving Rhesus macaque genomic data, such as peak annotation, sequence extraction, and comparative genomics.

## Getting Started

To use this package, it must be loaded into the R session. The genome object is named identically to the package.

```r
library(BSgenome.Mmulatta.UCSC.rheMac3)

# Assign to a shorter variable for convenience
genome <- BSgenome.Mmulatta.UCSC.rheMac3
genome
```

## Common Workflows

### Sequence Inspection and Extraction
You can view chromosome names, lengths, and extract specific sequences.

```r
# List all chromosomes/contigs
seqnames(genome)

# Get chromosome lengths
seqlengths(genome)

# Access a specific chromosome (returns a DNAString object)
chr1_seq <- genome$chr1 

# Extract a specific sub-sequence (e.g., chr1, positions 100 to 200)
library(Biostrings)
sub_seq <- getSeq(genome, names="chr1", start=100, end=200)
```

### Extracting Upstream/Promoter Sequences
While upstream sequences are no longer bundled directly in the package, they can be extracted using a `TxDb` object and the `getSeq` function.

```r
library(GenomicFeatures)

# Create or load a TranscriptDb for rheMac3
txdb <- makeTxDbFromUCSC(genome="rheMac3", table="refGene")

# Get gene coordinates
gn <- genes(txdb)

# Define 1000bp upstream (flanking) regions
up1000 <- flank(gn, width=1000)

# Extract the actual sequences
up1000seqs <- getSeq(genome, up1000)
```

### Genome-wide Motif Searching
Use the `matchPattern` or `vmatchPattern` functions from the `Biostrings` package to find motifs across the entire genome.

```r
# Search for a specific DNA pattern on chromosome 1
pattern <- "TATAAA"
matches <- matchPattern(pattern, genome$chr1)

# Search across all chromosomes
all_matches <- vmatchPattern(pattern, genome)
```

## Tips and Best Practices
- **Memory Management**: BSgenome objects use "on-disk" caching. Accessing `genome$chr1` loads that chromosome into memory. If working with many chromosomes, be mindful of RAM.
- **Coordinate Consistency**: Always ensure that the `TxDb` or `GRanges` objects you use match the `rheMac3` build to avoid coordinate shifts.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) by inspecting the object. This specific package provides the standard sequences as provided by UCSC.

## Reference documentation
- [BSgenome.Mmulatta.UCSC.rheMac3 Reference Manual](./references/reference_manual.md)