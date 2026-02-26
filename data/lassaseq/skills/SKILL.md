---
name: lassaseq
description: "lassaseq retrieves, filters, and analyzes Lassa virus genomic data to generate alignments and phylogenetic trees. Use when user asks to download Lassa virus sequences, filter data by host or geography, and perform phylogenetic analysis on L and S segments."
homepage: https://github.com/DaanJansen94/LassaSeq
---


# lassaseq

## Overview
The `lassaseq` tool is a specialized command-line utility for virologists and bioinformaticians working with Lassa virus data. It streamlines the acquisition of genomic data by providing granular filters for host type, geographic location, and sequence completeness. Beyond data retrieval, it automates the complex process of aligning sequences and generating phylogenetic trees using MAFFT, TrimAl, and IQ-TREE2, with specific logic to handle the L (Large) and S (Small) segments of the Lassa genome.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured with the necessary channels before installation.

```bash
# Configure channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Create environment and install
conda create -n lassaseq lassaseq -y
conda activate lassaseq
```

## Command Line Usage
The tool operates in two modes: **Interactive** (triggered by providing only the output directory) and **Non-Interactive** (using CLI flags).

### Core Filtering Patterns
Use these flags to refine sequence retrieval from GenBank:

*   **Genome Completeness**: Use `--genome 1` for high-quality assemblies (>99% reference length) or `--genome 2 --completeness <int>` for a custom threshold.
*   **Host Specificity**: Filter for human (`--host 1`), rodent (`--host 2`), or both (`--host 3`).
*   **Metadata Quality**: Use `--metadata 3` to ensure all downloaded sequences have both a known collection date and geographic location.
*   **Geographic Filtering**: Provide a quoted, comma-separated list: `--countries "Nigeria, Sierra Leone, Guinea"`.

### Lineage and Sublineage Analysis
Lassa virus is highly diverse. `lassaseq` allows segment-specific lineage filtering:
*   **Global Lineage**: `--lineage IV`
*   **Segment-Specific**: Use `--l_sublineage` or `--s_sublineage` to account for reassortment or specific segment evolution.

### Phylogenetic Workflow
To move beyond downloading and perform analysis, append the `--phylogeny` flag. This triggers:
1.  **Concatenation**: Merging new sequences with internal references and outgroups.
2.  **Alignment**: MAFFT alignment.
3.  **Trimming**: Automated trimming via TrimAl.
4.  **Tree Building**: IQ-TREE2 execution with 10,000 ultra-fast bootstrap replicates.

## Expert Tips
*   **Custom Exclusions**: If specific accession numbers are known to be problematic or redundant, create a text file (one accession per line) and use the `--remove <file>` flag.
*   **Custom Consensus**: Use `--consensus_L` or `--consensus_S` to provide your own reference sequences for the alignment phase.
*   **Output Inspection**: Always check `summary_Lassa.txt` in the output directory. it provides a detailed breakdown of host distribution and filtering steps which is essential for validating the dataset before publication.
*   **Segment Handling**: Remember that LASV has a bi-segmented genome. The tool will generate separate outputs for the L segment (~7.2kb) and S segment (~3.4kb).

## Reference documentation
- [LassaSeq GitHub Repository](./references/github_com_DaanJansen94_LassaSeq.md)
- [LassaSeq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lassaseq_overview.md)