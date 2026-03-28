---
name: nullarbor
description: Nullarbor is a bioinformatics pipeline that automates the analysis of bacterial genomic data for public health surveillance and outbreak investigation. Use when user asks to perform reads-to-report analysis, identify antimicrobial resistance profiles, or generate phylogenetic trees for bacterial isolates.
homepage: https://github.com/tseemann/nullarbor
---


# nullarbor

## Overview
Nullarbor is a "reads-to-report" pipeline designed for bacterial isolate surveillance and outbreak investigation. It orchestrates a suite of bioinformatics tools (such as Kraken, Prokka, Snippy, and Roary) to provide a unified analysis of genomic data. It is particularly effective for processing batches of isolates from suspected outbreaks to determine genomic relationships and resistome profiles.

## Core Workflow

### 1. Environment Validation
Before starting a run, verify that all required binaries, Perl modules, and genomic databases (Kraken, Centrifuge) are correctly installed and accessible.
```bash
nullarbor.pl --check
```

### 2. Input Preparation
Nullarbor requires a tab-separated `samples.tab` file. Each line represents one isolate with three columns:
- **ID**: Unique isolate name.
- **R1**: Path to the first paired-end read file.
- **R2**: Path to the second paired-end read file.

Example `samples.tab`:
```text
IsolateA    /path/to/A_R1.fq.gz    /path/to/A_R2.fq.gz
IsolateB    /path/to/B_R1.fq.gz    /path/to/B_R2.fq.gz
```

### 3. Project Initialization
Generate the analysis directory and Makefile. You must provide a reference genome (FASTA or Genbank format). Using a Genbank file allows nullarbor to use existing annotations for SNP reporting.
```bash
nullarbor.pl --name ProjectName --ref reference.gbk --input samples.tab --outdir output_dir
```

### 4. Execution
Nullarbor generates a Makefile to manage the workflow. Execute the analysis using `make`. Use the `-j` flag to specify the number of CPU cores.
```bash
make -j 8 -C output_dir
```

## Expert Patterns and Best Practices

### Outlier Detection with Preview Mode
To avoid wasting time on a full run with contaminated or poor-quality isolates, use the "preview" mode to generate a quick, rough phylogenetic tree.
1. Run `make preview -C output_dir`.
2. Inspect the mini-report to identify outliers.
3. Remove or comment out bad isolates in `samples.tab`.
4. Run `make again -C output_dir` to reset, then proceed with the full `make`.

### Efficiency with Prefilling
If you are running a new analysis that includes isolates processed in previous nullarbor runs, use the `--prefill` option in your `nullarbor.conf` to copy existing assembly files (`contigs.fa`) instead of re-assembling them.

### Tool Selection
Nullarbor allows swapping components via CLI flags during initialization:
- **Assembler**: Choose between `--assembler skesa` (fast/conservative) or `spades` (standard).
- **Taxonomy**: Use `--taxoner kraken2` for the most up-to-date species identification, provided the database is configured.

### Result Inspection
The primary output is a self-contained HTML report located at `output_dir/report/index.html`. It includes:
- QC metrics (coverage, contamination).
- MLST and AMR profiles.
- Interactive SNP phylogeny and distance matrices.



## Subcommands

| Command | Description |
|---------|-------------|
| make | GNU Make is a utility that determines which pieces of a large program need to be recompiled, and issues commands to recompile them. |
| nullarbor.pl | Reads to reports for public health microbiology |

## Reference documentation
- [Nullarbor GitHub Repository](./references/github_com_tseemann_nullarbor.md)