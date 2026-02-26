---
name: jobtree
description: jobtree is a framework for managing and executing large-scale, nested computational pipelines on high-performance computing clusters. Use when user asks to configure job execution, monitor pipeline status, restart failed jobs, or analyze resource utilization across a batch system.
homepage: https://github.com/benedictpaten/jobTree
---


# jobtree

## Overview
jobtree is a specialized framework for managing large-scale computational pipelines on high-performance computing (HPC) clusters. It allows for the creation of complex, nested job structures where tasks can dynamically spawn sub-tasks. Use this skill to configure job execution, monitor the status of running pipelines, restart failed jobs from the point of failure, and analyze resource utilization (CPU/Memory) across a batch system.

## Installation and Setup
To use jobtree, ensure it and its dependency `sonLib` are in your Python path.

- **Conda Installation**: `conda install bioconda::jobtree`
- **Manual Setup**: 
  1. Clone `sonLib` and `jobTree` into the same parent directory.
  2. Update your environment: `export PYTHONPATH=${PYTHONPATH}:/path/to/parent_dir`
  3. Build: Run `make all` in the jobtree base directory.

## Core CLI Patterns

### Running a Pipeline
Execute your jobtree script by passing the required management directory and batch system.
```bash
python your_script.py --jobTree ./myJobTreeDir --batchSystem singleMachine --logLevel INFO --stats
```
- `--jobTree`: Path to a directory (must not exist) where job state is stored.
- `--batchSystem`: Options include `parasol`, `gridEngine`, `lsf`, or `singleMachine`.
- `--stats`: Enables collection of performance data.

### Monitoring Status
Check the progress of a running or finished pipeline to identify failed jobs.
```bash
jobTreeStatus ./myJobTreeDir --verbose
```
- Use `--failIfNotComplete` to return a non-zero exit code if any jobs are still active or failed.
- The `--verbose` flag is essential for retrieving the specific log files and error traces of failed jobs.

### Restarting a Pipeline
If a pipeline fails due to a transient error or a bug you have since fixed, restart it without re-running successful jobs.
```bash
jobTreeRun --jobTree ./myJobTreeDir --logLevel INFO
```

### Analyzing Performance
Generate a report on CPU, memory, and time usage for all jobs in the pipeline.
```bash
jobTreeStats ./myJobTreeDir --human --categories time,memory
```
- `--human`: Formats numbers (e.g., bytes to GB) for easier reading.
- `--sortCategory`: Sort the target list by `time`, `memory`, or `count`.

## Expert Tips
- **Job Directory Persistence**: The `--jobTree` directory is not deleted automatically. This is intentional to allow for debugging and restarts. Manually remove it only after a successful run and data verification.
- **Resource Specification**: When writing scripts, always specify default CPU and memory requirements to prevent the batch system from over-allocating or killing jobs for exceeding limits.
- **Logging**: Use `--logLevel DEBUG` only for small test runs, as it can generate massive log files in the jobTree directory for large-scale pipelines.

## Reference documentation
- [github_com_benedictpaten_jobTree.md](./references/github_com_benedictpaten_jobTree.md)
- [anaconda_org_channels_bioconda_packages_jobtree_overview.md](./references/anaconda_org_channels_bioconda_packages_jobtree_overview.md)