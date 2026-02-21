---
name: nextstrain-cli
description: The `nextstrain-cli` is a unified wrapper for the Nextstrain software suite, primarily Augur (for analysis) and Auspice (for visualization).
homepage: https://docs.nextstrain.org/projects/cli/
---

# nextstrain-cli

## Overview

The `nextstrain-cli` is a unified wrapper for the Nextstrain software suite, primarily Augur (for analysis) and Auspice (for visualization). It allows researchers to run complex pathogen builds consistently across different computing environments without manually managing dependencies. Use this skill to help users initialize pathogen workflows, execute Snakemake-based builds, visualize genomic data locally, and manage remote datasets on AWS S3 or Nextstrain Groups.

## Core Workflows

### 1. Environment Setup and Verification
Before running analyses, ensure the environment is correctly configured.
- **Check setup**: `nextstrain check-setup --set-default`
- **Initialize a pathogen**: `nextstrain setup <pathogen-name>` (e.g., `nextstrain setup sars-cov-2`)
- **Update components**: `nextstrain update cli` or `nextstrain update <pathogen-name>`

### 2. Running Analyses
There are two primary ways to execute builds:
- **Standardized Workflows (`run`)**: Use for routine analysis of known pathogens.
  - `nextstrain run <pathogen-name> <workflow-name> <analysis-directory>`
  - Example: `nextstrain run sars-cov-2 phylogenetic ./my-analysis`
- **Custom Builds (`build`)**: Use when you have a local `Snakefile`.
  - `nextstrain build <directory>`
  - Pass additional Snakemake arguments after the directory: `nextstrain build . --cores 4`

### 3. Visualization
To view the results of a build (Auspice JSON files):
- **View directory**: `nextstrain view <directory-with-json-files>`
- **View specific file**: `nextstrain view auspice/ncov_genomic.json`
- **Network access**: Use `--allow-remote-access` to host the visualization for other computers on your network.

### 4. Remote Data Management
- **Deploy to Nextstrain**: `nextstrain deploy nextstrain.org/groups/my-team/ncov auspice/*.json`
- **S3 Operations**: Use `nextstrain remote upload/download/list` for managing files in S3 buckets.

## Runtime Selection
Nextstrain CLI abstracts the underlying environment. You can force a specific runtime using flags:
- `--docker`: (Default) Uses Docker containers.
- `--conda`: Uses a managed Conda environment.
- `--singularity`: Uses Singularity/Apptainer containers.
- `--ambient`: Uses the local environment (requires manual installation of Augur/Auspice).
- `--aws-batch`: Runs the build on AWS infrastructure.

## Expert Tips and Patterns

### Resource Management
Always specify resources for large datasets to prevent out-of-memory errors:
- `nextstrain build --cpus 8 --memory 16gib .`

### AWS Batch Efficiency
When running on AWS Batch, use the detach pattern for long-running jobs:
1. **Launch**: `nextstrain build --aws-batch --detach .`
2. **Monitor**: The CLI will provide a job ID. Use `nextstrain build --attach <job-id>` to reconnect.
3. **S3 Storage**: Ensure `NEXTSTRAIN_AWS_BATCH_S3_BUCKET` is set in your config or environment.

### Environment Variables
Pass sensitive data or configuration to the containerized runtimes:
- **Single variable**: `nextstrain build --env MY_API_KEY=12345 .`
- **Environment directory**: `nextstrain build --envdir ./secrets .`

### Pathogen Versioning
If you need to reproduce an analysis using an older version of a pathogen workflow:
- `nextstrain run sars-cov-2@v3.0.0 phylogenetic ./analysis`

## Reference documentation
- [nextstrain build](./references/docs_nextstrain_org_projects_cli_en_stable_commands_build.md)
- [nextstrain run](./references/docs_nextstrain_org_projects_cli_en_stable_commands_run.md)
- [nextstrain view](./references/docs_nextstrain_org_projects_cli_en_stable_commands_view.md)
- [AWS Batch Integration](./references/docs_nextstrain_org_projects_cli_en_stable_aws-batch.md)
- [Installation and Setup](./references/docs_nextstrain_org_projects_cli_en_stable_installation.md)