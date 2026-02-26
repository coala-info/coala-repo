---
name: capcruncher
description: CapCruncher is a bioinformatics suite designed to process and analyze Capture-C, Tri-C, and Tiled-C sequencing data. Use when user asks to initialize projects, generate pipeline configurations, or execute data processing workflows on local workstations and HPC clusters.
homepage: https://github.com/sims-lab/CapCruncher.git
---


# capcruncher

## Overview

CapCruncher is a specialized bioinformatics suite designed to handle the unique filtering requirements of Capture-C, Tri-C, and Tiled-C datasets, which differ significantly from standard Hi-C workflows. It automates the path from raw FASTQ files to downstream outputs like contact matrices, visualization plots, and UCSC Genome Browser track hubs. This skill assists in navigating the command-line interface (CLI) to initialize projects, generate environment-specific configurations, and manage pipeline execution on both local workstations and High-Performance Computing (HPC) clusters.

## Command Line Usage

The `capcruncher` tool uses a subcommand-based interface. Always use the `--help` flag at any level to see available options.

### Configuration

Before running the pipeline, you must generate a configuration file. It is highly recommended to use the interactive generator rather than manual creation.

- **Interactive Setup**: Run `capcruncher pipeline-config` and follow the terminal prompts to define your project parameters.
- **Help for Config**: `capcruncher pipeline-config --help`

### Pipeline Execution

The pipeline expects FASTQ files and the generated configuration file to be present in the current working directory.

- **Local Execution**: Use the `--cores` flag to specify CPU allocation.
  `capcruncher pipeline --cores 8`
- **HPC Execution (SLURM)**: Use the `--profile` flag to leverage cluster workload managers.
  `capcruncher pipeline --cores 8 --profile slurm --use-singularity`

## Best Practices and Expert Tips

- **Session Management**: Pipeline runs are often long-lived. Always execute the pipeline within a `tmux` session or use `nohup` to prevent the process from terminating if your SSH connection drops.
  - *Example*: `nohup capcruncher pipeline --cores 16 --profile slurm &`
- **Dependency Management**: When working on shared clusters, use the `--use-singularity` or `--use-conda` flags within the pipeline command to ensure a reproducible environment without manual dependency installation.
- **Subcommand Discovery**: If you are unsure of specific filtering parameters or output formats, explore the CLI reference via `capcruncher <subcommand> --help`.
- **Platform Support**: Note that CapCruncher is currently optimized for Linux environments.

## Reference documentation

- [CapCruncher GitHub Repository](./references/github_com_sims-lab_CapCruncher.md)
- [CapCruncher Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_capcruncher_overview.md)