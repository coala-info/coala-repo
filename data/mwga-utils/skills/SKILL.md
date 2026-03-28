---
name: mwga-utils
description: The mwga-utils toolkit provides C++ utilities for post-processing and analyzing Multispecies Whole Genome Alignments in MAF format. Use when user asks to generate genomic metrics like alignability and identity, fill reference gaps in alignments, validate single coverage for quality control, or calculate alignment breadth statistics.
homepage: https://github.com/RomainFeron/mgwa_utils
---


# mwga-utils

## Overview

The `mwga-utils` toolkit is a collection of C++ utilities designed for the post-processing and analysis of Multispecies Whole Genome Alignments. It is specifically optimized for MAF files following the MultiZ output format. Use this skill to perform quality control on alignments, generate conservation-related tracks (WIG files), and ensure that alignment files represent the full extent of a reference genome.

## Installation and Setup

To use these utilities, the source must be compiled from the repository:

```bash
git clone https://github.com/RomainFeron/mwga_utils.git
cd mwga_utils
make -j 4
```
The binaries will be located in the `bin/` directory.

## Core Utilities and Usage Patterns

### 1. Generating Genomic Metrics (`metrics`)
Use this to compute per-base statistics across the reference genome. It produces `.wig` files suitable for visualization in genome browsers.

*   **Alignability**: The fraction of assemblies aligned at a specific position.
*   **Identity**: The fraction of assemblies matching the reference nucleotide.

**Command Pattern:**
```bash
bin/metrics <input.maf> -p <output_prefix> -t <threads> -n <num_assemblies>
```
*   **Expert Tip**: If the number of assemblies is known, specify it with `-n`. If set to `0` (default), the tool will attempt to calculate it from the MAF file, which may be slower for very large alignments.

### 2. Filling Reference Gaps (`missing_regions`)
MAF files often only contain aligned blocks. Use this tool to create a "complete" MAF that includes regions of the reference assembly not present in the original alignment.

**Command Pattern:**
```bash
bin/missing_regions <input.maf> <reference.fasta> > <complete_output.maf>
```
*   **Behavior**: Missing regions are assigned a score of **NA** and contain only the reference sequence.
*   **Workflow Tip**: This tool outputs to `stdout`, making it ideal for piping into compression tools like `gzip`.

### 3. Coverage Validation (`single_coverage`)
Use this for Quality Control (QC) to ensure that each sequence in the reference assembly is covered exactly once.

**Command Pattern:**
```bash
bin/single_coverage <input.maf> -t <threads>
```
*   **Output**: A table showing counts for each coverage value per contig. Use this to identify unexpected duplications or overlaps in the alignment blocks.

### 4. Alignment Statistics (`stats`)
Use this for a high-level summary of the alignment's breadth.

**Command Pattern:**
```bash
bin/stats <input.maf> -p <output_prefix>
```
*   **Primary Metric**: Currently reports the total number of base pairs (BP) aligned for each assembly included in the MAF.

## Best Practices

*   **Threading**: Both `metrics` and `single_coverage` support multi-threading via the `-t` flag. Always utilize this for chromosome-scale MAF files to significantly reduce processing time.
*   **Reference Consistency**: When using `missing_regions`, ensure the `<reference.fasta>` is the exact same assembly used as the "source" (the first sequence in MAF blocks) during the alignment process.
*   **Memory Management**: While these tools are written in C++ for efficiency, processing whole-genome MAFs can be memory-intensive. Monitor system resources when running on very large (e.g., 50+ species) alignments.



## Subcommands

| Command | Description |
|---------|-------------|
| metrics | Generate wig files with base metrics from a MAF file. |
| missing_regions | Add regions from the reference genome that are missing from a MAF file. |
| stats | Compute a series of statistics on a MAF file:         - Number of BP aligned in each assembly |

## Reference documentation
- [mwga-utils README](./references/github_com_RomainFeron_mwga-utils_blob_master_README.md)
- [mwga-utils Makefile](./references/github_com_RomainFeron_mwga-utils_blob_master_makefile.md)