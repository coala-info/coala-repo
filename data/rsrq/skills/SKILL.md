---
name: rsrq
description: rsrq is a lightweight, high-performance job queueing system that uses Redis to manage and distribute shell commands across multiple worker processes. Use when user asks to enqueue command-line tasks from text files, spawn parallel workers to process jobs, monitor queue status, or integrate job submission with Snakemake.
homepage: https://github.com/aaronmussig/rsrq
metadata:
  docker_image: "quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0"
---

# rsrq

## Overview

rsrq (Rust Redis Queue) is a lightweight, high-performance job queueing system inspired by the Python RQ library. It uses Redis as a backend to manage and distribute shell commands across multiple worker processes. This tool is specifically designed for users who need to parallelize a large number of independent command-line tasks—such as those found in data processing or bioinformatics pipelines—without the complexity of a full-scale cluster scheduler. It provides a simple interface to enqueue jobs from text files and scale workers across one or more machines.

## Installation and Setup

Ensure Rust 1.70+ is installed.

```bash
# Install via Cargo
cargo install rsrq

# Or via Bioconda
conda install -c conda-forge -c bioconda rsrq
```

### Connection Configuration
The tool requires a Redis instance. Define the connection string as an environment variable:

```bash
export REDIS_URL=redis://[:password@]host[:port][/db]
```

## Core CLI Workflows

### 1. Enqueuing Jobs
Jobs are defined in a plain text file where each line represents a single shell command to be executed.

```bash
# Syntax: rsrq enqueue <queue_name> <commands_file>
rsrq enqueue processing_queue ./tasks.txt
```

### 2. Processing Jobs with Workers
Workers pull jobs from a specific queue. You can spawn multiple workers in a single command to enable parallel execution on the current host.

```bash
# Spawn 8 parallel workers for the 'processing_queue'
rsrq worker processing_queue --workers 8
```

### 3. Monitoring and Maintenance
Use the status and purge commands to manage the lifecycle of your queues.

```bash
# View current job counts and worker status
rsrq status

# Clear all data from the Redis database (use with caution)
rsrq purge all
```

## Snakemake Integration

rsrq provides native support for Snakemake, allowing it to act as a cluster-like submission backend.

1. **Initialize Profile**: Generate the necessary configuration files for a Snakemake profile.
   ```bash
   rsrq snakemake config ./rsrq_profile
   ```

2. **Execute Snakemake**: Run your workflow using the generated profile.
   ```bash
   snakemake --profile ./rsrq_profile
   ```

3. **Rule-Specific Queues**: In your Snakefile, you can direct specific rules to different rsrq queues using the `resources` attribute:
   ```python
   rule example:
       input: "data.txt"
       output: "result.txt"
       resources:
           queue="high_priority"
       shell:
           "process_data {input} {output}"
   ```

## Expert Tips and Best Practices

- **Resource Awareness**: rsrq workers do not automatically monitor system CPU or memory. When spawning workers with `--workers`, ensure the total resource requirements of the concurrent jobs do not exceed the host's physical limits.
- **Persistent Workers**: For long-running pipelines, consider running workers inside a terminal multiplexer like `tmux` or `screen` to prevent jobs from being killed if your SSH session disconnects.
- **Queue Isolation**: Use descriptive queue names (e.g., `alignment`, `assembly`, `cleanup`) to organize different types of tasks and scale workers independently based on the workload of each stage.
- **Redis Security**: If using a remote Redis instance, always use a password-protected connection string and ensure your Redis port is not exposed to the public internet.



## Subcommands

| Command | Description |
|---------|-------------|
| rsrq enqueue | Enqueue a batch of commands to be run |
| rsrq purge | Removes all data from Redis |
| rsrq snakemake | Commands that can be issued by Snakemake for cluster execution |
| rsrq status | Check the status of all objects in the Redis database |
| rsrq worker | Spawns worker processes to consume jobs from a queue |

## Reference documentation

- [rsrq GitHub Repository](./references/github_com_aaronmussig_rsrq_blob_main_README.md)
- [rsrq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rsrq_overview.md)