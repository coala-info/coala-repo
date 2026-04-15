---
name: nanocompore
description: Nanocompore identifies RNA modifications by comparing raw nanopore signal distributions between control and test samples. Use when user asks to detect RNA modifications from dRNA-Seq data, collapse eventalign data, or perform comparative signal analysis between biological replicates.
homepage: https://github.com/tleonardi/nanocompore
metadata:
  docker_image: "quay.io/biocontainers/nanocompore:1.0.4--pyhdfd78af_0"
---

# nanocompore

## Overview
Nanocompore is a bioinformatics suite designed to detect RNA modifications by identifying differences in the raw ionic current signal from Nanopore dRNA-Seq data. Instead of relying on basecalling errors, it performs a comparative analysis of signal distributions (intensity and dwell time) between a control sample and a test sample. It is most effective when used with at least two biological replicates per condition to provide statistical robustness.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda install -c bioconda nanocompore
```

## Core Workflow and CLI Patterns

The Nanocompore pipeline typically follows a three-step process after initial alignment and signal-to-sequence mapping (usually via `nanopolish eventalign`).

### 1. Collapsing Eventalign Data
Before comparison, the raw eventalign output must be collapsed to summarize signal features per k-mer position.
*   **Command**: `nanocompore eventalign_collapse`
*   **Key Input**: The output file from `nanopolish eventalign`.
*   **Optimization**: Use the `--selected_refs` option to limit analysis to specific transcripts of interest, which significantly reduces processing time and memory usage.

### 2. Sample Comparison
This is the core statistical engine that compares two conditions.
*   **Command**: `nanocompore sampcomp`
*   **Logic**: It compares two sets of replicates (Label 1 vs Label 2).
*   **Advanced Options**:
    *   Use `--read_level_results` to save results for individual reads rather than just the aggregate site level.
    *   Use `--ignored_refs` to exclude highly variable or non-informative transcripts (e.g., mitochondrial RNA or spike-ins) from the statistical correction.

### 3. Visualization and Post-processing
After the comparison, use the plotting subcommands to validate hits.
*   **Command**: `nanocompore plotting`
*   **Common Plots**:
    *   **GMM Plots**: Visualize the Gaussian Mixture Model fits for specific k-mers to see how the signal distribution shifts between conditions.
    *   **Manhattan/Volcano Plots**: Identify significant modification sites across the transcriptome.

## Expert Tips and Best Practices

*   **Replicate Consistency**: Always aim for at least 2 replicates per condition. Nanocompore uses the variance between replicates to distinguish true modification signals from stochastic noise.
*   **Reference Preparation**: Ensure your reference transcriptome is well-annotated. If using genomic coordinates, provide a GTF file during the post-processing stage for accurate genomic conversion.
*   **Signal Normalization**: Nanocompore handles internal normalization, but ensure that the initial `nanopolish` steps were performed using the same model parameters for all samples to avoid batch effects.
*   **Handling Empty Results**: If the post-processor returns no results, check the log files for "transactions with no data." This often indicates a mismatch between the transcript IDs in the eventalign file and the reference provided.

## Reference documentation
- [Nanocompore GitHub Repository](./references/github_com_tleonardi_nanocompore.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nanocompore_overview.md)
- [Recent Updates and Subcommands](./references/github_com_tleonardi_nanocompore_commits_master.md)