---
name: rtk2
description: The `rtk2` skill provides guidance for using the Rarefaction ToolKit, a high-performance C++ binary designed for matrix operations on Operational Taxonomic Unit (OTU) tables and gene matrices.
homepage: https://github.com/hildebra/rtk2/
---

# rtk2

## Overview
The `rtk2` skill provides guidance for using the Rarefaction ToolKit, a high-performance C++ binary designed for matrix operations on Operational Taxonomic Unit (OTU) tables and gene matrices. Use this skill to normalize microbiome datasets through rarefaction, calculate abundance using various statistical methods (mean/median), and process large-scale coverage files.

## Installation and Setup
The tool is available via Bioconda or can be compiled from source for performance-critical environments.

- **Conda**: `conda install bioconda::rtk2`
- **Source**: Clone the repository and run `make` to generate the `rtk` binary.

## Core CLI Patterns
The primary command is `rtk`. Use the following patterns for common bioinformatics workflows:

### Rarefaction of OTU Tables
Rarefaction is used to normalize samples to a consistent sequencing depth.
- **Basic Usage**: Run `rtk` followed by the input matrix.
- **Discovery**: Use `./rtk -h` to list specific flags for depth (`-d`), iterations, and output paths.
- **Compressed Inputs**: The tool natively supports `.gz` files, allowing you to process compressed OTU tables without manual decompression.

### Gene Matrix Processing (`geneMat`)
The `geneMat` subcommand is specialized for handling gene-level coverage matrices.
- **Input**: Accepts standard coverage files and `.gz` compressed inputs.
- **Functional Categories**: Use delimiter flags to handle functional categories within your matrix. This is particularly useful when your row identifiers contain metadata (e.g., "GeneID|Function").

### Abundance Calculations
When aggregating data from lower taxonomic or functional levels to higher levels:
- **Mean/Median Occurrence**: `rtk2` allows measuring abundance by mean or median at the lowest level before summing for higher-level representations. This provides a more robust estimate than simple summation in noisy datasets.

## Expert Tips
- **Memory Efficiency**: `rtk2` is written in C++ and optimized for large matrices. When working with massive datasets, prefer the compiled binary over script-based alternatives.
- **Delimiter Handling**: If your matrix uses non-standard separators (e.g., for functional annotations), check the `rtk` help output for functional delimiter flags added in version 2.09+.
- **MATAFILER Integration**: `rtk2` serves as the core binary for matrix operations within the MATAFILER pipeline. Ensure your input formats align with MATAFILER requirements if using it as part of that workflow.

## Reference documentation
- [rtk2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_rtk2_overview.md)
- [hildebra/rtk2: binary for matrix operations used in MATAFILER](./references/github_com_hildebra_rtk2.md)
- [rtk2 Commits - Subcommand and Feature History](./references/github_com_hildebra_rtk2_commits_main.md)