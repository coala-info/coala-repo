---
name: bioconductor-bsgenome.btaurus.ucsc.bostau6
description: This package provides the full genome sequence for Bos taurus based on the UCSC bosTau6 assembly for use in R. Use when user asks to retrieve bovine chromosome sequences, extract genomic features like promoters, or perform sequence analysis such as motif searching and GC content calculation.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BSgenome.Btaurus.UCSC.bosTau6.html
---


# bioconductor-bsgenome.btaurus.ucsc.bostau6

name: bioconductor-bsgenome.btaurus.ucsc.bostau6
description: Full genome sequences for Bos taurus (Cow) based on the UCSC bosTau6 assembly (Nov. 2009). Use this skill when an AI agent needs to access, analyze, or manipulate the bovine reference genome in R, including retrieving chromosome sequences, calculating sequence statistics, or extracting genomic features like upstream promoter regions.

# bioconductor-bsgenome.btaurus.ucsc.bostau6

## Overview

The `BSgenome.Btaurus.UCSC.bosTau6` package is a data-driven Bioconductor annotation package containing the complete genome sequence for *Bos taurus* (Cow). It provides the UCSC version `bosTau6` assembly as a `BSgenome` object, allowing for efficient sequence retrieval and integration with other Bioconductor packages like `Biostrings`, `GenomicRanges`, and `GenomicFeatures`.

## Loading and Basic Usage

To use the genome in an R session, load the library and assign the genome object to a variable for easier access:

```r
library(BSgenome.Btaurus.UCSC.bosTau6)

# Access the genome object
genome <- BSgenome.Btaurus.UCSC.bosTau6

# View metadata and available sequences
genome

# List chromosome names and lengths
seqnames(genome)
seqlengths(genome)
```

## Sequence Retrieval

You can retrieve specific chromosome sequences using standard list or dollar-sign notation, which returns a `DNAString` object.

```r
# Access chromosome 1
chr1_seq <- genome$chr1

# Access via string name
chr2_seq <- genome[["chr2"]]

# Get a subsequence (e.g., first 1000 bp of chr1)
sub_seq <- subseq(genome$chr1, start=1, end=1000)
```

## Extracting Genomic Features

A common workflow involves extracting sequences for specific genomic coordinates (e.g., genes or promoters). This requires the `getSeq` function and often a corresponding `TxDb` object.

### Extracting Upstream Sequences (Promoters)

Since version 3.0, upstream sequences are not pre-packaged but can be extracted dynamically:

```r
library(GenomicFeatures)

# Create a TranscriptDb for bosTau6
txdb <- makeTxDbFromUCSC(genome="bosTau6", tablename="refGene")

# Get gene coordinates
gn <- sort(genes(txdb))

# Define 1000bp upstream regions (flanking)
up1000_coords <- flank(gn, width=1000)

# Extract the actual DNA sequences
up1000_seqs <- getSeq(genome, up1000_coords)
```

## Genome-Wide Analysis

The package integrates with `Biostrings` for motif searching and sequence analysis.

```r
# Count occurrences of a specific motif on chr1
library(Biostrings)
matchPattern("GATAAG", genome$chr1)

# Calculate GC content for the whole genome (example for one chromosome)
letterFrequency(genome$chr1, letters="GC", as.prob=TRUE)
```

## Implementation Tips

- **Memory Management**: `BSgenome` objects use "on-disk" caching. Accessing `genome$chr1` loads that specific chromosome into memory. If working with many chromosomes, be mindful of RAM.
- **Consistency**: Always ensure that the `TxDb` or `GRanges` objects you use match the `bosTau6` assembly exactly to avoid coordinate shifts.
- **Masks**: Check if the genome contains masks (e.g., for assembly gaps or repeats) by inspecting `masks(genome$chr1)`.

## Reference documentation

- [BSgenome.Btaurus.UCSC.bosTau6 Reference Manual](./references/reference_manual.md)