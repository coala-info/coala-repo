---
name: cellsnake
description: Cellsnake is a command-line tool that automates Snakemake workflows for single-cell RNA sequencing analysis, including quality control, integration, and annotation. Use when user asks to process raw count matrices, perform sample integration, run Seurat-based clustering, or conduct metagenomic analysis on single-cell data.
homepage: https://github.com/sinanugur/cellsnake
---


# cellsnake

## Overview

Cellsnake is a command-line interface (CLI) tool that wraps complex Snakemake workflows for single-cell analysis. It streamlines the transition from raw count matrices (e.g., 10X Genomics output) to fully annotated and integrated datasets. Built primarily on Seurat, it automates multi-step procedures like mitochondrial gene filtering, doublet detection, dimension reduction (UMAP/tSNE), and cluster resolution optimization. It is particularly useful for researchers needing a scalable, reproducible pipeline that handles both individual samples and large-scale integrated cohorts.

## Core Workflow Patterns

### 1. Initial Processing
Always start with a `minimal` run to inspect quality control metrics before committing to heavy downstream analysis.

*   **Dry Run**: `cellsnake minimal data/ --dry` (Check detected samples and planned outputs).
*   **Minimal Run**: `cellsnake minimal data/ -j 5` (Generates QC, technical plots, and ClusTree).
*   **Standard Run**: `cellsnake standard data/` (Includes cell type annotations and enrichment).

### 2. Sample Integration
After processing individual samples, merge them into a single study object.

*   **Integrate**: `cellsnake integrate data/`
*   **Output**: Creates `integrated.rds` in the `analyses_integrated/seurat/` directory.

### 3. Analyzing Integrated Data
Once integrated, use the `integrated` command prefix to run workflows on the combined RDS file.

*   **Standard Analysis**: `cellsnake integrated standard analyses_integrated/seurat/integrated.rds --resolution 0.7`
*   **Advanced Analysis**: `cellsnake integrated advanced analyses_integrated/seurat/integrated.rds --resolution auto`

## Key CLI Arguments and Options

### Parameter Tuning
*   **Resolution**: Use `--resolution auto` for automated cluster detection or a specific float (e.g., `0.8`).
*   **Mitochondrial Filtering**: Use `--percent_mt auto` for sample-specific automated trimming or a fixed percentage like `10`.
*   **Doublet Filtering**: Enabled by default (`--doublet_filter True`).

### Visualization
*   **Gene Plots**: Generate publication-ready plots for specific markers:
    `cellsnake integrated standard <file.rds> --gene AHSP`
*   **Batch Genes**: Provide a text file with one gene per line:
    `cellsnake integrated standard <file.rds> --gene markers.txt`

### Metagenomics (Kraken2)
If you have Kraken2 databases, Cellsnake can perform microbiome analysis on the "unmapped" reads from Cellranger.
*   **Command**: `cellsnake standard data/ --kraken_db_folder /path/to/kraken_db`
*   **Refinement**: Use `--confidence 0.5` and `--min_hit_groups 2` to reduce false positives.

## Expert Tips

*   **Resource Management**: Use `-j` or `--jobs` to specify CPU cores. For large datasets, ensure you provide enough memory if running via Docker/Podman (e.g., `-m 20g`).
*   **Resolution Selection**: Run the `clustree` mode first. Inspect the ClusTree plot in the `technicals` folder to identify the resolution where clusters remain stable before running the `advanced` workflow.
*   **Metadata Integration**: For differential expression between groups (e.g., Control vs. Treatment), provide a metadata CSV:
    `cellsnake integrated standard <file.rds> --metadata metadata.csv --metadata_column condition`
*   **Stalled Jobs**: If a run is interrupted, use the `--unlock` flag to rescue the Snakemake working directory.
*   **Cleanup**: Use `--remove` to delete output files and restart a pipeline without affecting your raw input data.



## Subcommands

| Command | Description |
|---------|-------------|
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |
| cellsnake | Main cellsnake executable |

## Reference documentation
- [Options and Arguments](./references/cellsnake_readthedocs_io_en_latest_options.html.md)
- [Quick start example](./references/cellsnake_readthedocs_io_en_latest_quickstart.html.md)
- [Metagenomics analysis](./references/cellsnake_readthedocs_io_en_latest_kraken.html.md)
- [Example run on Fetal Brain dataset](./references/cellsnake_readthedocs_io_en_latest_fetalbrain.html.md)