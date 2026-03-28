---
name: batch_brb
description: batch_brb automates a two-way reciprocal BLAST process to identify orthologous sequences between different organisms. Use when user asks to identify orthologs, perform best reciprocal BLAST, or automate sequence alignment and tree generation for divergent sequences.
homepage: https://github.com/erin-r-butterfield/batch_brb
---

# batch_brb

## Overview

`batch_brb` is a command-line tool designed to overcome the limitations of manual ortholog searching, particularly when dealing with divergent sequences or organisms not well-represented in standard databases. It automates a two-way BLAST process: first searching query sequences against a target database, then performing a reverse BLAST of those hits back against the original source organism. Sequences are confirmed as orthologs only when these hits match reciprocally. This tool is especially useful for researchers needing to maintain high flexibility in hit selection criteria (coverage and hit count) while processing moderate to large datasets.

## Installation and Setup

The tool is distributed via Bioconda. To initialize the environment:

```bash
# Create and activate the environment
conda create -n batch_brb batch_brb
conda activate batch_brb

# Run the setup script in your desired working directory
batch_brb_setup
```

## Core Workflow

The Best Reciprocal BLAST procedure follows these logic steps:

1.  **Forward BLAST**: Search query sequences against a user-created database.
2.  **Filtering**: Extract the top *x* hits per query per organism, filtered by a minimum query coverage *y*.
3.  **Reverse BLAST**: Search the extracted hits back against the genome/proteome of the original query sequences.
4.  **Reciprocal Validation**: Identify matches where the reverse BLAST top hit corresponds to the original query.
5.  **Phylogeny**: Automate sequence alignment and tree generation using FastTree.

## CLI Best Practices

*   **Database Preparation**: Ensure your target databases are properly formatted for BLAST+ before running the batch process.
*   **Hit Selection (x)**: Start with a lower number of hits (e.g., top 1-5) to reduce noise, increasing only if searching for complex gene families or highly divergent sequences.
*   **Coverage Filtering (y)**: Use a coverage threshold (e.g., 50-70%) to ensure hits represent functional orthologs rather than isolated conserved domains.
*   **Manual Verification**: Because `batch_brb` is designed for maximum coverage, always perform a post-run analysis of the output to exclude potential paralogs or "mishits" that passed the reciprocal filter.
*   **Phylogenetic Analysis**: The tool integrates with FastTree; ensure your input sequences are of sufficient quality and length for meaningful tree topology.



## Subcommands

| Command | Description |
|---------|-------------|
| Rscript | Wrapper scripts for batch correction. |
| Rscript batch_correction_docker_wrapper.R | Wrapper script for batch correction, with options to use LOESS-based methods. |
| Rscript batch_correction_docker_wrapper.R | Wrapper script for batch correction, can call different underlying batch correction methods. |

## Reference documentation

- [batch_brb GitHub Repository](./references/github_com_erin-r-butterfield_batch_brb_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_batch_brb_overview.md)