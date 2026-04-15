---
name: snakemake-minimal_7.25.0-pyhdfd78af_0-test
description: Snakemake is a Python-based workflow management system used to create and execute reproducible data analysis pipelines. Use when user asks to build data analysis workflows, perform dry runs of pipelines, visualize rule dependencies, or execute tasks in parallel using specific CPU cores.
homepage: https://snakemake.github.io
metadata:
  docker_image: "quay.io/biocontainers/snakemake:9.16.3--hdfd78af_0"
---

# snakemake-minimal_7.25.0-pyhdfd78af_0-test

## Overview
Snakemake is a Python-based workflow management system that simplifies the creation of data analysis pipelines. It uses a declarative domain-specific language to define "rules" that describe how to generate output files from input files. By automatically determining dependencies between rules, Snakemake ensures that only necessary steps are executed, supporting efficient re-runs and parallel processing. This skill focuses on the core CLI operations and Snakefile logic required to build robust, scalable, and portable workflows.

## Core CLI Patterns

### Execution and Validation
*   **Dry Run**: Always perform a dry run to see the execution plan without actually running commands.
    `snakemake -n`
*   **Reasoning**: View why a specific rule is being executed (e.g., which input file is newer than the output).
    `snakemake -n -r`
*   **Local Execution**: Run the workflow using a specific number of CPU cores.
    `snakemake --cores 4`
*   **Target Specific Rule**: Execute only up to a specific rule or file.
    `snakemake --cores 1 path/to/output_file.txt`

### Workflow Visualization
*   **Directed Acyclic Graph (DAG)**: Generate a visual representation of the rule dependencies.
    `snakemake --dag | dot -Tsvg > dag.svg`
*   **File Graph**: Visualize the dependencies based on actual files rather than rules.
    `snakemake --filegraph | dot -Tsvg > filegraph.svg`

### Environment and Cleanup
*   **Conda Integration**: Execute rules within isolated Conda environments defined in the workflow.
    `snakemake --use-conda --cores 4`
*   **Cleanup Metadata**: Remove Snakemake's internal metadata if a run was interrupted or corrupted.
    `snakemake --cleanup-metadata [filenames]`
*   **Unlock Directory**: If a previous run crashed and left the working directory locked.
    `snakemake --unlock`

## Snakefile Best Practices

### Rule Structure
*   **Rule All**: Define a `rule all` at the very top of the Snakefile. This rule should list all final desired outputs in its `input` section, serving as the default target for the workflow.
*   **Wildcards**: Use curly braces (e.g., `{sample}`) to create generalized rules that can process multiple files with the same logic.
*   **Input/Output Functions**: For complex dependencies, use Python functions as `input` to dynamically determine files based on wildcards.

### Script and Notebook Integration
*   **Direct Scripting**: Instead of wrapping complex Python or R code in a `shell` command, use the `script` directive. This automatically makes `snakemake` objects (containing input, output, and params) available within the script.
*   **Jupyter Integration**: Use the `notebook` directive to execute analysis in a Jupyter notebook, which is useful for interactive data exploration within a reproducible pipeline.

### Modularization
*   **Include**: Break large workflows into smaller files and use the `include` statement to merge them.
*   **Modules**: Use the `module` and `use rule` syntax to import and modify rules from external repositories or standardized workflow catalogs.

## Expert Tips
*   **Shadow Directories**: Use the `shadow` directive in rules that produce many temporary files to prevent cluttering the primary working directory and ensure a clean environment for each job.
*   **Benchmarks**: Add a `benchmark` directive to rules to automatically record CPU and memory usage for performance optimization.
*   **Checkpoints**: Use `checkpoint` instead of `rule` for steps where the output files are not known until the rule has finished executing (e.g., a step that splits a file into an unknown number of chunks).
*   **Temporary Files**: Mark intermediate files with `temp()` in the `output` section to have Snakemake automatically delete them once they are no longer needed by downstream rules.

## Reference documentation
- [Snakemake Homepage](./references/snakemake_github_io_index.md)
- [Bioconda Snakemake Overview](./references/anaconda_org_channels_bioconda_packages_snakemake_overview.md)
- [Snakemake Plugin Catalog](./references/snakemake_github_io_snakemake-plugin-catalog_index.html.md)