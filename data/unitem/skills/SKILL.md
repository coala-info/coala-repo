---
name: unitem
description: UniteM is a specialized toolkit designed to improve the quality of metagenomic bins by leveraging ensemble strategies.
homepage: https://github.com/dparks1134/UniteM
---

# unitem

## Overview
UniteM is a specialized toolkit designed to improve the quality of metagenomic bins by leveraging ensemble strategies. Instead of relying on a single binning algorithm, UniteM allows you to combine outputs from multiple methods to produce a consolidated, non-redundant set of genomes. It features an internal quality assessment system that uses HMMs and marker genes (aligned with GTDB species representatives) to estimate completeness and contamination without requiring external tools like CheckM in newer versions.

## Installation and Setup
The tool is primarily distributed via Bioconda and PyPI.
- **Conda**: `conda install bioconda::unitem`
- **Pip**: `pip install unitem`

## Core Workflows and CLI Patterns

### Getting Help
Access the global help menu or specific command help:
- `unitem -h`
- `unitem <command> -h` (e.g., `unitem bin -h`)

### Ensemble Binning
The primary function of UniteM is to take multiple bin sets and generate an optimized collection.
- **Input**: Typically requires directories containing FASTA files from different binning runs.
- **Marker Gene Identification**: UniteM uses Prodigal and HMMER internally to identify marker genes across GTDB species representatives to estimate genome quality.

### Key Commands
While specific flags depend on the version, the general structure follows:
- `unitem bin`: The core command for running ensemble binning strategies.
- `unitem profile`: Used for profiling bins against marker sets.

## Expert Tips
- **Version Awareness**: Versions >= 1.0.0 have transitioned away from CheckM. They now use a custom marker gene approach based on GTDB. If you are following older protocols that reference CheckM, ensure you are using the updated UniteM workflow which handles quality estimation internally.
- **Marker Gene Accuracy**: Version 1.1.0+ includes HMMs from closely related protein families, which significantly improves the accuracy of marker gene annotations and subsequent quality estimates.
- **Manual Reference**: For complex parameter tuning (such as specific completeness/contamination thresholds), refer to the `unitem_manual.pdf` usually found in the GitHub repository root or installation directory.

## Reference documentation
- [UniteM GitHub Repository](./references/github_com_donovan-h-parks_UniteM.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_unitem_overview.md)