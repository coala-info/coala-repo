---
name: rsrq
description: "rsrq is a high-performance job queue system that uses Redis to distribute and execute shell commands across parallel workers. Use when user asks to enqueue shell commands, start parallel workers, monitor queue status, or integrate job scheduling with Snakemake."
homepage: https://github.com/aaronmussig/rsrq
---


# rsrq

## Overview

rsrq (Rust Redis Queue) is a high-performance, minimal job queue system written in Rust. It leverages Redis to manage and distribute shell commands across parallel workers. Unlike more complex task queues, rsrq focuses on simplicity: you provide a text file of commands, and rsrq handles the distribution and execution. It is specifically designed to integrate seamlessly with Snakemake, allowing users to route specific rules to different Redis queues.

## Environment Setup

Before using rsrq, you must define the connection string for your Redis instance.

```bash
export REDIS_URL=redis://[:password@]host[:port][/db_number]
```

## Core CLI Usage

### 1. Enqueueing Jobs
Jobs are added to a named queue by providing a text file where each line represents a single shell command to be executed.

```bash
rsrq enqueue <queue_name> <commands_file.txt>
```

### 2. Processing Jobs
Workers must be started manually on the machine(s) where the tasks should run. You can specify the number of parallel worker threads.

```bash
# Start 10 parallel workers for the 'analysis' queue
rsrq worker analysis --workers 10
```

### 3. Monitoring and Maintenance
Use these commands to track progress or reset the environment.

*   **Check Status**: View the current state of jobs in the queue.
    ```bash
    rsrq status
    ```
*   **Purge Data**: Remove all information from the Redis database to start fresh.
    ```bash
    rsrq purge all
    ```

## Snakemake Integration

rsrq provides native support for Snakemake cluster profiles.

### Configuration
Export a cluster profile to a specific directory:
```bash
rsrq snakemake config /path/to/profile_dir
```

### Execution
Run Snakemake using the generated profile:
```bash
snakemake --profile /path/to/profile_dir
```

### Rule-Specific Queues
In your Snakefile, you can direct specific rules to different rsrq queues using the `resources` attribute. If no queue is specified, it defaults to the `default` queue.

```python
rule process_data:
    input: "input.txt"
    output: "output.txt"
    resources:
        queue = 'high_priority'
    shell:
        "my_command {input} {output}"
```

## Expert Tips and Best Practices

*   **Resource Management**: rsrq workers do not automatically monitor system CPU or memory usage. You must calculate the appropriate number of `--workers` based on the resource requirements of the commands being executed and the total capacity of the host machine.
*   **Parallel Scaling**: Since rsrq is Redis-backed, you can start workers on multiple different physical nodes pointing to the same `REDIS_URL` to create a simple distributed computing cluster.
*   **Command Formatting**: Ensure the commands file contains raw shell commands. rsrq executes these lines directly; complex shell logic (like pipes or redirects) should be wrapped in a script if they behave unexpectedly when enqueued.

## Reference documentation
- [rsrq GitHub Repository](./references/github_com_aaronmussig_rsrq.md)
- [rsrq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rsrq_overview.md)