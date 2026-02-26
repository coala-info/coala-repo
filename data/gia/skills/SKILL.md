---
name: gia
description: gia is a high-performance command-line utility designed for performing set operations and arithmetic on genomic intervals. Use when user asks to intersect intervals, perform relational joins, calculate genomic coverage, or find the complement of genomic regions.
homepage: https://github.com/noamteyssier/gia
---


# gia

## Overview
`gia` (Genomic Interval Arithmetic) is a high-performance command-line utility designed for set operations on genomic intervals. Written in Rust and built on the `bedrs` library, it is optimized for speed and scalability, aiming to be a drop-in replacement for established tools like `bedtools` and `bedops`. Use this skill when you need to perform efficient set theory operations—such as intersections, joins, and coverage calculations—on genomic data formats like BED.

## Common CLI Patterns

### Basic Operations
The tool follows a standard subcommand structure. You can view all available subcommands and global options using the help flag:
```bash
gia --help
```

### Intersecting Intervals
To find overlaps between a query file and one or more reference files:
```bash
gia intersect -a query.bed -b reference.bed
```

### Relational Joins
`gia` supports relational joins between interval sets, which is useful for maintaining metadata from both files during an overlap operation. Supported methods include `inner`, `left`, and `right`.
```bash
gia join -a file1.bed -b file2.bed --method inner
```

### Calculating Coverage
For depth-of-coverage calculations, `gia` supports parallel processing to handle large datasets efficiently.
```bash
gia coverage -a regions.bed -b reads.bed --threads 8
```

### Finding Complements
To identify genomic regions that are NOT covered by your intervals:
```bash
gia complement -i input.bed
```

## Expert Tips and Best Practices

### Handling Multiple Inputs
One of `gia`'s powerful features is the ability to accept multiple files for the `-b` (reference) argument. It will concatenate these inputs and treat them as a single reference set for the operation:
```bash
gia intersect -a query.bed -b ref1.bed ref2.bed ref3.bed
```

### Performance Optimization
*   **Parallelism**: When using the `coverage` subcommand, always specify the `--threads` parameter if working on a multi-core system to significantly reduce processing time.
*   **Rust Toolchain**: If you require the absolute latest features or performance patches, install via `cargo install gia` to compile it specifically for your architecture.

### Transitioning from bedtools
While `gia` aims for compatibility, always check the specific subcommand help (e.g., `gia intersect --help`) as flag names or default behaviors may vary slightly to accommodate the underlying Rust implementation's optimizations.

## Reference documentation
- [gia Overview](./references/anaconda_org_channels_bioconda_packages_gia_overview.md)
- [gia GitHub Repository](./references/github_com_noamteyssier_gia.md)
- [gia Commit History](./references/github_com_noamteyssier_gia_commits_main.md)