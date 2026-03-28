---
name: cutqc
description: cutqc automates adapter trimming and quality control for NGS data while generating interactive reports to compare metrics before and after processing. Use when user asks to trim adapter sequences, evaluate read quality with FastQC, or generate a comparative quality control report for paired-end or single-end sequencing data.
homepage: https://github.com/obenno/cutqc
---


# cutqc

## Overview

`cutqc` is a bioinformatics utility designed to streamline the initial stages of NGS data processing. It automates the execution of `cutadapt` for removing adapter sequences and `FastQC` for evaluating read quality. Its primary value lies in its ability to generate a comprehensive, interactive HTML report (using RMarkdown and Plotly) that compares data quality metrics before and after the trimming process. This allows researchers to quickly verify the effectiveness of their trimming parameters and the overall health of their sequencing data.

## CLI Usage Patterns

The tool is invoked via the `cutqc.sh` script and supports two primary subcommands: `cutqc` (for paired-end data) and `qc_only` (for single-file assessment).

### Paired-End Processing (cutqc)
This is the core workflow which performs FastQC on raw reads, runs cutadapt, and then performs FastQC on the trimmed results.

```bash
cutqc.sh cutqc <in_R1.fq.gz> <in_R2.fq.gz> <out_report.html> [cutadapt_options]
```

*   **Mandatory Arguments**: The first three positional arguments must be the Forward Read (R1), Reverse Read (R2), and the desired name for the output HTML report.
*   **Passing Options**: Any arguments provided after the output filename are passed directly to `cutadapt`.
*   **Constraint**: Do not pass `-o` or `-p` manually, as the wrapper manages output file naming automatically.

### Single-End Quality Control (qc_only)
Use this when you only need a quality report for a single FASTQ file without performing any trimming.

```bash
cutqc.sh qc_only <in_read.fq.gz> [output_report.html]
```

## Expert Tips and Best Practices

*   **Input Format**: `cutqc` strictly requires gzipped input files (`.fq.gz` or `.fastq.gz`). Ensure your data is compressed before running.
*   **Adapter Trimming**: Since `cutqc` passes extra arguments to `cutadapt`, you should specify your adapter sequences using standard `cutadapt` flags (e.g., `-a ADAPTER_FWD -A ADAPTER_REV`).
*   **Resource Management**: The script is hardcoded to use 2 threads (`-t 2`) for FastQC. If running on a high-performance cluster, ensure your resource request matches this or modify the script if higher parallelism is required.
*   **Output Files**: When running the `cutqc` subcommand, the tool generates intermediate trimmed files named `<filename>.trimmed.fq.gz` in the working directory. Ensure you have sufficient disk space for these temporary files.
*   **Environment Requirements**: To function correctly, the environment must have `cutadapt`, `fastqc`, `Rscript`, and the R packages `rmarkdown`, `tidyverse`, `plotly`, and `scales` installed.



## Subcommands

| Command | Description |
|---------|-------------|
| cutqc.sh | Performs quality control on sequencing reads, optionally with adapter trimming. |
| fastqc | FastQC reads a set of sequence files and produces from each one a quality control report consisting of a number of different modules, each one of which will help to identify a different potential type of problem in your data. |

## Reference documentation

- [Cutqc GitHub README](./references/github_com_obenno_cutqc_blob_main_README.md)
- [Cutqc Shell Script Source](./references/github_com_obenno_cutqc_blob_main_cutqc.sh.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_cutqc_overview.md)