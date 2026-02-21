---
name: sunbeamlib
description: Sunbeam is a Snakemake-based framework designed for end-to-end metagenomic data processing.
homepage: https://github.com/sunbeam-labs/sunbeam
---

# sunbeamlib

## Overview
Sunbeam is a Snakemake-based framework designed for end-to-end metagenomic data processing. It streamlines the transition from raw sequencing reads to annotated contigs and taxonomic profiles by providing a modular environment. This skill assists in managing Sunbeam projects, executing core modules for quality control or assembly, and integrating community extensions to expand the pipeline's capabilities.

## Core CLI Patterns

### Project Initialization
Before running the pipeline, you must initialize a project directory. This creates the necessary structure and configuration files.
- `sunbeam init <project_path>`: Creates a new project directory at the specified path.
- `sunbeam init . --data_fp <path_to_fastqs>`: Initializes a project in the current directory using a specific folder containing raw sequencing data.

### Executing the Pipeline
Sunbeam uses a "run" command to trigger Snakemake workflows.
- `sunbeam run all`: Executes the entire default pipeline (QC, Assembly, Annotation).
- `sunbeam run qc`: Runs only the quality control steps, including adapter trimming and host read removal.
- `sunbeam run assembly`: Executes the de novo assembly module using Megahit.
- `sunbeam run <target> --cores <N>`: Runs a specific target using N parallel CPU cores.

### Managing Extensions
Sunbeam is designed to be extensible. You can add new genomic tools as "sbx" extensions.
- `sunbeam extend <github_url>`: Clones and integrates a new extension into the current Sunbeam installation.
- `sunbeam extend --list`: Displays currently installed extensions.

## Expert Tips and Best Practices

- **Targeted Execution**: Instead of running the full pipeline, use specific targets like `sbx_kraken` or `sbx_mapping` if you only need taxonomic profiling or reference mapping.
- **Resource Allocation**: Since Sunbeam is built on Snakemake, always specify `--cores` to match your environment's capabilities to prevent the pipeline from defaulting to single-threaded execution.
- **Dry Runs**: Use the standard Snakemake flag `-n` (e.g., `sunbeam run all -n`) to perform a dry run. This allows you to verify the execution plan and file paths before committing computational resources.
- **Handling Host Reads**: Ensure your host genome database is properly indexed and specified in the configuration to maximize the efficiency of the host-removal step during QC.

## Reference documentation
- [Sunbeam GitHub Overview](./references/github_com_sunbeam-labs_sunbeam.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_sunbeamlib_overview.md)