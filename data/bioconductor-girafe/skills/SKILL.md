---
name: bioconductor-girafe
description: The girafe package processes and visualizes aligned genomic sequence data using interval-based representations. Use when user asks to import BAM files, trim adapter sequences, merge overlapping reads into consensus intervals, calculate read density, or overlap alignments with genomic annotations.
homepage: https://bioconductor.org/packages/3.6/bioc/html/girafe.html
---

# bioconductor-girafe

## Overview

The `girafe` package provides a bridge between raw sequence alignments and functional genomic analysis. It centers around the `AlignedGenomeIntervals` class, which allows for efficient storage and manipulation of aligned reads. Key capabilities include adapter trimming, importing alignments from Bowtie or BAM files, merging overlapping reads into consensus intervals, and visualizing read density against genome annotations.

## Core Workflow

### 1. Data Import and Object Creation

The primary object is an `AlignedGenomeIntervals` (AGI) object. You can create it from `ShortRead` objects or directly from BAM files.

```R
library(girafe)

# From AlignedRead (ShortRead package)
# exA is an AlignedRead object
exAI <- as(exA, "AlignedGenomeIntervals")
organism(exAI) <- "Mm"

# Directly from BAM files
# Requires indexed and sorted BAM
exAI <- agiFromBam("path/to/file.bam")
```

### 2. Adapter Trimming

If reads contain adapter sequences, use `trimAdapter` before or during processing.

```R
adapter <- "CTGTAGGCACCATCAAT"
# ra23.wa is a ShortReadQ object
ra23.na <- trimAdapter(ra23.wa, adapter)
```

### 3. Exploring and Summarizing

Use standard R methods and package-specific functions to explore the distribution of reads.

```R
# General summary of reads per chromosome
summary(exAI)

# Table of intervals per chromosome
table(seqnames(exAI))

# Detailed view of a subset (e.g., Mitochondria)
detail(exAI[seqnames(exAI)=="chrMT"])

# Sliding window summary
# Returns counts of overlaps, total reads, and unique reads per window
exPX <- perWindow(exAI, chr="chrX", winsize=1e5, step=0.5e5)
```

### 4. Processing Intervals (Reduce)

The `reduce` function is critical for merging overlapping reads or reads at the same position that differ only by sequencing errors.

```R
# Default: merges overlapping/adjacent intervals on same strand with same match specificity
reducedAI <- reduce(exAI)

# Exact: only merge intervals with identical start/end positions
reducedExact <- reduce(exAI, method="exact")

# Parallel processing for speed (non-Windows)
library(parallel)
options("mc.cores" = 4)
reducedAI <- reduce(exAI, mem.friendly=TRUE)
```

### 5. Overlap with Annotations

To determine which genomic features (genes, miRNAs, etc.) are covered by reads, use `interval_overlap`.

```R
# mgi.gi is a GenomeIntervalsStranded object containing annotations
exOv <- interval_overlap(exAI, mgi.gi)

# Count overlaps per interval
table(listLen(exOv))

# Identify types of features overlapped
tabOv <- table(as.character(mgi.gi$type)[unlist(exOv)])
```

### 6. Visualization and Export

`girafe` provides integrated plotting to view reads alongside annotations.

```R
# Plot a specific genomic region
plot(exAI, mgi.gi, chr="chrX", start=50400000, end=50410000, show="minus")

# Export to UCSC formats (BED or bedGraph)
export(exAI, con="output.bed", format="bed", name="my_reads")
```

## Memory Management Tips

- `AlignedGenomeIntervals` objects are significantly smaller (10-100x) than `AlignedRead` objects. Convert and discard the raw `AlignedRead` object as soon as possible.
- For very large datasets, process alignments in batches (e.g., 1-5 million reads) and combine the resulting AGI objects using `c()`.
- Use `agiFromBam` to leverage `Rsamtools` for memory-efficient access to specific genomic regions.

## Reference documentation

- [An overview of the girafe package](./references/girafe.md)