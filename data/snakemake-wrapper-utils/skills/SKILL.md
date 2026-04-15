---
name: snakemake-wrapper-utils
description: This library provides utility functions to abstract repetitive logic and manage resources within Snakemake wrappers. Use when user asks to calculate Java heap memory from cluster resources, parse command-line options for bioinformatics tools, or infer file formats from extensions.
homepage: https://github.com/snakemake/snakemake-wrapper-utils
metadata:
  docker_image: "quay.io/biocontainers/snakemake-wrapper-utils:0.8.0--pyhdfd78af_0"
---

# snakemake-wrapper-utils

## Overview

snakemake-wrapper-utils is a specialized Python library that serves as the backbone for the official Snakemake Wrapper Repository. It abstracts repetitive logic found in bioinformatics pipelines, such as calculating Java heap memory from cluster resources, parsing genomic regions for samtools/bcftools, and handling temporary file movements. This skill helps developers implement these utilities to create robust, portable, and standardized wrappers that interact correctly with Snakemake's resource and parameter objects.

## Core Utilities and Implementation Patterns

### Memory Management for Java and Resource-Intensive Tools
One of the most critical functions is managing the gap between requested cluster memory and actual tool usage.

- **Standard Memory Deduction**: Use `get_mem()` to calculate the memory available for a tool (like Java's `-Xmx`). By default, it deducts 20% from `resources.mem_mb` to provide a safety buffer for the JVM or container overhead.
- **Overriding Overhead**: If a tool is particularly memory-hungry or efficient, use `params.java_mem_overhead_mb` in the Snakemake rule to manually adjust the deduction.
- **Default Fallbacks**: Always ensure a fallback is provided in the wrapper code to prevent execution failure when `resources.mem_mb` is not explicitly defined by the user.

### Standardized Tool Option Parsing
The library provides helpers to convert Snakemake `input`, `output`, and `params` into command-line flags for common bioinformatics suites.

- **Samtools & Bcftools**: Use `get_samtools_opts()` and `get_bcftools_opts()`. These functions automatically look for:
    - `input.index` or `params.region_file` to construct `--regions-file` or `-t` arguments.
    - `threads` from `snakemake.threads`.
    - Extra parameters from `params.extra`.
- **GATK Utilities**: Use the GATK-specific helpers to handle common I/O files, ensuring that reference genomes and intervals are passed in the format GATK expects (e.g., `-R` for references).

### File Format and Extension Handling
To make wrappers more flexible, use the inference utilities to detect formats regardless of compression.

- **Format Inference**: Use `infer_out_format()` to determine if an output should be BAM, CRAM, or SAM based on the extension.
- **Compression Awareness**: The library can parse file formats while ignoring compression extensions (like `.gz` or `.bz2`), allowing for more robust logic when piping data between tools.
- **FASTA Extensions**: The library maintains a standardized list of recognized FASTA extensions (including `.fa`, `.fasta`, `.fna`) to ensure reference files are identified correctly.

### Command Line Argument Manipulation
When building complex command strings in a wrapper:

- **Argument Positioning**: Use the utility functions to find the index or position of specific arguments. This is useful for wrappers that need to inject or modify flags within a user-provided `params.extra` string.
- **Temporary to Final Destination**: Implement the "move temp output" logic for tools that do not natively support writing to a specific path or require a local temporary directory for performance.

## Expert Tips for Wrapper Development

- **Conda Environment**: Any wrapper utilizing this library must include `snakemake-wrapper-utils` in its `environment.yaml`.
- **Thread Consistency**: Always map `snakemake.threads` to the tool's thread flag (e.g., `-@` for samtools) via the utility functions to ensure the tool respects the cluster allocation.
- **Error Prevention**: Use the library's built-in checks for missing indices. For example, if a regions file is specified but no index is provided, the utility can trigger a clear error message before the tool starts a long-running process.

## Reference documentation
- [snakemake-wrapper-utils GitHub Overview](./references/github_com_snakemake_snakemake-wrapper-utils.md)
- [Bioconda Package Metadata](./references/anaconda_org_channels_bioconda_packages_snakemake-wrapper-utils_overview.md)
- [Recent Feature Commits](./references/github_com_snakemake_snakemake-wrapper-utils_commits_master.md)