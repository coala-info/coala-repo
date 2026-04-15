---
name: hiline
description: HiLine is a pipeline for the alignment and classification of Hi-C short-read data. Use when user asks to align Hi-C reads, configure read-trimming for alignment accuracy, or generate alignment statistics for Hi-C experiments.
homepage: https://github.com/wtsi-hpag/HiLine
metadata:
  docker_image: "quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0"
---

# hiline

## Overview

HiLine is a specialized pipeline designed for the alignment and classification of Hi-C short-read data. It automates the workflow from raw reads to classified alignments by integrating standard tools like BWA and Samtools with a custom C++ engine for restriction site analysis. Use this skill to configure alignments, manage read-trimming for higher accuracy, and generate alignment statistics for Hi-C experiments.

## Installation and Setup

Install HiLine via Bioconda or from source:

- **Conda**: `conda install bioconda::hiline`
- **Source**: Clone the repository and run `pip install .` (requires C++ compiler, CMake, and Hyperscan dependencies).

## Core CLI Usage

The primary interface is the `HiLine` command.

- **Get Help**: Run `HiLine --help` to see all available arguments and flags.
- **Python Integration**: For scripted workflows, use the `Pipeline` class:
  ```python
  from HiLine import Pipeline
  help(Pipeline)
  ```

## Alignment Strategies

### Mapper Selection
- **bwa-mem2**: The default and recommended mapper for most tasks due to its speed and performance.
- **bwa**: Use as a fallback if memory usage is a concern.
- **minimap2**: Recommended only for quick, approximate mappings. Note that this mode filters out chimeric supplementary alignments and requires `gawk` and `perl`.

### Read Trimming
By default, HiLine performs a "read-trimming" step to improve alignment accuracy.
- **How it works**: Reads are mapped to a restriction enzyme-digested version of the reference. Portions of reads extending past restriction fragments are trimmed before a final alignment to the original reference.
- **Trade-off**: Trimming increases accuracy but halves the processing speed.
- **Disable Trimming**: Use the `--no-trim` flag to prioritize speed.

## Protocol-Specific Options

HiLine supports various Hi-C and related protocols. Ensure you specify the correct flags for your library type:
- **Arima Genomics**: Use the `arima_v2` option for Arima kits.
- **Omni-C**: Use the `omni-c` flag for sequence-independent Hi-C.
- **DNase Hi-C**: Use the `dnase` option for DNase-based protocols.

## Expert Tips

- **Index Creation**: If you only need to prepare the reference, use the "create index only" option to save time in multi-run environments.
- **Resource Management**: When using `bwa-mem2`, ensure the system has sufficient RAM, as its index files are significantly larger than standard BWA.
- **Statistics**: HiLine generates alignment statistics and plots (using Seaborn/Matplotlib). Review these to assess the quality of the Hi-C library (e.g., percentage of valid pairs vs. dangling ends).
- **Dependencies**: Ensure `samtools` (v1.10+) is in your PATH, as HiLine relies on it for duplicate marking and BAM processing.

## Reference documentation
- [HiLine Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hiline_overview.md)
- [HiLine GitHub Repository](./references/github_com_wtsi-hpag_HiLine.md)