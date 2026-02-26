---
name: simpleaf
description: simpleaf is a high-level framework that simplifies single-cell RNA-seq processing by providing a unified interface for reference indexing and sample quantification. Use when user asks to build an expanded reference index, perform single-cell quantification, or process raw sequencing data into count matrices.
homepage: https://github.com/COMBINE-lab/simpleaf
---


# simpleaf

## Overview

simpleaf is a high-level framework designed to simplify the single-cell RNA-seq processing pipeline. It encapsulates complex multi-step workflows into two primary operations: building an expanded reference index and performing sample quantification. By acting as an intelligent wrapper, it allows users to leverage the speed and memory efficiency of Rust-based bioinformatics tools (like piscem and alevin-fry) through a unified, user-friendly command-line interface similar to commercial solutions like Cell Ranger.

## Core CLI Commands

The simpleaf workflow is centered around two main commands:

- **`simpleaf index`**: Creates an expanded reference for quantification. This command handles the complexity of generating the necessary index files from genome and transcriptome data.
- **`simpleaf quant`**: Performs the actual quantification of a sample, transforming raw sequencing data into count matrices.

## System Configuration & Best Practices

To ensure stable and performant execution, follow these environment-specific guidelines:

### File Handle Limits
simpleaf and its underlying tools often open many files simultaneously. You must ensure your shell's file handle limit is sufficient before running the tool.
- **Requirement**: Set the limit to at least 2048.
- **Command**: `ulimit -n 2048`

### Storage and File Systems
The indexing process is I/O intensive and creates many small temporary files.
- **Avoid Networked File Systems (NFS)**: Running `simpleaf index` with working or output directories on an NFS (common in HPC environments) can slow the process down by an order of magnitude.
- **Recommended Workflow**: Set the output and working directories to a local disk (e.g., `/scratch` or `/tmp`). Once the index is built, copy the final result to your networked storage.

### Backend Selection
simpleaf supports multiple mapping backends, primarily **piscem** and **salmon**.
- **Preferred Backend**: Use `piscem`. It is faster, more memory-efficient, and is the primary focus of current development.
- **Troubleshooting**: If `piscem` index construction fails, verify your `ulimit` settings first.

## Installation

The recommended way to install simpleaf is via bioconda:
```bash
conda install bioconda::simpleaf
```
It can also be installed from source or via `crates.io`. Ensure that `alevin-fry`, `piscem` (or `salmon`), and `wget` are available in your PATH.

## Reference documentation
- [simpleaf GitHub Repository](./references/github_com_COMBINE-lab_simpleaf.md)
- [simpleaf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_simpleaf_overview.md)