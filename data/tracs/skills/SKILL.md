---
name: tracs
description: tracs estimates genetic distances between microbial samples to infer transmission chains from noisy or metagenomic data. Use when user asks to estimate genetic distance, infer transmission chains, build a reference database, align reads, calculate SNP distances, cluster samples, or visualize transmission networks.
homepage: https://github.com/gtonkinhill/tracs
---


# tracs

## Overview
`tracs` (Transmission Analysis from Complex Samples) is a specialized tool for estimating the genetic distance between microbial samples to determine how closely they are related in a transmission chain. It excels in handling "noisy" data—such as metagenomic samples or multi-strain infections—by aligning reads to multiple reference genomes. This allows it to calculate a robust lower bound for SNP distances, helping researchers identify transmission events even when sequence coverage is inconsistent.

## Installation and Dependencies
The tool is primarily distributed via Bioconda. For alignment-based workflows, several external binaries must be available in your system PATH.

```bash
# Installation via Conda
conda install bioconda::tracs

# Manual installation for latest features
pip3 install git+https://github.com/gtonkinhill/tracs
```

**Required External Tools:**
*   `samtools` (for alignment processing)
*   `minimap2` (for sequence alignment)
*   `htsbox` (required for generating alignments)

## Core Workflow and CLI Usage
The `tracs` suite is organized into several functional modules, typically accessed via the main runner or specific script runners.

### 1. Database Preparation
Before aligning samples, you must build a reference database from one or more reference genomes.
*   **Runner**: `build_db_runner.py`
*   **Tip**: Using multiple diverse reference genomes improves the accuracy of the lower-bound SNP estimate.

### 2. Alignment
Align your single-isolate or metagenomic reads against the prepared database.
*   **Runner**: `align-runner.py`
*   **Requirement**: Ensure `minimap2` and `samtools` are installed.

### 3. Distance Estimation
This is the core analytical step that uses an empirical Bayes approach to account for coverage variation.
*   **Runner**: `distance_runner.py`
*   **Output**: Pairwise SNP distances and estimated number of intermediate hosts.

### 4. Downstream Analysis
Once distances are calculated, you can cluster samples or visualize the transmission network.
*   **Clustering**: `cluster-runner.py`
*   **Thresholding**: `threshold-runner.py` (used to define transmission cutoffs)
*   **Visualization**: `plot-runner.py`

## Best Practices
*   **Metagenomic Samples**: `tracs` is specifically optimized for metagenomic data where traditional consensus-based SNP calling often fails. Use it when you suspect samples contain minor variants or multiple strains of the same species.
*   **SNP Distance Limits**: Do not use `tracs` for estimating very large evolutionary distances. It is designed for high-resolution transmission inference (small SNP distances) within an outbreak context.
*   **Reference Selection**: The tool's "lower bound" logic relies on the quality of the reference genomes provided. Always include a reference that is closely related to the outbreak strain if available.
*   **Pipeline Execution**: For most standard workflows, `pipe-runner.py` can be used to chain these steps together into a single execution.

## Reference documentation
- [tracs Overview](./references/anaconda_org_channels_bioconda_packages_tracs_overview.md)
- [tracs GitHub Repository](./references/github_com_gtonkinhill_tracs.md)