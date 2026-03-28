---
name: ucsc-bedintersect
description: "ucsc-bedintersect identifies and extracts genomic regions from one BED file that overlap with regions in another BED file. Use when user asks to find overlapping genomic intervals, filter BED records based on a mask, or perform binary overlap intersections between two datasets."
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedintersect

## Overview
`bedIntersect` is a specialized command-line utility from the UCSC Genome Browser "Kent" source tree designed for efficient genomic interval arithmetic. Its primary function is to compare two BED files and output the regions from the first file that overlap with the second. It is favored in bioinformatics pipelines for its speed and simplicity when performing binary overlap filters (e.g., "keep only these regions if they hit a specific mask").

## Usage Instructions

### Basic Syntax
The standard usage requires two input BED files and a destination for the output:
```bash
bedIntersect [options] fileA.bed fileB.bed out.bed
```
*   **fileA.bed**: The "target" file. The output will consist of records from this file.
*   **fileB.bed**: The "query" or "mask" file used to determine overlaps.
*   **out.bed**: The resulting file containing records from `fileA` that met the overlap criteria.

### Common CLI Patterns

**1. Simple Intersection (Any Overlap)**
To keep all records in `fileA` that have at least 1 base pair of overlap with any record in `fileB`:
```bash
bedIntersect fileA.bed fileB.bed out.bed
```

**2. Minimum Overlap Threshold**
To require a specific number of overlapping bases (e.g., at least 50 bases):
```bash
bedIntersect -minOverlap=50 fileA.bed fileB.bed out.bed
```

**3. Filtering by Fraction (Percentage)**
While some tools use decimals, UCSC utilities often use integer-based logic or specific flags. If using the standard Kent version, ensure your BED files are properly sorted for optimal performance.

### Expert Tips

*   **Sorting Requirement**: Like most UCSC utilities, `bedIntersect` performs best (and sometimes requires) that input files are sorted by chromosome and then by start position. Use `bedSort` if the order is unknown.
*   **Memory Efficiency**: `bedIntersect` is highly efficient for large datasets because it processes overlaps without the overhead of the more complex feature-joining found in tools like `bedtools`.
*   **Standard Input/Output**: You can often use `/dev/stdin` or `/dev/stdout` to pipe `bedIntersect` into other Kent tools like `bedClip` or `bedToBigBed`.
*   **Permission Errors**: If running a freshly downloaded binary from the UCSC server, remember to set execution permissions:
    ```bash
    chmod +x ./bedIntersect
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| bedClip | Remove lines from bed file that refer to nucleotides outside of a chromosome. |
| bedIntersect | Find overlaps between two bed files. |
| bedSort | Sort a BED file. The input and output can be the same file. |

## Reference documentation
- [UCSC Genome Browser Kent Source](./references/github_com_ucscGenomeBrowser_kent.md)
- [UCSC Binary Downloads (Aarch64)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.aarch64.v492.md)
- [UCSC Utility License (MIT)](./references/github_com_ucscGenomeBrowser_kent_blob_master_LICENSE.md)