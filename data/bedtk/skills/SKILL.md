---
name: bedtk
description: "bedtk is a high-performance utility for the rapid manipulation, filtering, and intersection of genomic intervals in BED, VCF, and PAF formats. Use when user asks to filter VCF files against BED annotations, merge overlapping records, calculate breadth of coverage, or perform interval subtraction and sorting."
homepage: https://github.com/lh3/bedtk
---


# bedtk

## Overview

bedtk is a specialized utility designed for the rapid manipulation of genomic intervals. Built on the implicit interval tree (cgranges), it excels in performance, often running several times faster than alternative toolsets while maintaining a significantly lower memory footprint. It is particularly useful for filtering VCF files against BED annotations, merging overlapping records without prior sorting, and calculating the breadth of coverage across genomic regions.

## Core Commands and Usage

### Filtering and Intersection
The `flt` command is the primary method for filtering one interval file against another. It supports BED, VCF, and PAF formats.

*   **Basic Filter**: Keep lines in `file1` that overlap `file2`.
    `bedtk flt annotation.bed.gz regions.bed.gz`
*   **Inverse Filter**: Keep lines in `file1` that do **not** overlap `file2`.
    `bedtk flt -v annotation.bed.gz regions.bed.gz`
*   **Window-based Filter**: Add a padding window (e.g., 100bp) around intervals in the first file.
    `bedtk flt -w 100 annotation.bed.gz variants.vcf.gz`
*   **Fractional Overlap**: Filter based on a minimum overlapping fraction.
    `bedtk flt -f 0.5 file1.bed file2.bed`

### Intersection and Subtraction
*   **Intersection**: Find the specific overlapping segments between two files.
    `bedtk isec file1.bed.gz file2.bed.gz`
*   **Subtraction**: Remove segments of `file1` that are covered by `file2`.
    `bedtk sub file1.bed file2.bed`

### Sorting and Merging
Unlike many genomic tools, bedtk can often perform operations without requiring input files to be pre-sorted, though it provides high-performance sorting when needed.

*   **Merge**: Combine overlapping or adjacent records into single intervals.
    `bedtk merge input.bed`
*   **Sort**: Sort a BED file by chromosome and position.
    `bedtk sort input.bed`
*   **Custom Chromosome Order**: Sort using a specific chromosome list to define sequence.
    `bedtk sort -s chr_list.txt input.bed`

### Coverage Calculation
*   **Breadth of Coverage**: Calculate how many bases in `file1` are covered by intervals in `file2`.
    `bedtk cov target_regions.bed reads.bed`

## Expert Tips

1.  **VCF Handling**: bedtk automatically detects VCF files. When filtering VCFs, it correctly parses the `END` tag in the INFO field for structural variants to determine the true interval length.
2.  **Streamlined Pipelines**: Because `merge` and `isec` do not strictly require sorted input, you can often skip the `sort | merge` pattern required by other toolkits, saving significant I/O time.
3.  **Memory Efficiency**: bedtk uses an implicit interval tree which is highly compact. If you are hitting memory limits with `bedtools` on massive datasets (like whole-genome bisulfite sequencing or dense variant files), switch to `bedtk`.
4.  **PAF Support**: Recent versions support the Pairwise mApping Format (PAF), allowing you to filter genomic alignments directly against BED annotations.



## Subcommands

| Command | Description |
|---------|-------------|
| bedtk_sum | Sum the lengths of intervals in a BED file. |
| cov | Calculate coverage of intervals in a BED file. |
| flt | Filter BED records based on overlap with another BED file or VCF/PAF. |
| isec | Find intersections between two BED files |
| sub | Subtracts regions from another set of regions. |

## Reference documentation

- [GitHub Repository Overview](./references/github_com_lh3_bedtk.md)
- [Official README and Examples](./references/github_com_lh3_bedtk_blob_master_README.md)
- [Release Notes and Version History](./references/github_com_lh3_bedtk_blob_master_NEWS.md)