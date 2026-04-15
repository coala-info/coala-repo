---
name: bioconductor-plyranges
description: The bioconductor-plyranges package provides a tidyverse-like interface for manipulating and performing arithmetic on genomic ranges. Use when user asks to construct genomic objects, perform strand-aware interval resizing, filter by overlaps, or execute spatial joins between genomic datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/plyranges.html
---

# bioconductor-plyranges

## Overview
The `plyranges` package provides a "tidy" interface to Bioconductor's core genomic range classes (`GRanges` and `IRanges`). It allows users to manipulate genomic data using familiar `dplyr`-like verbs such as `mutate`, `filter`, `group_by`, and `summarise`. This skill helps you construct ranges, perform genomic arithmetic (shifting, stretching, anchoring), and execute complex overlap-based joins and aggregations.

## Core Workflows

### 1. Constructing Ranges
Convert data frames or tibbles into genomic objects.
- `as_iranges(df)`: Creates an `IRanges` object (requires `start`, `end`, or `width`).
- `as_granges(df)`: Creates a `GRanges` object (requires `seqnames`, plus optional `strand`).

### 2. Genomic Arithmetic & Anchoring
Modify interval boundaries while maintaining specific coordinates.
- **Anchoring**: Use `anchor_start()`, `anchor_end()`, `anchor_center()`, `anchor_5p()`, or `anchor_3p()` before a mutation to fix a point.
- **Resizing**: `mutate(rng, width = 10)` resizes based on the anchor.
- **Stretching**: `stretch(rng, extend)` adds width to both sides (or one side if anchored).
- **Shifting**: `shift_left()`, `shift_right()`, `shift_upstream()`, and `shift_downstream()` move intervals.

### 3. Filtering and Restriction
- `filter()`: Standard logical filtering on metadata or coordinates.
- `filter_by_overlaps(query, subject)`: Keeps ranges in query that overlap subject.
- `filter_by_non_overlaps(query, subject)`: Keeps ranges in query that do not overlap subject.

### 4. Grouping and Summarization
- `group_by()`: Groups by metadata or core components (e.g., `strand`).
- `summarise()`: Aggregates data (returns a `DataFrame`).
- `reduce_ranges()`: Merges overlapping ranges into a single range (can be used with `group_by`).
- `disjoin_ranges()`: Breaks overlapping ranges into non-overlapping segments.

### 5. Overlap Joins
Join two genomic objects based on spatial relationships.
- `join_overlap_inner(query, subject)`: Returns query ranges that overlap subject, including subject metadata.
- `join_overlap_intersect(query, subject)`: Returns the specific intersecting genomic coordinates.
- `join_overlap_left(query, subject)`: Keeps all query ranges, adding subject metadata where overlaps exist.
- `join_nearest()`, `join_follow()`, `join_precede()`: Joins based on proximity rather than direct overlap.

### 6. Data Import/Export
`plyranges` wraps `rtracklayer` for tidy file reading:
- `read_bed()`, `read_gff()`, `read_bam()`, `read_bigwig()`.
- `write_bed()`, `write_gff()`, `write_bigwig()`.

## Tips for Success
- **Strand Awareness**: Functions like `anchor_5p` and `shift_upstream` are strand-aware. Ensure your `GRanges` object has correct strand information (`+`, `-`, or `*`).
- **Piping**: Always use the pipe operator (`%>%`) to chain operations for readability.
- **Metadata**: Metadata columns are preserved through most operations unless explicitly dropped via `select()`.
- **Overlap Groups**: Use `group_by_overlaps(query, subject)` to perform calculations on the subject ranges that hit each query range.

## Reference documentation
- [Getting started with the plyranges package](./references/an-introduction.md)