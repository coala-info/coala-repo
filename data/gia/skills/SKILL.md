---
name: gia
description: gia is a high-performance command-line toolset designed for performing complex set operations and arithmetic on genomic intervals. Use when user asks to sort intervals, intersect datasets, merge overlapping regions, subtract genomic features, calculate coverage, or find genomic complements.
homepage: https://github.com/noamteyssier/gia
---


# gia

## Overview

`gia` (Genomic Interval Arithmetic) is a high-performance command-line toolset written in Rust, designed to perform complex set operations on genomic intervals. It serves as a modern, scalable alternative to established tools like `bedtools` and `bedops`. Use this skill to guide the execution of genomic workflows including overlap detection, interval merging, genomic complementation, and coverage analysis.

## Installation and Setup

`gia` is distributed via Cargo. Ensure the Rust toolchain is installed before proceeding.

```bash
cargo install gia
```

Verify the installation:
```bash
gia --help
```

## Core CLI Patterns

### 1. Sorting Intervals
Many `gia` operations require input files to be sorted by chromosome and start position.
```bash
gia sort -i input.bed > sorted.bed
```

### 2. Intersecting Datasets
Find overlapping regions between two sets of intervals.
```bash
# Find overlaps between file A and file B
gia intersect -a set_a.bed -b set_b.bed > overlaps.bed
```

### 3. Merging Intervals
Collapse overlapping or book-ended intervals into single continuous regions.
```bash
gia merge -i input.bed > merged.bed
```

### 4. Subtracting Intervals
Remove genomic regions in file B from the intervals in file A.
```bash
gia subtract -a features.bed -b masks.bed > filtered.bed
```

### 5. Calculating Coverage
`gia` supports parallel processing for coverage calculations, making it significantly faster for large datasets.
```bash
# Calculate coverage using 8 threads
gia coverage -a regions.bed -b reads.bed -t 8 > coverage.txt
```

### 6. Genomic Complement
Find regions of the genome not covered by the input intervals. This requires a genome file (chrom sizes).
```bash
gia complement -i annotations.bed -g hg38.genome > gaps.bed
```

## Expert Tips and Best Practices

*   **Stream Processing**: `gia` is designed for Unix-style piping. Chain commands to avoid creating massive intermediate files.
    ```bash
    gia intersect -a A.bed -b B.bed | gia merge -i - > result.bed
    ```
*   **Parallelism**: When using the `coverage` subcommand, always specify the `-t` (threads) flag to leverage multi-core processors.
*   **Join Operations**: `gia` supports relational joins (inner, left, right). Use these when you need to preserve metadata from both files during an intersection.
*   **Memory Mapping**: The tool utilizes memory mapping for high-speed I/O; ensure your environment has sufficient virtual memory address space when working with exceptionally large files.



## Subcommands

| Command | Description |
|---------|-------------|
| bcf | BCF-centric commands |
| flank | Flanks the intervals of a BED file |
| get-fasta | Extracts FASTA sequences using intervals from a BED file |
| gia bam | BAM-centric commands |
| gia closest | Finds the closest interval in a secondary BED file for all intervals in a primary BED file |
| gia complement | Generates the complement of a BED file |
| gia join | Joins two BED files |
| gia segment | Segments a BED file into non-overlapping regions |
| gia shift | Shifts the intervals of a BED file by a specified amount |
| gia sort | Sorts a BED file by chromosome, start, and end |
| gia subtract | Subtracts two BED files |
| gia_cluster | Annotates the intervals of a BED file with their Cluster ID |
| gia_coverage | Calculates the coverage of intervals in Set A by intervals in Set B |
| gia_extend | Extends the intervals of a BED file |
| gia_merge | Merges intervals of a BED file with overlapping regions |
| gia_random | gia_random |
| gia_sample | Randomly sample a BED file |
| gia_spacing | Calculates the spacing between intervals in a BED file |
| gia_window | Finds all the overlapping intervals in Set B after adding a window around all intervals in Set A |
| intersect | Intersects two BED files |
| unionbedg | Combines multiple BedGraph files into a single file and shows coverage over segmented intervals of each BedGraph file as a separate column |

## Reference documentation

- [gia README](./references/github_com_noamteyssier_gia_blob_main_README.md)
- [Intersection Tool](./references/noamteyssier_github_io_gia_tools_intersect.html.md)
- [Merge Tool](./references/noamteyssier_github_io_gia_tools_merge.html.md)
- [Sort Tool](./references/noamteyssier_github_io_gia_tools_sort.html.md)
- [Subtract Tool](./references/noamteyssier_github_io_gia_tools_subtract.html.md)