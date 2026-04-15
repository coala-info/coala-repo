---
name: snakemake-executor-plugin-cannon
description: This plugin automates the mapping of Snakemake rule resources to appropriate partitions on the Harvard Cannon cluster. Use when user asks to run Snakemake workflows on the Cannon cluster, automatically select partitions based on memory or runtime, or submit GPU jobs to Cannon.
homepage: https://github.com/harvardinformatics/snakemake-executor-plugin-cannon
metadata:
  docker_image: "quay.io/biocontainers/snakemake-executor-plugin-cannon:1.9.2.post2--pyhdfd78af_0"
---

# snakemake-executor-plugin-cannon

## Overview
The Cannon executor plugin is a specialized fork of the Snakemake SLURM executor, specifically tuned for the Harvard Cannon cluster environment. Its primary function is to automatically map Snakemake rule resources—such as memory, runtime, and GPU requirements—to the appropriate cluster partitions. This automation reduces the need for manual partition management and helps prevent submission errors caused by resource-partition mismatches. Note that as of late 2025, this plugin is deprecated in favor of the standard Snakemake SLURM plugin (v2.0.0+), which now supports similar functionality via external configuration files.

## Installation
The plugin must be installed in the same environment as Snakemake. Use one of the following commands:

- **Mamba/Conda**: `mamba install -c bioconda snakemake-executor-plugin-cannon`
- **Pip**: `pip install snakemake-executor-plugin-cannon`

## Command Line Usage
To use this executor, specify it during the Snakemake invocation using the `--executor` flag:

`snakemake --executor cannon --jobs 100 [target]`

### Resource Definition Requirements
The plugin's automatic partition selection relies entirely on the `resources` defined within your Snakefile rules. For the plugin to function effectively, ensure your rules include:

- **mem_mb**: The memory required for the task.
- **runtime**: The maximum time allowed for the task (typically in minutes).
- **gpu**: Required for rules that need to be routed to GPU partitions.

### Expert Tips and Best Practices
- **Partition Selection**: The plugin automatically evaluates your `mem_mb` and `runtime` values to decide whether to submit to partitions like `shared`, `general`, or `bigmem`. If these resources are not defined, the plugin may fall back to default partitions which might not be optimal for your job size.
- **GPU Tasks**: When requesting GPUs, the plugin handles the specific Cannon syntax for GPU resources. Ensure your rule specifies a positive integer for the `gpu` resource to trigger this logic.
- **Legacy Support**: If you are maintaining an older workflow that relies on this specific plugin, you can find legacy releases on GitHub. These may need to be manually added to your Python site-packages directory if they are no longer available via standard package managers.
- **Transitioning to SLURM Plugin**: If you are using Snakemake SLURM plugin version 2.0.0 or higher, you should migrate to the standard `snakemake-executor-plugin-slurm`. Harvard Informatics provides a partition configuration file for Cannon that works with the standard plugin, rendering this specific Cannon plugin obsolete for newer setups.

## Reference documentation
- [Harvard Informatics Cannon Executor GitHub](./references/github_com_harvardinformatics_snakemake-executor-plugin-cannon.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-executor-plugin-cannon_overview.md)