---
name: cytosnake
description: CytoSnake is a command-line tool that orchestrates reproducible Snakemake workflows for processing high-dimensional cell morphology data. Use when user asks to initialize morphology projects, link plate-based metadata, or execute standardized workflows like feature annotation and aggregation.
homepage: https://github.com/WayScience/CytoSnake
---


# cytosnake

## Overview
CytoSnake is a specialized command-line interface (CLI) tool designed to streamline the processing of high-dimensional cell morphology data. It acts as an orchestrator for Snakemake workflows, ensuring that the transition from raw feature extraction to refined data profiles is reproducible, scalable, and modular. Use this skill to navigate the setup of morphology pipelines, handle plate-based metadata, and execute standard analytical workflows like feature annotation and aggregation.

## Installation and Setup
To get started with CytoSnake, ensure it is installed via the bioconda channel. Using `mamba` is recommended for faster dependency resolution.

- **Install**: `conda install -c bioconda cytosnake`
- **Verify**: `cytosnake help`

## Core Workflow Execution
The CytoSnake workflow follows a two-step process: initialization and execution.

### 1. Project Initialization
The `init` command sets up the necessary directory structure and links your data and metadata.

- **Basic Command**: `cytosnake init -d <DATA_FILES> -m <METADATA_DIR>`
- **Handling Multiple Platemaps**: If your dataset contains multiple platemap files, use the `-b` flag to specify the barcode logic: `cytosnake init -d <FILES> -m <METADATA_DIR> -b <BARCODE>`
- **Input Data**: Typically consists of single-cell feature files (e.g., from CellProfiler or DeepProfiler).

### 2. Running Workflows
Once initialized, you can trigger specific workflows. CytoSnake currently supports several standard pipelines:

- **Execute Workflow**: `cytosnake run <WORKFLOW_NAME>`
- **Common Workflows**:
    - `cp_process`: Standard processing for CellProfiler-derived features.
    - `cp_process_singlecells`: Specialized workflow for single-cell level analysis.
    - `dp_process`: Processing for DeepProfiler-derived features.

## CLI Best Practices
- **Directory Management**: Always run `cytosnake init` from the root of your intended project directory. CytoSnake creates internal configurations that expect a consistent relative pathing.
- **Metadata Alignment**: Ensure your metadata directory contains the necessary `.csv` or `.txt` files that map wells to treatments. The `annotate` step within workflows relies on these mappings.
- **Workflow Inspection**: Before running a full pipeline, use `cytosnake help` to view available subcommands and ensure your environment is correctly configured.
- **Resource Allocation**: Since CytoSnake is powered by Snakemake, it inherits Snakemake's ability to handle local or cluster-based execution. Ensure your environment has sufficient memory for high-dimensional data aggregation.

## Reference documentation
- [CytoSnake GitHub Repository](./references/github_com_WayScience_CytoSnake.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cytosnake_overview.md)