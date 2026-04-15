---
name: caper
description: Caper is a Python-based wrapper for the Cromwell engine that simplifies running and managing WDL pipelines across various computing backends. Use when user asks to initialize a workflow environment, run or submit WDL pipelines, manage HPC leader jobs, or handle file localization between local and cloud storage.
homepage: https://github.com/ENCODE-DCC/caper
metadata:
  docker_image: "quay.io/biocontainers/caper:1.1.0--py_0"
---

# caper

## Overview

Caper (Cromwell Assisted Pipeline ExecutoR) is a Python-based wrapper for the Cromwell workflow engine. It simplifies the process of running WDL (Workflow Description Language) pipelines by automatically handling backend configuration, input file composition, and data localization. It allows users to seamlessly move files between local storage, S3, Google Storage, and HTTP URLs while executing tasks in Docker, Singularity, or Conda environments.

## Core Workflows

### 1. Initialization
Before running pipelines, initialize Caper for your specific environment to generate the default configuration file (`~/.caper/default.conf`) and download required Cromwell/Womtool JARs.

```bash
# Supported backends: local, slurm, sge, pbs, lsf, gcp, aws
caper init <backend>
```

### 2. Running Workflows
There are two primary ways to execute a WDL:

**Run Mode (Single Workflow):**
Best for testing or one-off runs.
```bash
caper run workflow.wdl -i inputs.json --docker
```

**Server Mode (Production/Multiple Workflows):**
Start a persistent server and submit jobs to it.
```bash
# Start the server in one session
caper server

# Submit jobs in another session
caper submit workflow.wdl -i inputs.json -s "my_experiment_label"
```

### 3. HPC Submission (Leader Job Pattern)
On clusters (SLURM, SGE, etc.), use the `hpc` subcommand to submit Caper as a "leader job" that manages child task submissions.

```bash
caper hpc submit workflow.wdl -i inputs.json --singularity --leader-job-name experiment_v1
```

## Expert Tips and Best Practices

### File Localization and Deepcopy
Caper automatically transfers remote URIs (gs://, s3://, http://) to the target backend's temporary directory.
- **Deepcopy**: Enabled by default. It recursively copies all files defined in `.json`, `.tsv`, and `.csv` inputs to the remote storage.
- **Disable Deepcopy**: Use `--no-deepcopy` if you want to prevent automatic transfers.

### Environment Management
- **Singularity on HPC**: Most HPCs do not allow Docker. Use `--singularity` to run tasks in containers.
- **Conda**: Use `--conda <env_name>`. Caper runs `conda run -n` internally, so you do not need to activate the environment manually.
- **Precedence**: Environments defined in the WDL task's `runtime` section will always override CLI flags like `--docker` or `--singularity`.

### Call-Caching and Resuming
To reuse outputs from previous successful runs and resume failed workflows:
- Use a persistent database: `--file-db <path_to_db_file>`.
- If you encounter connection errors with multiple runs, ensure you are using a `caper server` or specify unique `--file-db` paths per run.

### Monitoring and Troubleshooting
- **Labeling**: Always use `-s` or `--str-label` when submitting. This allows you to search and manage workflows by a human-readable string instead of a long UUID.
- **Listing**: `caper list <label_or_uuid>` (supports wildcards like `*`).
- **Debugging**: If a workflow fails, use the debug command to parse metadata and identify the specific task failure.
  ```bash
  caper debug <uuid_or_label>
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| caper abort | List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed. |
| caper debug | Debug workflows |
| caper list | List workflows, metadata, and abort workflows. |
| caper metadata | List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). |
| caper run | Run a WDL script with Caper |
| caper server | Start Caper server |
| caper submit | Submit a WDL workflow to Caper. |
| caper troubleshoot | List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed. |
| caper unhold | List of workflow IDs to find matching workflows to commit a specified action (list, metadata and abort). Wildcards (* and ?) are allowed. |
| caper_init | Initialize Caper for a given platform. |

## Reference documentation
- [Caper README](./references/github_com_ENCODE-DCC_caper_blob_master_README.md)
- [Caper Detailed Usage](./references/github_com_ENCODE-DCC_caper_blob_master_DETAILS.md)