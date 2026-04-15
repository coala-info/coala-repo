---
name: bioconductor-rnamodr.data
description: This package provides curated experimental datasets, genomic annotations, and reference sequences for testing and demonstrating RNA modification detection workflows. Use when user asks to access example BAM, GFF3, or FASTA files for RNAmodR, retrieve RiboMethSeq or AlkAnilineSeq datasets, or query the snoRNAdb for human RNA modifications.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RNAmodR.Data.html
---

# bioconductor-rnamodr.data

## Overview

`RNAmodR.Data` is an experiment data package providing essential resources for the `RNAmodR` ecosystem. It serves as a centralized repository for high-throughput sequencing data (BAM), genomic annotations (GFF3), and reference sequences (FASTA) specifically curated for testing and demonstrating RNA modification detection workflows like RiboMethSeq and AlkAnilineSeq. It also provides a programmatic interface to the snoRNAdb for human RNA modifications.

## Data Access via ExperimentHub

The package primarily uses `ExperimentHub` to manage and distribute large data files.

```r
library(RNAmodR.Data)
library(ExperimentHub)

# Initialize ExperimentHub and list available RNAmodR.Data resources
eh <- ExperimentHub()
listResources(eh, "RNAmodR.Data")
```

## Specific Dataset Categories

The data is organized into several functional groups accessible via specific accessor functions or help pages:

1.  **General Examples (`?RNAmodR.Data.example`)**: Standard files for general RNAmodR functionality.
2.  **RiboMethSeq (`?RNAmodR.Data.RMS`)**: Datasets specifically for 2'-O-methylation analysis.
3.  **AlkAnilineSeq (`?RNAmodR.Data.AAS`)**: Datasets for detecting m7G, m3C, and D modifications.
4.  **Man Page Examples (`?RNAmodR.Data.man`)**: Minimal datasets for quick function demonstrations.
5.  **snoRNAdb (`?RNAmodR.Data.snoRNAdb`)**: A database of human snoRNAs and their target modifications.

## Working with snoRNAdb

The `RNAmodR.Data.snoRNAdb()` function returns a path to a CSV file containing published snoRNA data. This is often converted into a `GRanges` or `GRangesList` for genomic analysis.

```r
library(GenomicRanges)

# Load the raw table
sno_path <- RNAmodR.Data.snoRNAdb()
table <- read.csv2(sno_path, stringsAsFactors = FALSE)

# Example: Convert to GRanges
# Note: snoRNAdb typically contains hgnc_symbols and modification positions
snoRNA_gr <- GRanges(
  seqnames = table$hgnc_symbol,
  ranges = IRanges(start = table$position, width = 1),
  strand = "+",
  mod = table$modification,
  guide = table$guide
)

# Split by parent gene to create a GRangesList
snoRNA_grl <- split(snoRNA_gr, f = mcols(snoRNA_gr)$seqnames)
```

## Typical Workflow

When using this package to test `RNAmodR` methods, you typically retrieve the file paths from the hub and pass them to the modification detection functions:

1.  Identify the resource name (e.g., `"RNAmodR.Data.example.bam.1"`).
2.  Load the resource using its ExperimentHub ID or the package's wrapper.
3.  Use the resulting file path in downstream Bioconductor objects like `ModParam` or `SequenceData`.

## Reference documentation

- [RNAmodR.Data: example data for RNAmodR packages](./references/RNAmodR.Data.md)