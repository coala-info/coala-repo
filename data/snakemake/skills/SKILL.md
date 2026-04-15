---
name: snakemake
description: Snakemake is a workflow management system used to create reproducible and scalable data analysis pipelines through a Python-based declarative language. Use when user asks to write Snakefiles, define rules with wildcards, manage software dependencies via Conda or containers, and execute complex data processing workflows.
homepage: https://snakemake.github.io
metadata:
  docker_image: "quay.io/biocontainers/snakemake:9.16.3--hdfd78af_0"
---

# snakemake

## Overview
Snakemake is a Python-based workflow management system used to create reproducible and scalable data analysis pipelines. It uses a declarative domain-specific language where "rules" define how to transform input files into output files. This skill assists in writing Snakemake files (Snakefiles), managing dependencies, and utilizing the plugin ecosystem for execution and storage.

## Core Workflow Patterns

### Rule Definition
Every rule should explicitly define `input`, `output`, and a method of execution (`shell`, `script`, `wrapper`, or `notebook`).
- **Wildcards**: Use `{sample}` or `{prefix}` to generalize rules. Snakemake determines dependencies by matching output file patterns to input requirements.
- **Threads & Resources**: Always specify `threads: 8` or `resources: mem_mb=4000` to allow the scheduler to optimize parallel execution.

### Software Deployment
To ensure reproducibility, integrate software management directly into rules:
- **Conda**: Use `conda: "envs/tool.yaml"` to point to an environment file. Execute with `snakemake --use-conda`.
- **Containers**: Use `container: "docker://user/image:tag"` for OS-level isolation. Execute with `snakemake --use-singularity`.

### Scripting Integration
Avoid complex logic in `shell` blocks. Use the `script` directive to point to external files:
```python
rule analyze:
    input: "data/{sample}.csv"
    output: "results/{sample}.svg"
    script: "scripts/analyze.py"
```
In `analyze.py`, access Snakemake objects directly via the `snakemake` object (e.g., `snakemake.input[0]`).

## Common CLI Patterns

- **Dry Run**: Always start with `snakemake -n` to verify the execution plan without running commands.
- **Visualization**: Use `snakemake --dag | dot -Tpdf > dag.pdf` to visualize the rule dependency graph.
- **Execution**:
    - Local: `snakemake --cores 4`
    - With Conda: `snakemake --use-conda --cores all`
    - Specific Target: `snakemake path/to/output_file`
- **Reporting**: Generate a self-contained HTML results report using `snakemake --report report.html`.

## Expert Tips
- **Checkpoints**: Use `checkpoint` instead of `rule` for steps where the output files are not known until the step completes (e.g., a filtering step that might produce zero or many files).
- **Input Functions**: Use Python functions for `input` to handle complex logic or lookups based on configuration files.
- **Profiles**: Instead of long CLI strings, use `--profile my-profile` to load pre-configured settings for specific clusters (SLURM, SGE) or cloud environments.
- **Shadow Folders**: Use `shadow: "shallow"` to execute rules in a temporary directory, preventing clutter from intermediate tool-generated files.

## Reference documentation
- [Snakemake Overview](./references/snakemake_github_io_index.md)
- [Plugin Catalog](./references/snakemake_github_io_snakemake-plugin-catalog_index.html.md)
- [Workflow Catalog](./references/snakemake_github_io_snakemake-workflow-catalog.md)