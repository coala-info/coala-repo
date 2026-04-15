---
name: snakemake-executor-plugin-slurm
description: This plugin enables Snakemake to execute workflow tasks as jobs on a SLURM cluster by translating resource requirements into submission commands. Use when user asks to run Snakemake workflows on a SLURM scheduler, submit jobs to a cluster, or manage SLURM resource allocations like partitions and memory.
homepage: https://github.com/snakemake/snakemake-executor-plugin-slurm
metadata:
  docker_image: "quay.io/biocontainers/snakemake-executor-plugin-slurm:2.3.1--pyhdfd78af_0"
---

# snakemake-executor-plugin-slurm

## Overview

The `snakemake-executor-plugin-slurm` is a specialized executor that allows Snakemake to interface directly with the SLURM scheduler. Instead of executing rules on the local head node, this plugin translates Snakemake's resource requirements into SLURM `sbatch` commands, handles job dependency tracking, and monitors job status across the cluster. It is the modern replacement for the legacy `--cluster` flag approach for SLURM environments.

## Installation and Basic Execution

To use this plugin, ensure it is installed in your Snakemake environment:

```bash
conda install -c bioconda snakemake-executor-plugin-slurm
```

Execute your workflow by specifying the slurm executor:

```bash
snakemake --executor slurm --jobs 100
```

## Resource Mapping

The plugin maps Snakemake rule resources to SLURM submission parameters. Use the following resource names in your Snakefile or via `--default-resources` to control job behavior:

- **runtime**: Maps to SLURM time limit (in minutes).
- **mem_mb** or **mem_gib**: Maps to memory requirements.
- **slurm_partition**: Specifies the cluster partition.
- **slurm_account**: Specifies the billing account.
- **nodes**: Number of nodes.
- **cpus_per_task**: Maps to `--cpus-per-task`.

Example CLI override for default resources:
```bash
snakemake --executor slurm --default-resources mem_mb=2000 runtime=60 slurm_partition=standard
```

## Expert CLI Patterns

### Customizing Job Names
To easily identify your jobs in `squeue`, use the job name prefix feature (available in v2.2.0+):
```bash
snakemake --executor slurm --executor-slurm-jobname-prefix MY_PROJECT_
```

### Passing Additional SLURM Arguments
If you need to pass specific SLURM flags that are not explicitly mapped by the plugin, use the arguments pass-through:
```bash
snakemake --executor slurm --executor-slurm-args "--qos=high --constraint=avx512"
```

### Handling Large Workflows
For workflows with thousands of jobs, ensure you set a reasonable `--jobs` limit to avoid overwhelming the SLURM controller, and consider using the jobscript mode (default in v2.1.0+) which passes a shell script to `sbatch` for better reliability.

## Best Practices

- **Memory Units**: Prefer `mem_mb` or `mem_gib`. Note that some versions may require specific integer validation; ensure your values are provided as whole numbers.
- **GPU Resources**: When requesting GPUs, use the standard Snakemake `gpu` resource. The plugin handles the translation to `--gres=gpu:...`. Note that NVIDIA MIG (Multi-Instance GPU) support may require specific naming conventions in the resource string.
- **Partition Selection**: Use the dynamic partition selection feature (v2.0.0+) to allow Snakemake to choose partitions based on requested resources.
- **Error Reporting**: If jobs fail, check the SLURM logs. The plugin names these logs specifically to match the Snakemake job ID for easier debugging.

## Reference documentation
- [Anaconda Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-slurm_overview.md)
- [GitHub Repository README](./references/github_com_snakemake_snakemake-executor-plugin-slurm.md)
- [Release Tags and Feature History](./references/github_com_snakemake_snakemake-executor-plugin-slurm_tags.md)
- [Known Issues and Resource Handling](./references/github_com_snakemake_snakemake-executor-plugin-slurm_issues.md)