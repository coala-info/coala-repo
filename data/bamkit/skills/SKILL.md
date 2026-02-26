---
name: bamkit
description: Bamkit provides a suite of Python utilities for specialized BAM file transformations such as header sanitization, read group management, and flag correction. Use when user asks to sanitize BAM headers, filter reads by read group, fix bitwise flags, convert secondary alignments to supplementary, or convert BAM files to FASTQ.
homepage: https://github.com/hall-lab/bamkit
---


# bamkit

## Overview
The `bamkit` suite provides a collection of Python-based utilities designed for common yet specific BAM file transformations. Unlike general-purpose tools like samtools, `bamkit` offers targeted scripts for tasks like header sanitization, read group management, and flag correction. It is ideal for preparing BAM files for downstream analysis where header consistency or specific flag states (like secondary vs. supplementary) are required.

## Tool-Specific Instructions

### Header Manipulation
*   **bamcleanheader.py**: Use this to sanitize BAM headers. It is specifically designed to handle cases where SQ lines are missing or problematic.
    *   *Pattern*: `python bamcleanheader.py <input.bam> [input2.bam ...]`
    *   *Note*: While it supports multiple positional arguments for speed, standard practice is to process files individually unless batching for specific pipeline requirements.
*   **bamheadrg.py**: Use this to extract or manipulate read group information directly from the BAM header.

### Read and Flag Management
*   **bamfilterrg.py**: Use this to filter a BAM file based on specific Read Groups (RG).
*   **bamfixflags.py**: Use this to correct or update bitwise flags in a BAM file. This is often necessary after certain alignment or post-processing steps that leave flags in an inconsistent state.
*   **sectosupp**: A specialized utility to convert secondary alignment flags to supplementary alignment flags. This is critical for tools that strictly differentiate between the two or require supplementary flags for structural variant calling.
*   **bamgroupreads.py**: Use this to group reads based on specific criteria, often used in preparation for consensus calling or unique molecular identifier (UMI) processing.

### Conversion and Metadata
*   **bamtofastq.py**: A robust script for converting BAM files back to FASTQ format. It is optimized for handling various pysam versions and edge cases like empty CIGAR strings.
*   **bamlibs.py**: Use this to list the libraries present in a BAM file based on the header metadata.

## Best Practices
*   **Pysam Dependency**: Ensure `pysam` is installed in the environment, as these scripts are Python wrappers around the pysam library.
*   **Streaming**: Most `bamkit` tools are designed to work with standard streams. You can often pipe samtools output directly into these scripts.
*   **Header Validation**: If a tool fails due to header issues, run `bamcleanheader.py` first to ensure the BAM file meets the expected format requirements.

## Reference documentation
- [bamkit Overview](./references/anaconda_org_channels_bioconda_packages_bamkit_overview.md)
- [bamkit Repository Structure](./references/github_com_hall-lab_bamkit.md)
- [bamkit Functional Commits](./references/github_com_hall-lab_bamkit_commits_master.md)