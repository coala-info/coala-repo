---
name: maelstrom-core
description: "maelstrom-core extracts and normalizes depth-of-coverage data from alignment files for structural variant analysis. Use when user asks to collect depth of coverage from BAM files, normalize coverage data, or process large genomic cohorts efficiently."
homepage: https://github.com/bihealth/maelstrom-core
---

# maelstrom-core

## Overview
maelstrom-core is the high-performance Rust component of the Maelstrom structural variant analysis pipeline. It is designed to handle computationally intensive tasks that are inefficient in Python, specifically focusing on the extraction and normalization of coverage data from alignment files. Use this tool when you need to process "oceans of genomes" where speed and memory efficiency are critical for depth-of-coverage calculations.

## Command Line Usage

The primary entry point is the `maelstrom-core` binary. It utilizes a subcommand-based interface.

### Core Command: bam-collect-doc
The `bam-collect-doc` command is the primary utility for coverage analysis.

*   **Purpose**: Scans BAM files to collect depth of coverage (DOC) data.
*   **Normalization**: It includes functionality to compute normalized coverage, which is essential for comparing samples across different sequencing runs or depths.
*   **Region Support**: Supports targeted analysis of specific genomic regions.

### Common CLI Patterns
Since the tool is built with the Rust `clap` library, it follows standard GNU-style argument patterns:

*   **Help**: Access command-specific flags and arguments using:
    `maelstrom-core bam-collect-doc --help`
*   **Verbosity**: Control logging output using the verbosity flag (e.g., `-v`, `-vv`).
*   **Execution**: Ensure the environment has access to the necessary HTS libraries, as the tool depends on `rust-htslib`.

## Best Practices and Expert Tips

*   **Performance**: Use `maelstrom-core` instead of Python-based alternatives when processing large cohorts or high-depth whole-genome sequencing (WGS) data.
*   **Input Requirements**: Ensure BAM files are properly sorted and indexed. The underlying `rust-htslib` requires indices (`.bai`) for efficient region-based coverage collection.
*   **Error Handling**: If the tool crashes during region-specific collection, ensure you are using version 0.1.1 or later, as early versions had known issues with region-based processing.
*   **Memory Management**: As a Rust-based tool, it is highly efficient with memory; however, when processing many samples in parallel, monitor system resources as HTSlib can still allocate significant buffers for decompression.



## Subcommands

| Command | Description |
|---------|-------------|
| maelstrom-core | Tools for processing of NGS data |
| maelstrom-core bam-collect-doc | Create contigs with synthetic sequence |

## Reference documentation
- [Maelstrom Core README](./references/github_com_bihealth_maelstrom-core_blob_main_README.md)
- [Maelstrom Core Changelog](./references/github_com_bihealth_maelstrom-core_blob_main_CHANGELOG.md)
- [Project Configuration (Cargo.toml)](./references/github_com_bihealth_maelstrom-core_blob_main_Cargo.toml.md)