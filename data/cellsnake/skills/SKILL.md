---
name: cellsnake
description: cellsnake is a Snakemake-based command-line tool designed to streamline and automate single-cell RNA sequencing (scRNA-seq) analysis.
homepage: https://github.com/sinanugur/cellsnake
---

# cellsnake

## Overview

cellsnake is a Snakemake-based command-line tool designed to streamline and automate single-cell RNA sequencing (scRNA-seq) analysis. It wraps complex bioinformatic pipelines into simple commands, handling tasks from initial quality control and filtering to cluster detection and visualization. It is ideal for researchers seeking a reproducible, "batteries-included" approach to processing single-sample data or integrating multiple datasets using established frameworks like Seurat.

## Core Workflows

cellsnake operates using specific "modes" depending on the stage of your analysis:

- **Standard Workflow**: The primary entry point for processing raw data folders.
  `cellsnake standard <data_folder>`
- **Integration**: Used to merge multiple samples that have already been processed individually.
  `cellsnake integrate <data_folder>`
- **Integrated Analysis**: Used to run downstream analysis on an already integrated RDS object.
  `cellsnake integrated standard <integrated_rds_file>`
- **Minimal/Clustree**: Useful for quickly testing parameters or determining optimal clustering resolution.
  `cellsnake integrated minimal <integrated_rds_file>`

## Common CLI Patterns

### Initial Setup
Before running your first analysis, ensure all required R dependencies are present:
`cellsnake --install-packages`

### Processing Single or Batch Samples
If a directory containing multiple datasets is provided as the input, cellsnake automatically enables batch mode.
`cellsnake standard ./my_data_dir/`

### Adjusting Filtering and Clustering
Fine-tune the analysis by overriding default QC and clustering parameters:
- **Mitochondrial Threshold**: `--percent_mt 5` (default is 10; use `auto` for automated detection).
- **Resolution**: `--resolution 0.5` (default is 0.8; use `auto` for automated selection, though this is slower).
- **Feature Limits**: `--min_features 500 --max_features 4000`

### Differential Expression and Metadata
To perform differential expression analysis between groups, provide a metadata file:
`cellsnake standard ./data/ --metadata metadata.csv --metadata_column condition`

## Expert Tips

- **Resolution Selection**: Run the `clustree` command first to visualize how clusters split at different resolutions. This helps you pick the most stable `--resolution` value for your final `standard` run.
- **Template Generation**: Use `cellsnake --generate-template` to create boilerplate metadata and configuration files. This ensures your CSV headers and formatting match what the tool expects.
- **Dry Runs**: Use the `--dry` flag to see which steps Snakemake will execute without actually running the heavy computation.
- **Resource Management**: If a run is interrupted, use the `--unlock` flag to clear the directory lock before restarting.
- **Apple Silicon (M1/M2/M3)**: If installing via Conda on Mac, you must force the `osx-64` architecture for compatibility with certain R dependencies:
  `CONDA_SUBDIR=osx-64 mamba create -n cellsnake -c bioconda -c conda-forge cellsnake`

## Reference documentation
- [cellsnake Overview](./references/anaconda_org_channels_bioconda_packages_cellsnake_overview.md)
- [cellsnake GitHub Repository](./references/github_com_sinanugur_cellsnake.md)