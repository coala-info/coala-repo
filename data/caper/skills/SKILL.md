---
name: caper
description: Caper (Cromwell Assisted Pipeline ExecutoR) is a Python-based wrapper for the Cromwell engine.
homepage: https://github.com/ENCODE-DCC/caper
---

# caper

## Overview
Caper (Cromwell Assisted Pipeline ExecutoR) is a Python-based wrapper for the Cromwell engine. It streamlines the process of running WDL workflows by automating the composition of input files, handling file localization across different storage providers (S3, GS, HTTP, Local), and managing execution environments. It is the standard tool for running ENCODE pipelines and is designed to abstract away the complexity of backend-specific configurations.

## Core CLI Patterns

### Initialization
Before running pipelines, initialize the configuration for your specific infrastructure.
- **Command**: `caper init [BACKEND]`
- **Supported Backends**: `local`, `slurm`, `sge`, `pbs`, `lsf`, `gcp`, `aws`.
- **Configuration**: This creates `~/.caper/default.conf`. You must edit this file to define required parameters (e.g., project IDs, buckets, or cluster partitions) before the tool will function correctly.

### Running Workflows
Caper supports different execution modes depending on the environment:

1.  **Local Run**: For small tests or powerful single nodes.
    `caper run workflow.wdl -i inputs.json`
2.  **Server Submission**: Requires a running Caper/Cromwell server.
    `caper submit workflow.wdl -i inputs.json`
3.  **HPC Submission**: Submits a "leader job" to the cluster which then manages child jobs.
    `caper hpc submit workflow.wdl -i inputs.json --leader-job-name my_experiment`

### Environment Management
Caper can force workflows to run inside specific containers or environments. Note that task-level `runtime` definitions in the WDL will override these CLI flags.
- **Docker**: `caper run ... --docker` (uses default image in WDL) or `--docker [IMAGE_URL]`
- **Singularity**: `caper run ... --singularity` or `--singularity docker://[IMAGE_URL]`
- **Conda**: `caper run ... --conda [ENV_NAME]`

## Expert Tips and Best Practices

### Call Caching and Restarts
To restart a failed workflow without re-running successful steps, use a metadata database.
- **Flag**: `--file-db [PATH_TO_DB]`
- **Usage**: If a workflow fails, run the exact same command with the same `--file-db` path. Caper will collect and soft-link previous outputs to resume progress.

### URI Handling
Caper automatically localizes files. You can mix URIs in your input JSON:
- Supported: `gs://`, `s3://`, `http(s)://`, and absolute local paths.
- **Cloud-to-Cloud**: If running on GCP but inputs are on S3, Caper handles the transfer to a temporary `gs://` bucket automatically.

### HPC Job Management
When using `caper hpc submit`:
- **Listing Jobs**: Use `caper hpc list` to see active leader jobs.
- **Aborting**: Use `caper hpc abort [JOB_ID]`. 
- **Warning**: Do not use native cluster commands (like `scancel` or `qdel`) on the leader job alone, as this may leave orphaned child jobs running on the cluster.

### Troubleshooting
- **Command Not Found**: If `caper` is not in your PATH after pip installation, add `export PATH=$PATH:~/.local/bin` to your `~/.bashrc`.
- **Java Requirement**: Ensure Java 11 or higher is installed, as Caper is a wrapper for the Java-based Cromwell engine.

## Reference documentation
- [Caper GitHub Repository](./references/github_com_ENCODE-DCC_caper.md)
- [Caper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_caper_overview.md)