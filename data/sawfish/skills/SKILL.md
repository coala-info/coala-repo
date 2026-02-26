---
name: sawfish
description: "Sawfish identifies structural and copy number variants in HiFi sequencing data. Use when user asks to discover structural variants, call copy number variants, or jointly call variants across samples."
homepage: https://github.com/PacificBiosciences/sawfish
---


# sawfish

## Overview

Sawfish is a powerful tool designed for the sophisticated analysis of HiFi sequencing data. It excels at jointly identifying both structural variants (SVs) and copy number variants (CNVs) within a genome. This means it can pinpoint large-scale changes in DNA structure, such as deletions, insertions, duplications, and inversions, while simultaneously detecting variations in the number of copies of specific DNA segments. Sawfish is particularly useful for germline variant discovery and for analyzing these variations across multiple samples to understand population-level genetic differences or familial relationships.

## Usage Instructions

Sawfish operates through a command-line interface, with a streamlined workflow for discovering and jointly calling variants. The primary commands involve `discover` and `joint-call` steps.

### Core Workflow

1.  **Discovery**: This step identifies potential structural variants within individual samples.
2.  **Joint Calling**: This step genotypes the discovered variants across multiple samples, providing a unified view of SVs and CNVs.

### Key Command-Line Patterns

Sawfish is designed for a simple, multi-threaded workflow. The general structure involves running the `discover` command for each sample, followed by a `joint-call` command that aggregates the results.

**Basic Discovery Command Structure:**

```bash
sawfish discover --reads <path/to/reads.fastq.gz> --output-dir <output_directory> --threads <number_of_threads>
```

*   `--reads`: Path to the input HiFi sequencing reads (FASTQ format).
*   `--output-dir`: Directory to store the discovery results for the sample.
*   `--threads`: Number of CPU threads to use for the discovery process.

**Basic Joint Calling Command Structure:**

```bash
sawfish joint-call --input-dirs <dir1>,<dir2>,... --output-dir <output_directory> --threads <number_of_threads>
```

*   `--input-dirs`: Comma-separated list of output directories from the `discover` step for each sample.
*   `--output-dir`: Directory to store the final joint-called variants.
*   `--threads`: Number of CPU threads to use for the joint calling process.

### Important Considerations and Expert Tips

*   **Minimum Variant Size**: The minimum variant size is 35 bases by default, but this is configurable.
*   **Breakpoint-based SVs**: These are reported as deletions, insertions, duplications, and inversions if supported by both breakpoint and depth patterns. Otherwise, only the breakpoint is reported.
*   **Copy Number Variants (CNVs)**: These are reported as deletions and duplications.
*   **Unified View**: Sawfish merges redundant calls into single variants that describe both breakpoint and copy number details, providing a comprehensive view.
*   **Local Haplotype Modeling**: For high SV discovery and genotyping accuracy, Sawfish models and genotypes breakpoint-based structural variants as local haplotypes.
*   **GC-bias Correction**: Integrated copy number segmentation includes GC-bias correction for accurate CNV calling and improved classification of large SVs.
*   **Output Formats**: While not explicitly detailed in the provided documentation, expect standard genomic variant formats like VCF for SVs and potentially BED or similar for CNVs. Refer to the official documentation for specific output file details.
*   **Configuration**: Explore command-line options for fine-tuning parameters such as minimum variant size, threading, and output details. Use `sawfish --help` or `sawfish discover --help` and `sawfish joint-call --help` for a full list of available arguments.

## Reference documentation

*   [Sawfish Overview](./references/anaconda_org_channels_bioconda_packages_sawfish_overview.md)
*   [Sawfish GitHub Repository](./references/github_com_PacificBiosciences_sawfish.md)