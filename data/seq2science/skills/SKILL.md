---
name: seq2science
description: Seq2science is an end-to-end pipeline manager that automates NGS data preprocessing from raw reads to analysis-ready files using standardized Snakemake workflows. Use when user asks to initialize project templates, execute sequencing workflows like RNA-seq or ATAC-seq, download public data by accession number, or generate technical methods for manuscripts.
homepage: https://vanheeringen-lab.github.io/seq2science
---


# seq2science

## Overview
Seq2science is an end-to-end pipeline manager built on Snakemake that simplifies the complex process of NGS data preprocessing. It handles everything from downloading raw fastq files and genome assemblies to read trimming, alignment, and quality control. It is particularly useful for researchers who want to transition from raw sequencing reads to analysis-ready files (BAMs, counts, trackhubs) using standardized, reproducible workflows without manually chaining individual bioinformatics tools.

## Core CLI Patterns

### Project Initialization
Before running a workflow, you must initialize a directory with template configuration files.
- `seq2science init {workflow}`: Generates template `samples.tsv` and `config.yaml` files for the specified workflow (e.g., `rna-seq`, `atac-seq`, `alignment`).

### Executing Workflows
- `seq2science run {workflow} --cores {n}`: Executes the pipeline using the specified number of CPU cores.
- `seq2science run {workflow} --snakemakeOptions scheduler=greedy`: Use this if the run is stuck on "Select jobs to execute," which often happens with large sample sizes.
- `seq2science run {workflow} --snakemakeOptions until=["rule_name"]`: Runs the pipeline only up to a specific step (e.g., stopping after trimming but before alignment).

### Documentation and Methods Generation
- `seq2science explain {workflow}`: Generates a technical explanation of the steps performed. This is highly useful for drafting the "Materials and Methods" section of a manuscript.

### Environment Management
- `seq2science clean`: Removes the conda environments created by the pipeline. Use this if you encounter `CreateCondaEnvironmentException` or need to reset the software stack.

## Expert Tips and Best Practices

### Public Data Handling
- When using public data, use the official accession numbers (GSM, SRR, ERR, etc.) in the `sample` column of your `samples.tsv`. Seq2science will automatically attempt to find the fastest download source (preferring ENA fastq over SRA dumps).
- For faster downloads, install `ascp` and provide the path in your configuration to use the Aspera protocol.

### Replicate Merging
- To merge technical replicates at the fastq level, give them the same name in the `technical_replicates` column of the `samples.tsv`. Seq2science will concatenate the reads before alignment, which is more efficient than merging BAM files later.

### Memory and Storage Issues
- **Temporary Files**: If you run out of space on `/tmp`, manually set a new temporary directory:
  `mkdir -p ./tmp && export TMPDIR=$PWD/tmp`
- **Memory Errors**: If you encounter `std::bad_alloc` (common in scRNA-seq workflows), it usually indicates the system ran out of RAM. Restarting the run often helps, but ensure no other memory-intensive processes are active.

### Genome Browser Integration
- Enable `create_trackhub: True` in your configuration to automatically generate a UCSC-compatible trackhub.
- If chromosome IDs mismatch (e.g., `chr1` vs `1`), set `force_assembly_hub: true` to generate an assembly hub that bypasses UCSC's default naming constraints.

### Aligner Selection
- For RNA-seq, `STAR` is the default and generally recommended.
- For ATAC-seq/ChIP-seq, `bwa-mem2` is preferred for speed, but if it crashes with a segmentation fault, switch to `bwa-mem`.

## Reference documentation
- [Getting started](./references/vanheeringen-lab_github_io_seq2science_content_gettingstarted.html.md)
- [Workflows Overview](./references/vanheeringen-lab_github_io_seq2science_content_workflows.html.md)
- [Alignment Workflow](./references/vanheeringen-lab_github_io_seq2science_content_workflows_alignment.html.md)
- [Frequently Asked Questions](./references/vanheeringen-lab_github_io_seq2science_content_faq.html.md)
- [Using the Results](./references/vanheeringen-lab_github_io_seq2science_content_results.html.md)