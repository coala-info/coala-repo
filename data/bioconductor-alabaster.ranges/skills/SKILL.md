---
name: bioconductor-alabaster.ranges
description: This package serializes genomic ranges and associated metadata into language-agnostic file artifacts for persistent storage and retrieval. Use when user asks to save GRanges objects to disk, load genomic range artifacts, or preserve metadata and sequence information across different programming environments.
homepage: https://bioconductor.org/packages/release/bioc/html/alabaster.ranges.html
---

# bioconductor-alabaster.ranges

## Overview

The `alabaster.ranges` package is a specialized component of the **alabaster** framework designed for the serialization of genomic ranges. It provides a language-agnostic way to store `GRanges`, `GRangesList`, and various `CompressedList` subclasses (like `CompressedSplitDataFrameList`) as file artifacts. This ensures that all associated data—including `mcols`, `metadata`, and `seqinfo`—is preserved across sessions or different programming environments.

## Core Workflow

The package follows the standard **alabaster** "save/read" paradigm using `saveObject()` and `readObject()`.

### Saving Genomic Ranges

To save a `GRanges` object, specify the object and a destination directory.

```r
library(GenomicRanges)
library(alabaster.ranges)

# Create an example GRanges object
gr <- GRanges("chr1", IRanges(start=c(10, 50), width=10))
mcols(gr)$score <- c(0.5, 0.8)
seqlengths(gr) <- c(chr1=1000)
metadata(gr)$project <- "Analysis_A"

# Save to a directory
tmp <- tempfile()
saveObject(gr, tmp)
```

### Loading Genomic Ranges

To restore the object, point `readObject()` to the directory containing the artifacts.

```r
# Load the object back into R
roundtrip <- readObject(tmp)

# Verify contents
print(roundtrip)
metadata(roundtrip)
seqinfo(roundtrip)
```

## Supported Objects

The skill handles the following Bioconductor classes:
- **GRanges**: Standard genomic intervals.
- **GRangesList**: Collections of genomic intervals (e.g., exons grouped by transcript).
- **CompressedList Subclasses**: Including `CompressedSplitDataFrameList`, which is frequently used for storing per-feature annotation sets.

## Key Features Preserved

Unlike simple CSV or BED exports, `alabaster.ranges` ensures the following are maintained:
1.  **Metadata**: Any list stored in `metadata(obj)`.
2.  **Element-wise Annotations**: DataFrames stored in `mcols(obj)`.
3.  **Sequence Information**: `seqnames`, `seqlengths`, `isCircular`, and `genome` via the `Seqinfo` object.
4.  **Complex Nesting**: Handles nested list structures within the ranges.

## Implementation Details

When `saveObject()` is called, the package creates a directory structure containing:
- `ranges.h5`: The core coordinates and structural data in HDF5 format.
- `range_annotations/`: Sub-directory for `mcols`.
- `sequence_information/`: Sub-directory for `seqinfo`.
- `other_annotations/`: Sub-directory for `metadata`.

## Reference documentation

- [Saving genomic ranges to artifacts and back again](./references/userguide.md)