---
name: snakemake-minimal
description: Snakemake-minimal provides the essential execution engine for the Snakemake workflow management system.
homepage: https://snakemake.readthedocs.io
---

# snakemake-minimal

# Snakemake-minimal

## Overview
Snakemake-minimal provides the essential execution engine for the Snakemake workflow management system. It enables the creation of scalable and reproducible data pipelines by defining "rules" that describe how to transform input files into output files using a Python-based domain-specific language. This skill focuses on the core command-line interface, rule optimization, and the fundamental patterns required to build robust, portable pipelines without the overhead of optional reporting or remote-storage plugins.

## Core CLI Patterns

### Execution and Validation
*   **Dry Run**: Always perform a dry run to verify the job DAG (Directed Acyclic Graph) before execution.
    ```bash
    snakemake -n
    ```
*   **Basic Execution**: Execute the workflow using all available CPU cores.
    ```bash
    snakemake --cores all
    ```
*   **Target Specificity**: Run the workflow only until a specific file is created.
    ```bash
    snakemake --cores 1 path/to/output_file.txt
    ```
*   **Linting**: Check the Snakefile for code quality and best practices.
    ```bash
    snakemake --lint
    ```

### Resource Management
*   **Override Threads**: Adjust the number of threads for a specific rule at runtime without modifying the Snakefile.
    ```bash
    snakemake --cores 8 --set-threads my_rule=4
    ```
*   **Resource Constraints**: Limit custom resources (e.g., memory or GPU) for specific rules.
    ```bash
    snakemake --cores 8 --set-resources my_rule:mem_mb=2048
    ```

### Handling Large Workflows
*   **Batching**: Process a subset of inputs for a specific rule to manage extremely large datasets.
    ```bash
    snakemake --cores 4 --batch my_aggregation_rule=1/3
    ```

## Workflow Optimization Tips

*   **Software Deployment**: Use the `--sdm conda` flag to ensure that rules requiring specific software environments are executed within isolated Conda environments defined in the Snakefile.
*   **Reasoning**: Use `-r` or `--reason` to understand why Snakemake decided to execute a particular rule (e.g., missing output, updated input, or changed code).
*   **Cleanup**: Use `--delete-all-output` or `--delete-temp-output` to clean up the working directory based on the rule definitions.

## Best Practices

*   **Rule Independence**: Ensure rules are atomic. A rule should ideally represent a single logical step in the analysis.
*   **Wildcards**: Use wildcards to generalize rules across multiple samples or parameters, avoiding hardcoded filenames.
*   **Input Functions**: For complex input dependencies, use Python functions to return input paths dynamically based on wildcards.
*   **Directory Management**: Use the `--directory` flag to set the working directory for the execution, keeping the Snakefile and source code separate from data if necessary.
*   **Avoid Lambda**: In rule definitions, prefer named helper functions over lambda expressions to improve readability and linting compatibility.

## Reference documentation
- [Command line interface](./references/snakemake_readthedocs_io_en_stable_executing_cli.html.md)
- [Best practices](./references/snakemake_readthedocs_io_en_stable_snakefiles_best_practices.html.md)
- [Installation](./references/snakemake_readthedocs_io_en_stable_getting_started_installation.html.md)
- [Snakemake Minimal Overview](./references/anaconda_org_channels_bioconda_packages_snakemake-minimal_overview.md)