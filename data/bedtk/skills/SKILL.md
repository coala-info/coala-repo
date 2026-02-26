---
name: bedtk
description: bedtk is a high-performance toolkit designed for fast and memory-efficient genomic interval manipulation across BED, VCF, and PAF files. Use when user asks to filter intervals, find intersections, sort records, merge overlapping regions, or calculate breadth of coverage.
homepage: https://github.com/lh3/bedtk
---


# bedtk

## Overview
bedtk is a lightweight, high-performance toolkit designed for interval manipulation. While it does not aim to match the full feature set of bedtools, it is significantly faster and more memory-efficient. It is optimized for core genomic interval operations and supports VCF and PAF files in addition to standard BED formats. A key advantage is its ability to perform complex operations like sorting and merging in a single pass, reducing the need for complex Unix pipes.

## Command Line Usage

### Filtering and Intersection
The `flt` and `isec` commands are the primary tools for finding overlaps or differences between files.

*   **Basic Filtering**: Filter a BED or VCF file against another.
    ```bash
    bedtk flt annotation.bed.gz regions.bed.gz
    ```
*   **Inverse Filtering**: Output records that do *not* overlap the second file.
    ```bash
    bedtk flt -v annotation.bed.gz regions.bed.gz
    ```
*   **Windowed Filtering**: Find records within a specific distance (e.g., 100bp) of the target intervals.
    ```bash
    bedtk flt -w 100 annotation.bed.gz target.vcf.gz
    ```
*   **Intersection**: Perform a standard intersection. Unlike many tools, `bedtk` does not require the input files to be pre-sorted.
    ```bash
    bedtk isec file1.bed.gz file2.bed.gz
    ```

### Sorting and Merging
bedtk handles interval organization efficiently, including custom chromosome ordering.

*   **Standard Sort**:
    ```bash
    bedtk sort input.bed.gz
    ```
*   **Custom Chromosome Order**: Sort based on a specific list of chromosomes provided in a text file.
    ```bash
    bedtk sort -s chr_list.txt input.bed.gz
    ```
*   **Merging**: Combine overlapping records. This can be performed on unsorted files.
    ```bash
    bedtk merge input.bed.gz
    ```

### Coverage and Analysis
*   **Breadth of Coverage**: Calculate the total number of bases covered by intervals.
    ```bash
    bedtk cov regions.bed.gz mask.bed.gz
    ```

## Expert Tips and Best Practices
*   **Avoid Pipes**: Whenever possible, use bedtk's internal logic to combine steps. For example, `isec` and `merge` can often handle unsorted input, saving the time usually spent on `sort | tool`.
*   **Memory Efficiency**: Use bedtk when working on machines with limited RAM or when processing extremely large datasets (e.g., whole-genome VCFs) where `bedtools` might hit memory limits.
*   **File Formats**: While named "bedtk," the tool is robust with VCF files. Use the `-p` flag with `flt` if you are specifically working with PAF (Pairwise mApping Format) files.
*   **CLI Stability**: Note that the CLI is under active development; always verify the specific version's help output (`bedtk` with no arguments) if a command behaves unexpectedly.

## Reference documentation
- [bedtk GitHub Repository](./references/github_com_lh3_bedtk.md)
- [bedtk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bedtk_overview.md)