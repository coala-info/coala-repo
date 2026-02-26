---
name: snakemake-minimal_7.25.0--pyhdfd78af_0-test
description: Snakemake-minimal is a workflow management system that uses a Python-based declarative language to create reproducible and scalable data analysis pipelines. Use when user asks to define rules for transforming files, execute workflows with specific core allocations, perform dry runs to verify execution plans, or manage software environments using Conda.
homepage: https://snakemake.github.io
---


# snakemake-minimal_7.25.0--pyhdfd78af_0-test

## Overview
This skill facilitates the development and execution of Snakemake workflows. Snakemake is a Python-based execution environment that uses a declarative language to define "rules." Each rule specifies how to transform input files into output files. It is particularly useful for complex data science and bioinformatics pipelines where reproducibility, automation, and the ability to scale from local machines to high-performance computing (HPC) clusters are required.

## Core Workflow Patterns

### Rule Definition
The fundamental unit of a Snakemake workflow is the `rule`.
- **Input/Output**: Define file paths. Use wildcards in curly braces `{sample}` to generalize rules.
- **Shell/Script**: Use `shell:` for command-line tools or `script:` to point to external Python/R/Julia scripts.
- **Wildcards**: Snakemake automatically matches wildcards to determine dependencies.

```python
rule map_reads:
    input:
        "data/samples/{sample}.fastq"
    output:
        "results/mapped/{sample}.bam"
    shell:
        "bwa mem ref.fa {input} | samtools view -Sb - > {output}"
```

### Software Deployment
To ensure reproducibility, define environments per rule.
- **Conda**: Reference a `.yaml` file containing the required packages.
- **Execution**: Run with `--use-conda` to trigger automatic environment creation.

```python
rule analyze:
    input: "data.csv"
    output: "report.pdf"
    conda: "envs/stats.yaml"
    script: "scripts/analyze.py"
```

## Common CLI Patterns

### Execution Commands
- **Dry Run**: Always perform a dry run first to verify the execution plan.
  `snakemake -n`
- **Visualizing the DAG**: View the directed acyclic graph of jobs.
  `snakemake --dag | dot -Tpdf > dag.pdf`
- **Core Allocation**: Specify the number of available CPU cores.
  `snakemake --cores 4`
- **Target Specific File**: Run only the parts of the workflow needed to create a specific file.
  `snakemake results/mapped/sample1.bam`

### Debugging and Maintenance
- **Unlock Directory**: If a previous run was interrupted, the working directory might be locked.
  `snakemake --unlock`
- **List Files**: Show all output files and their status.
  `snakemake --list-output-files`
- **Reasoning**: Show why a rule is being executed.
  `snakemake -n -r`

## Expert Tips
- **Rule 'all'**: By default, Snakemake executes the first rule in the Snakefile. Define a `rule all` at the top that lists all final desired outputs as its inputs.
- **Checkpoints**: Use `checkpoint` instead of `rule` for steps where the output files are not known until the rule has finished (e.g., a clustering step that produces a variable number of clusters).
- **Profiles**: Instead of long CLI strings, use profiles (e.g., `--profile slurm`) to store configuration for specific execution environments like cluster schedulers.
- **Benchmarking**: Use the `benchmark:` directive in a rule to automatically record the time and memory usage of a specific step.

## Reference documentation
- [Snakemake Overview](./references/anaconda_org_channels_bioconda_packages_snakemake_overview.md)
- [Snakemake Homepage and Syntax Examples](./references/snakemake_github_io_index.md)
- [Snakemake Plugin Catalog](./references/snakemake_github_io_snakemake-plugin-catalog_index.html.md)