---
name: bioconductor-genomictuples
description: This tool manages and manipulates genomic tuples representing sets of specific genomic coordinates. Use when user asks to create GTuples objects, calculate intra-pair distances, find overlaps based on exact coordinate matching, or perform operations on sets of genomic positions rather than intervals.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicTuples.html
---


# bioconductor-genomictuples

name: bioconductor-genomictuples
description: Comprehensive management of genomic tuples (sets of genomic coordinates) using the GenomicTuples R package. Use when Claude needs to store, manipulate, or compare sets of genomic positions (m-tuples) rather than intervals (ranges). This includes creating GTuples objects, performing intra-tuple operations like shifting, calculating intra-pair distances (IPD), and finding overlaps or comparing tuples based on exact coordinate matching.

# bioconductor-genomictuples

## Overview

The `GenomicTuples` package provides R containers for storing and manipulating genomic tuples. While `GenomicRanges` handles intervals (start to end), `GenomicTuples` handles sets of specific positions (e.g., a 3-tuple representing three specific methylation sites). Every tuple in a `GTuples` object must have the same `size` (number of positions), and positions must be sorted in ascending order on the same chromosome and strand.

## Core Classes

- **GTuples**: A vector of genomic tuples of a fixed size $m$. Extends `GRanges`.
- **GTuplesList**: A list-like container for `GTuples` objects. Extends `GRangesList`.

## Key Workflows

### 1. Creating GTuples

Use the `GTuples()` constructor. You must provide `seqnames`, `strand`, and a `tuples` matrix where each row represents the positions of one tuple.

```r
library(GenomicTuples)

# Create a 3-tuple object
gt3 <- GTuples(
  seqnames = c("chr1", "chr2"),
  tuples = matrix(c(10, 20, 30, 15, 25, 35), ncol = 3, byrow = TRUE),
  strand = c("+", "-"),
  score = c(5, 10) # Metadata columns
)
```

### 2. Accessors and Basic Methods

- `tuples(x)`: Returns the integer matrix of positions (replaces `ranges(x)`).
- `size(x)`: Returns the number of positions in each tuple (e.g., 3 for a 3-tuple).
- `IPD(x)`: Returns the Intra-Pair Distances ($pos_{i+1} - pos_i$) as a matrix.
- `mcols(x)`: Access metadata columns.
- `as(x, "GRanges")`: Coerces to `GRanges`. **Warning**: This is destructive as it only keeps $pos_1$ and $pos_m$.

### 3. Overlap Operations

`findOverlaps` behavior depends on the `type` argument:

- **type = "equal"**: Matches tuples only if all $m$ positions, seqnames, and strand are identical. This is the only type that considers "internal" positions for $m > 2$.
- **type = "any" / "start" / "end" / "within"**: Tuples are treated as ranges from $pos_1$ to $pos_m$. Internal positions are ignored.
- **GenomicTuples vs GRanges**: When comparing a tuple to a range, the tuple is always treated as a range ($pos_1$ to $pos_m$).

### 4. Comparison and Sorting

Comparison follows a "natural order": `seqnames` first, then `strand`, then element-wise comparison of the `tuples` matrix ($pos_1, pos_2, \dots, pos_m$).

- `sort(gt)`: Sorts tuples by their natural order.
- `duplicated(gt)` / `unique(gt)`: Identifies or removes tuples with identical coordinates and strand.
- `pcompare(x, y)`: Performs element-wise comparison.

### 5. Intra-tuple Operations

- `shift(gt, shift)`: Moves all positions in the tuples by a fixed amount.
- `trim(gt)`: Trims tuples that exceed sequence lengths (may fail if internal positions become invalid).
- **Note**: Methods like `narrow`, `flank`, `resize`, and `reduce` are generally not defined for tuples because they are interval-based operations.

## Usage Tips

- **Avoid `ranges()`**: While defined (returning $pos_1$ and $pos_m$), it is usually not what you want for tuples. Use `tuples()` instead.
- **Width**: `width(gt)` returns $pos_m - pos_1 + 1$. For the distance between specific points, use `IPD()`.
- **GTuplesList**: Use `GTuplesList()` to group tuples. Methods like `lapply`, `endoapply`, and `unlist` work similarly to `GRangesList`.

## Reference documentation

- [GenomicTuples: Classes and Methods](./references/GenomicTuplesIntroduction.md)