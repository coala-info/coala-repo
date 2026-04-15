---
name: snakemake-minimal_7.25.0-pyhdfd78af_0
description: Snakemake provides a framework for automating complex data processing pipelines using a Python-based domain-specific language. Use when user asks to define workflow rules, manage file dependencies, automate data processing pipelines, or scale computations across different computing environments.
homepage: https://snakemake.github.io
metadata:
  docker_image: "quay.io/biocontainers/snakemake:9.16.3--hdfd78af_0"
---

# snakemake-minimal_7.25.0-pyhdfd78af_0

## Overview
This skill provides a framework for automating complex data processing pipelines. Snakemake uses a Python-based domain-specific language to define "rules" that represent individual steps in a workflow. It automatically determines dependencies between steps based on filenames, ensuring that only necessary parts of a pipeline are re-executed when data or code changes. Use this skill to ensure full in-silico reproducibility, manage software dependencies via Conda, and scale computations from a single laptop to high-performance computing (HPC) clusters.

## Core Workflow Patterns

### Defining Rules
A Snakemake workflow is defined in a `Snakefile`. Each rule should follow this basic structure:

```python
rule rule_name:
    input:
        "path/to/input_file.txt"
    output:
        "path/to/output_file.txt"
    shell:
        "command {input} > {output}"
```

### Using Wildcards for Generalization
Generalize rules to handle multiple samples or files using curly braces:

```python
rule process_sample:
    input:
        "data/{sample}.fastq"
    output:
        "processed/{sample}.bam"
    shell:
        "tool --input {input} --output {output}"
```

### Aggregation with 'expand'
Use the `expand()` function to generate lists of files based on wildcards, typically used in a "target" rule like `rule all`:

```python
SAMPLES = ["A", "B", "C"]

rule all:
    input:
        expand("processed/{sample}.bam", sample=SAMPLES)
```

### Script Integration
Instead of shell commands, integrate Python or R scripts directly to avoid boilerplate:

```python
rule analyze:
    input:
        "data/results.csv"
    output:
        "plots/report.pdf"
    script:
        "scripts/generate_plot.py"
```

## Common CLI Patterns

### Execution Basics
*   **Dry Run**: Always perform a dry run to see the execution plan without running commands.
    `snakemake -n`
*   **Visualizing the Plan**: Print the shell commands that will be executed.
    `snakemake -p`
*   **Core Limit**: Specify the number of available CPU cores (required).
    `snakemake --cores 8`

### Workflow Management
*   **Target Specific Rule**: Execute until a specific file or rule is reached.
    `snakemake path/to/output.file`
*   **Force Re-execution**: Force the re-run of a specific rule and everything downstream.
    `snakemake -R rule_name`
*   **Software Deployment**: Automatically create and use Conda environments defined in rules.
    `snakemake --use-conda --cores 4`

### Reporting and Visualization
*   **Generate Report**: Create an interactive HTML report containing results and provenance.
    `snakemake --report report.html`
*   **Visualize DAG**: Generate a directed acyclic graph of the workflow (requires Graphviz).
    `snakemake --dag | dot -Tpdf > dag.pdf`

## Expert Tips
*   **Checkpoints**: Use `checkpoint` instead of `rule` for steps where the output files are not known until the step is finished (e.g., a clustering step that produces a variable number of clusters).
*   **Input Functions**: Use Python functions as input to rules to handle complex logic or lookups based on wildcards.
*   **Profiles**: Save frequent command-line arguments (like cluster submission parameters) in a profile (e.g., `~/.config/snakemake/default/config.yaml`) to simplify execution to `snakemake --profile default`.
*   **Shadow Folders**: Use the `shadow` directive in rules to execute them in a temporary directory, preventing clutter from intermediate files.

## Reference documentation
- [Snakemake Overview](./references/snakemake_github_io_index.md)
- [Snakemake Workflow Catalog](./references/snakemake_github_io_workflow-catalog.md)
- [Snakemake Plugin Catalog](./references/snakemake_github_io_snakemake-plugin-catalog_index.html.md)