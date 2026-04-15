---
name: snakemake-interface-scheduler-plugins
description: This tool provides a stable Python interface for developing and integrating custom job scheduling logic into Snakemake. Use when user asks to create a scheduler plugin, implement custom job selection logic, or extend Snakemake's scheduling capabilities with specialized heuristics.
homepage: https://github.com/snakemake/snakemake-interface-scheduler-plugins
metadata:
  docker_image: "quay.io/biocontainers/snakemake-interface-scheduler-plugins:2.0.2--pyhd4c3c12_0"
---

# snakemake-interface-scheduler-plugins

## Overview
This skill provides the technical framework for extending Snakemake's scheduling capabilities. It defines a stable Python interface that allows developers to replace or augment Snakemake's internal greedy scheduler with custom logic (e.g., Integer Linear Programming or specialized heuristics). By using this interface, plugins can interact with the Directed Acyclic Graph (DAG), evaluate resource availability, and determine the optimal sequence of job execution while maintaining compatibility with the Snakemake core.

## Implementation Guidelines

### Plugin Naming and Distribution
*   **Naming Convention**: Plugins must be named using the format `snakemake-scheduler-plugin-<name>`.
*   **Reserved Names**: Do not use `greedy`, `ilp`, or `milp`, as these are reserved for Snakemake's internal schedulers.
*   **Distribution**: Plugins must be published on PyPI to be discoverable by Snakemake.

### Core Components
To implement a scheduler plugin, you must inherit from and implement the following classes:

1.  **SchedulerSettings**: A dataclass inheriting from `SchedulerSettingsBase`.
    *   Define parameters as `Optional` with default values.
    *   Use `metadata={"help": "..."}` for CLI documentation.
    *   Settings automatically appear in the Snakemake CLI as `--scheduler-<plugin-name>-<param-name>`.
2.  **Scheduler**: The main logic class inheriting from `SchedulerBase`.
    *   Implement `dag_updated()` to react to changes in the DAG.
    *   Implement `select_jobs()` to perform the actual job selection logic.

### Job Selection Logic (`select_jobs`)
The `select_jobs` method is the primary entry point for scheduling decisions.
*   **Input**: Receives `selectable_jobs`, `remaining_jobs`, `available_resources`, and `input_sizes`.
*   **Job Types**: Handle both `SingleJobSchedulerInterface` and `GroupJobSchedulerInterface`. For groups, use `.jobs()` to access individual tasks.
*   **Resource Management**: Access job requirements via `Job.scheduler_resources`. You can inject additional resources using `Job.add_resource(name, value)`.
*   **Fallback Mechanism**: Return `None` to trigger a fallback to Snakemake's internal greedy scheduler if the custom logic cannot find a solution or encounters an error.
*   **Success**: Return a `Sequence` of selected jobs to be executed.

### Best Practices
*   **Initialization**: Use `__post_init__` instead of `__init__` in your `Scheduler` class to ensure compatibility with the base interface.
*   **Logging**: Use `self.logger` (a standard Python `logging.Logger`) for all plugin-specific feedback and warnings.
*   **Performance**: `input_sizes` uses async I/O. Call it once per selection cycle and collect all necessary file information to avoid performance bottlenecks.
*   **Environment Variables**: Only use the `env_var` metadata field in `SchedulerSettings` for credentials (usernames, passwords). For general defaults, prefer Snakemake profiles.

## Common CLI Patterns

### Installation
Install the interface and your specific plugin via pip or conda:
```bash
pip install snakemake-interface-scheduler-plugins snakemake-scheduler-plugin-<name>
```

### Execution
Invoke Snakemake using the custom scheduler:
```bash
snakemake --scheduler <name>
```

### Passing Plugin Parameters
Pass custom settings defined in your `SchedulerSettings` dataclass:
```bash
snakemake --scheduler <name> --scheduler-<name>-<myparam> <value>
```

## Reference documentation
- [Snakemake Scheduler Plugin Interface](./references/github_com_snakemake_snakemake-interface-scheduler-plugins.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-interface-scheduler-plugins_overview.md)