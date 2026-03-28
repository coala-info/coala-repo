---
name: seq2science
description: seq2science is a command-line toolset that streamlines functional genomics analysis by wrapping complex Snakemake workflows into a user-friendly interface. Use when user asks to download sequencing data, align reads to a reference, perform RNA-seq or ATAC-seq analysis, call peaks for ChIP-seq, or initialize and run reproducible genomic pipelines.
homepage: https://vanheeringen-lab.github.io/seq2science
---


# seq2science

## Overview

seq2science is a command-line toolset designed to streamline functional genomics analysis. It wraps complex Snakemake workflows into a user-friendly interface, allowing both beginners and experts to process raw sequencing data into analysis-ready files (like count matrices or peak files). The tool handles the heavy lifting of environment management via Conda/Mamba, genome indexing, and data retrieval, ensuring that research is reproducible and follows best practices for various sequencing modalities.

## Core CLI Patterns

The tool operates through three primary subcommands: `init`, `run`, and `explain`.

### Initializing a Project
To start a new analysis, use the `init` command to generate the necessary template files for a specific workflow.
- `seq2science init rna_seq`
- `seq2science init atac_seq`
- `seq2science init download_fastq`

### Executing Workflows
The `run` command executes the pipeline. It requires a workflow name and a configuration file.
- **Basic execution**: `seq2science run <workflow> --configfile <config.yaml> --cores 8`
- **Dry run**: Always perform a dry run first to validate the execution plan: `seq2science run <workflow> --configfile <config.yaml> --dry-run`
- **Passing Snakemake options**: Use the `--snakemakeOptions` flag to pass native Snakemake arguments (e.g., for cluster execution or specific resource limits): `seq2science run <workflow> --snakemakeOptions "--jobs 10 --latency-wait 60"`

### Understanding the Pipeline
To see a detailed description of what a specific workflow does, including the tools involved:
- `seq2science explain <workflow>`

## Supported Workflows

- **download_fastq**: Downloads data from SRA, ENA, ENCODE, or GSA using accession IDs (e.g., SRR, ERR, ENCSR, CRX).
- **alignment**: Generic alignment of reads to a reference genome.
- **rna_seq / scrna_seq**: Differential expression analysis, gene counts, and single-cell quality control.
- **atac_seq / scatac_seq**: Peak calling, motif analysis, and single-cell accessibility.
- **chip_seq**: Transcription factor or histone modification peak calling and analysis.

## Expert Tips and Best Practices

- **Public Data Integration**: You can mix local fastq files with public accession IDs in your samples table. seq2science will automatically detect and download the missing public data.
- **Genome Management**: The tool uses `genomepy` under the hood. If a genome is not found locally, it will attempt to download it from providers like UCSC, Ensembl, or NCBI based on the assembly name provided in your configuration.
- **Replicate Handling**: Define technical replicates (same library, multiple runs) and biological replicates in your samples table. seq2science can automatically merge technical replicates before processing.
- **Resource Optimization**: For large-scale runs, use the `--snakemakeOptions` to specify a profile (e.g., `--snakemakeOptions "--profile slurm"`) to distribute jobs across a high-performance computing (HPC) cluster.
- **Trackhubs**: By default, seq2science generates a UCSC-compatible trackhub. You can visualize your results immediately by hosting the `trackhub` directory on a web-accessible server and pointing the UCSC Genome Browser to the `hub.txt` file.
- **CRAM Support**: For workflows like ATAC, ChIP, and RNA-seq, seq2science supports the CRAM format to save disk space while maintaining high-fidelity alignment data.



## Subcommands

| Command | Description |
|---------|-------------|
| explain | Explains what has/will be done for the workflow. This prints a string which can serve as a skeleton for your material & methods section. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq |
| init | Initialises a default configuration and samples file for a specific workflow. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq. |
| run | Run a complete workflow. This requires that a config and samples file are either present in the current directory, or passed as an argument. Supported workflows: scrna-seq, download-fastq, rna-seq, alignment, atac-seq, scatac-seq, chip-seq |

## Reference documentation

- [seq2science GitHub Repository](./references/github_com_vanheeringen-lab_seq2science.md)
- [seq2science Documentation Home](./references/vanheeringen-lab_github_io_seq2science.md)
- [Changelog and Version History](./references/github_com_vanheeringen-lab_seq2science_blob_master_CHANGELOG.md)
- [Getting Started Guide](./references/vanheeringen-lab_github_io_seq2science_content_gettingstarted.html.md)
- [Frequently Asked Questions](./references/vanheeringen-lab_github_io_seq2science_content_faq.html.md)