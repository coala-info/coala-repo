---
name: bioconductor-genomicranges
description: The GenomicRanges package provides foundational infrastructure for representing and manipulating genomic intervals and their associated metadata in R. Use when user asks to create GRanges objects, perform genomic arithmetic like merging or resizing intervals, find overlaps between genomic features, or compute coverage across a genome.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html
---


# bioconductor-genomicranges

name: bioconductor-genomicranges
description: Expert guidance for the Bioconductor R package GenomicRanges. Use this skill when you need to represent, manipulate, and analyze genomic intervals (ranges) in R. It covers creating GRanges and GRangesList objects, performing intra-range and inter-range transformations (shift, resize, reduce, gaps), finding overlaps (findOverlaps), computing coverage, and extracting sequences.

# bioconductor-genomicranges

## Overview
The `GenomicRanges` package is the foundational Bioconductor infrastructure for representing and manipulating genomic intervals. It provides efficient containers like `GRanges` (for individual intervals) and `GRangesList` (for grouped intervals, such as exons within transcripts). This skill helps you perform high-performance genomic arithmetic, overlap detection, and data integration across the Bioconductor ecosystem.

## Core Classes

### GRanges
Represents a set of genomic intervals. Each range requires:
- `seqnames`: Chromosome/scaffold names (as `Rle` or factor).
- `ranges`: Start and end coordinates (as `IRanges`).
- `strand`: "+", "-", or "*" (unstranded).
- `mcols`: Optional metadata columns (score, GC content, etc.).

```r
library(GenomicRanges)
gr <- GRanges(
    seqnames = "chr1",
    ranges = IRanges(start = c(100, 200), end = c(150, 250)),
    strand = c("+", "-"),
    score = c(10, 20)
)
```

### GRangesList
A list-like container for grouping `GRanges` objects. Common for gene models where a single gene ID maps to multiple exons.
- Use `exonsBy(txdb, by="gene")` to create these from annotation databases.
- Supports `lapply`, `endoapply`, and many range operations that distribute over the list elements.

## Common Workflows

### 1. Genomic Arithmetic (Intra-range)
Transform individual ranges without considering others in the set:
- `shift(gr, 10)`: Move ranges by a fixed distance.
- `resize(gr, width = 1, fix = "start")`: Shrink to TSS or specific anchor.
- `flank(gr, 100)`: Get upstream/downstream regions (respects strand).
- `narrow(gr, start=2, end=-2)`: Relative subsetting within the range.

### 2. Genomic Arithmetic (Inter-range)
Operations that look across the entire set:
- `reduce(gr)`: Merge overlapping ranges into contiguous blocks.
- `disjoin(gr)`: Break overlapping ranges into non-overlapping parts.
- `gaps(gr)`: Find the "empty" spaces between ranges.
- `range(gr)`: Find the total span (min start to max end) per chromosome/strand.

### 3. Overlap Detection
The `findOverlaps` function is the workhorse for comparing two sets of ranges.
```r
hits <- findOverlaps(query, subject)
# Access results
queryHits(hits)
subjectHits(hits)

# Count overlaps directly
counts <- countOverlaps(query, subject)

# Subset by overlap
query[query %over% subject]
```

### 4. Coverage and Binned Averages
- `coverage(gr)`: Returns an `RleList` representing the number of ranges covering every base.
- `slice(cvg, lower=10)`: Find "peaks" where coverage exceeds a threshold.
- `tileGenome(seqinfo, tilewidth=100)`: Create fixed-width bins across the genome.
- `binnedAverage(bins, variable, "name")`: Calculate average signal per bin.

## Tips for Success
- **Strand Awareness**: Most functions respect strand by default. Use `ignore.strand = TRUE` if you want to treat "+" and "-" as the same.
- **Seqinfo**: Always define `seqlevels` and `seqlengths` to prevent errors when comparing datasets from different genome builds. Use `keepSeqlevels()` and `renameSeqlevels()` to clean up objects.
- **Metadata**: Access metadata columns via `mcols(gr)`. You can treat them like a data frame: `gr$score <- gr$score * 2`.
- **1-Based Coordinates**: GenomicRanges uses the R/Bioconductor standard of 1-based, closed intervals (both start and end are included).

## Reference documentation
- [Extending GenomicRanges](./references/ExtendingGenomicRanges.md)
- [GRanges and GRangesList slides](./references/GRanges_and_GRangesList_slides.md)
- [GenomicRanges HOWTOs](./references/GenomicRangesHOWTOs.md)
- [An Introduction to the GenomicRanges Package](./references/GenomicRangesIntroduction.md)
- [Ten things you should know about GenomicRanges](./references/Ten_things_slides.md)