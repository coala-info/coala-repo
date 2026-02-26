---
name: snakemake-executor-plugin-cluster-generic
description: This plugin enables Snakemake to execute workflows on cluster workload managers by passing job scripts to user-specified submission commands. Use when user asks to execute workflows on a cluster, configure job submission commands like qsub or sbatch, or manage job cancellation and resources on a scheduler.
homepage: https://github.com/snakemake/snakemake-executor-plugin-cluster-generic
---


# snakemake-executor-plugin-cluster-generic

## Overview
The `cluster-generic` plugin is the standard bridge between Snakemake and cluster workload managers. It functions by taking a Snakemake-generated job script and passing it to a user-specified submission command (e.g., `qsub`, `bsub`, or `sbatch`). This skill provides the necessary CLI patterns to configure job submission, job cancellation, and resource management within a Snakemake workflow.

## Installation
Ensure the plugin is installed in your Snakemake environment:
```bash
conda install -c bioconda snakemake-executor-plugin-cluster-generic
```

## Core CLI Usage
To execute a workflow on a cluster, you must specify the executor and the mandatory submission command.

### Basic Submission
The `--cluster-generic-submit-cmd` is required. Snakemake will append the path to the job script as the final argument to this command.

```bash
snakemake --executor cluster-generic --cluster-generic-submit-cmd "qsub" --jobs 100
```

### Advanced Submission with Resources
For schedulers requiring specific flags (like queue names or memory limits), wrap the command in quotes. You can use Snakemake's job properties (like threads or resources defined in the Snakefile) if the scheduler supports reading them from the script header or if you use a wrapper script.

```bash
# Example for SLURM
snakemake --executor cluster-generic --cluster-generic-submit-cmd "sbatch --partition=long --mem=4G" --jobs 20
```

### Job Cancellation
To ensure cluster jobs are killed when Snakemake is interrupted (Ctrl+C), provide a cancellation command. Note that the command must be able to identify the job ID returned by the submission command.

```bash
snakemake --executor cluster-generic \
    --cluster-generic-submit-cmd "qsub" \
    --cluster-generic-cancel-cmd "qdel"
```

## Expert Tips and Troubleshooting
- **Trailing Whitespace**: Ensure your `--cluster-generic-submit-cmd` string does not end with trailing newlines or unexpected whitespace, as this can cause submission failures in certain shell environments.
- **Job Script Handling**: The plugin generates a shell script for every job. If your cluster environment has strict requirements about where these scripts are stored or executed from, ensure your Snakemake working directory is on a shared filesystem accessible by all cluster nodes.
- **LSF Integration**: When using LSF, the cancel command often requires specific job ID parsing. Ensure your `submit-cmd` returns only the job ID to the standard output if you intend to use a simple `bkill` as the `cancel-cmd`.
- **Resource Mapping**: Since this is a "generic" plugin, it does not automatically map Snakemake `resources:` to scheduler flags. You must either:
    1. Include the flags in the `--cluster-generic-submit-cmd`.
    2. Use a custom submission wrapper script that parses the job script for `#SBATCH` or `#PBS` directives.

## Reference documentation
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-cluster-generic_overview.md)
- [GitHub Repository README](./references/github_com_snakemake_snakemake-executor-plugin-cluster-generic.md)
- [Known Issues and Limitations](./references/github_com_snakemake_snakemake-executor-plugin-cluster-generic_issues.md)