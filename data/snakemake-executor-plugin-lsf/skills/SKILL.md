---
name: snakemake-executor-plugin-lsf
description: This plugin enables Snakemake to submit and manage jobs on IBM Spectrum LSF clusters by translating resource definitions into bsub parameters. Use when user asks to run Snakemake workflows on LSF, map resources like memory and walltime to bsub flags, or configure MPI jobs and custom LSF arguments.
homepage: https://github.com/befh/snakemake-executor-plugin-lsf
---


# snakemake-executor-plugin-lsf

## Overview

The LSF executor plugin enables Snakemake to submit jobs to IBM Spectrum LSF clusters. It translates Snakemake's internal resource definitions—such as threads, memory, and runtime—into the appropriate `bsub` parameters. This skill helps you navigate the specific resource mapping logic and CLI flags required to ensure jobs are scheduled correctly with the right accounting and hardware requirements.

## Command Line Usage

To use the LSF executor, you must specify the executor and provide mandatory LSF resources (Project and Queue) via the command line.

### Basic Execution
```bash
snakemake --executor lsf \
    --default-resources \
        lsf_project=<your_project> \
        lsf_queue=<your_queue>
```

### Overriding Resources per Rule
If specific rules require different queues or resources, use the `--set-resources` flag:
```bash
snakemake --executor lsf \
    --default-resources lsf_project=my_proj lsf_queue=normal \
    --set-resources my_heavy_rule:lsf_queue=long
```

## Resource Mapping Reference

The plugin maps Snakemake `resources` defined in your Snakefile to LSF `bsub` arguments:

| LSF Argument | Snakemake Resource | Description |
|--------------|--------------------|-------------|
| `-q` | `lsf_queue` | The LSF queue to use. |
| `-W` | `walltime` or `runtime` | Maximum job duration in minutes. |
| `-R "rusage[mem=...]"` | `mem`, `mem_mb` | Total memory required for the node. |
| `-R "rusage[mem=...]"` | `mem_mb_per_cpu` | Memory required per reserved CPU. |
| `-R "span[hosts=1]"` | `mpi` | Used for MPI jobs to control node spanning. |
| `-R "span[ptile=...]"` | `ptile` | Processors per host (requires `mpi`). |
| (Direct pass) | `lsf_extra` | String of additional `bsub` arguments. |

## Expert Tips and Best Practices

### Memory Management
*   **Per-Core vs. Per-Job**: By default, the plugin converts `mem_mb` into a per-core request (e.g., `threads: 4` and `mem_mb: 128` becomes `-R rusage[mem=32]`).
*   **Global Override**: If your cluster expects per-job memory requests instead of per-core, set the environment variable `SNAKEMAKE_LSF_MEMFMT=perjob`.
*   **Mutual Exclusion**: Do not use `mem_mb` and `mem_mb_per_cpu` in the same rule; they are mutually exclusive.

### Handling MPI Jobs
Define `tasks` and `mpi` in your rule resources. The plugin will automatically handle the host spanning requirements:
```python
rule mpi_task:
    threads: 40
    resources:
        tasks = 10,
        mpi = "mpirun"
    shell:
        "{resources.mpi} -np {resources.tasks} my-prog > {output}"
```

### Passing Arbitrary LSF Arguments
For specialized hardware like GPUs or specific architecture requirements not covered by standard resources, use `lsf_extra`:
```python
# In the Snakefile
resources:
    lsf_extra = "-R a100 -gpu num=2"
```

### Default Resources
Always define `lsf_project` and `lsf_queue` as default resources to avoid submission failures on clusters where these are mandatory for accounting.

## Reference documentation
- [github_com_BEFH_snakemake-executor-plugin-lsf.md](./references/github_com_BEFH_snakemake-executor-plugin-lsf.md)