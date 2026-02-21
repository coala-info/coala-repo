---
name: snakelines
description: SnakeLines is a specialized extension of the Snakemake workflow management system tailored for high-throughput sequencing analysis.
homepage: https://snakelines.readthedocs.io/en/latest/
---

# snakelines

## Overview

SnakeLines is a specialized extension of the Snakemake workflow management system tailored for high-throughput sequencing analysis. It simplifies the execution of complex bioinformatics procedures by automatically managing software dependencies through virtual environments. This skill should be used when you need to process Illumina or Nanopore reads, generate standardized reports, or extend existing genomic pipelines without manually installing individual bioinformatic tools.

## Execution and CLI Patterns

The primary interface for SnakeLines is a wrapper around the Snakemake command line.

### Standard Execution
To run a pipeline, navigate to your project root and use the following command:
`snakelines --configfile [YOUR_CONFIG].yaml --use-conda --cores [NUMBER_OF_CORES]`

### Validation and Dry Runs
Always validate the workflow before execution to check for missing files or syntax errors:
`snakelines --configfile [YOUR_CONFIG].yaml --dryrun`

### Visualization
To examine the directed acyclic graph (DAG) of the rules and dependencies:
`snakelines --configfile [YOUR_CONFIG].yaml --rulegraph | dot | display`

### Cluster Execution
If working on an SGE (Sun Grid Engine) cluster, use the `--cluster` flag to distribute jobs. Common patterns involve specifying output and error log paths within the cluster command string to ensure traceability.

## Project Structure Requirements

SnakeLines relies on a strict directory hierarchy to automatically locate input files. Ensure your project follows this convention:

- **Reads**: Place all raw gzipped fastq files in `reads/original/`. Paired-end files must follow the `_R1.fastq.gz` and `_R2.fastq.gz` naming convention.
- **References**: Store reference genomes in `reference/[genome_name]/[genome_name].fa`.
- **Annotations**: Place targeted panel BED files in `reference/[genome_name]/annotation/[panel_name]/regions.bed`.
- **Logs**: SnakeLines automatically generates a `log/` directory within the output folders for standard error and output streams.

## Expert Tips and Best Practices

- **Reference Linking**: Instead of copying large genomic fasta files into every project, use symbolic links (`ln -s`) to point to a central reference repository. Ensure the link name matches the fasta filename (minus the extension).
- **Environment Management**: Use the `--use-conda` flag consistently. SnakeLines creates isolated environments for different steps, preventing version conflicts between tools like BWA, GATK, or Samtools.
- **Resuming Jobs**: If a pipeline is interrupted, Snakemake's internal tracking allows you to resume from the last successful step by running the same command again.
- **Reporting**: Check the `report/` directory (or the path defined in your configuration) for aggregated HTML and PDF reports. SnakeLines is designed to pull essential results out of the complex intermediate folder structure into this single location.
- **Custom Rules**: When developing new rules, follow the `{tool}__{action}` naming convention (e.g., `samtools__sort_mapped_reads`) to maintain compatibility with SnakeLines' internal dependency tracking.

## Reference documentation
- [Running SnakeLines](./references/snakelines_readthedocs_io_en_latest_user_running.html.md)
- [Useful bash aliases](./references/snakelines_readthedocs_io_en_latest_user_aliases.html.md)
- [Developing new rules](./references/snakelines_readthedocs_io_en_latest_development_new_rules.html.md)
- [Configuration of a pipeline](./references/snakelines_readthedocs_io_en_latest_user_configuration.html.md)