---
name: bedops
description: BEDOPS is a suite of command-line tools designed for high-performance manipulation, set operations, and statistical mapping of genomic intervals. Use when user asks to perform set operations on BED files, map signal data to reference regions, sort genomic data, or compress files into the Starch format.
homepage: http://bedops.readthedocs.io
---


# bedops

## Overview

BEDOPS is a specialized suite of command-line tools designed for fast and scalable manipulation of genomic intervals. Unlike many other tools, BEDOPS is built on the principle that genomic data should be sorted. By requiring sorted input, BEDOPS tools can process data using a "streaming" approach, which minimizes memory usage and allows for operations on datasets that far exceed available RAM. 

The toolkit is divided into four primary functional areas:
1.  **Set Operations**: Performing Boolean logic (AND, OR, NOT) on multiple BED files.
2.  **Statistical Mapping**: Calculating scores or statistics for features that overlap specific target regions.
3.  **File Management**: Sorting, compressing (Starch format), and converting various genomic formats (BAM, GFF, VCF) to BED.
4.  **Extraction**: Rapidly retrieving specific chromosomes or features from large files.

## Core Tool Usage

### 1. Sorting (The Essential First Step)
All BEDOPS tools require lexicographically sorted BED files. Use `sort-bed` to prepare your data.
```bash
# Sort an unsorted BED file
sort-bed unsorted.bed > sorted.bed

# Sort and compress in one pipeline
sort-bed unsorted.bed | starch - > sorted.starch
```

### 2. Set Operations with `bedops`
The `bedops` tool handles multiset operations. It can take any number of input files.
*   **Union (Everything)**: `bedops --everything A.bed B.bed > union.bed`
*   **Intersection**: `bedops --intersect A.bed B.bed > intersect.bed`
*   **Difference**: `bedops --difference A.bed B.bed > A_minus_B.bed`
*   **Element-of**: `bedops --element-of 1 A.bed B.bed` (Finds elements in A that overlap B by at least 1bp).

### 3. Statistical Mapping with `bedmap`
`bedmap` maps "source" features onto "reference" regions and calculates statistics.
```bash
# Calculate the mean signal from source.bed for every region in reference.bed
bedmap --echo --mean reference.bed source.bed > results.bed
```
*   **--echo**: Prints the reference element.
*   **--count**: Counts overlapping elements.
*   **--min / --max / --mean**: Standard statistical operations.

### 4. Compression and Management (Starch)
The Starch format (`.starch`) is a lossless compression format that allows for random access by chromosome.
*   **Compress**: `starch sorted.bed > sorted.starch`
*   **Extract**: `unstarch sorted.starch > sorted.bed`
*   **Extract specific chromosome**: `unstarch chr1 sorted.starch`
*   **Metadata**: `unstarch --list sorted.starch` (View element counts and attributes without decompressing).

## Expert Tips & Best Practices

*   **Streaming Pipelines**: Use UNIX pipes (`|`) to avoid creating large intermediate files. BEDOPS tools are designed to read from `stdin` (represented by `-`).
    ```bash
    bedops --intersect A.bed B.bed | bedmap --echo --count - C.bed
    ```
*   **Parallelization**: Use the `--chrom` option or `starchstrip` to split tasks by chromosome. Since BEDOPS is agnostic to the relationship between chromosomes, you can run 23 parallel jobs (for human data) and merge results with `starchcat`.
*   **Memory Management**: If sorting a file larger than system memory, use `sort-bed --max-mem 2G` to limit memory usage and use disk-based temporary storage.
*   **Efficient Extraction**: Use `bedextract` to instantly pull specific chromosomes from a sorted BED file. It uses a binary search algorithm that is much faster than `grep`.
*   **BAM Conversion**: Use `bam2bed` or `bam2starch` for high-performance conversion of alignment files to genomic intervals.



## Subcommands

| Command | Description |
|---------|-------------|
| bedmap | The bedmap utility retrieves and processes genomic features from a map file that overlap with features in a reference file. It is part of the BEDOPS suite. |
| closest-features | For every element in <input-file>, find the closest elements in <query-file>. By default, this tool finds the closest features to the left and right of the input feature. |
| sort-bed | Sorts BED files. The sorted BED file is sent to standard output. Sorting is required for many BEDOPS utilities to ensure high performance. |
| starchcat | Concatenate multiple starch files into a single starch file. Note: The provided input text appears to be a system error log rather than help text; arguments are derived from standard tool documentation. |

## Reference documentation
- [BEDOPS Overview](./references/bedops_readthedocs_io_en_latest_content_overview.html.md)
- [Set Operations (bedops)](./references/bedops_readthedocs_io_en_latest_content_reference_set-operations_bedops.html.md)
- [Statistics (bedmap)](./references/bedops_readthedocs_io_en_latest_content_reference_statistics_bedmap.html.md)
- [Starch Compression](./references/bedops_readthedocs_io_en_latest_content_reference_file-management_compression_starch.html.md)
- [Sorting (sort-bed)](./references/bedops_readthedocs_io_en_latest_content_reference_file-management_sorting_sort-bed.html.md)