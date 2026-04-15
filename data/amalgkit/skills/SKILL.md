---
name: amalgkit
description: Amalgkit is a toolkit for integrating and normalizing disparate RNA-seq datasets to facilitate cross-species evolutionary transcriptomic analysis. Use when user asks to retrieve SRA metadata, quantify transcript abundance, perform cross-species TMM normalization, or curate expression matrices for comparative analysis.
homepage: https://github.com/kfuku52/amalgkit
metadata:
  docker_image: "quay.io/biocontainers/amalgkit:0.12.20--pyhdfd78af_0"
---

# amalgkit

## Overview

amalgkit is a specialized toolkit designed for "transcriptome amalgamation"—the process of combining disparate RNA-seq datasets into a unified, comparable format for evolutionary analysis. It is particularly useful when you need to compare gene expression across different species where technical noise and batch effects often mask biological signals. The tool automates the retrieval of NCBI SRA metadata, handles the processing of raw fastq files, performs transcript abundance estimation, and applies cross-species TMM (cSTMM) normalization based on single-copy orthologs.

## Core Workflow and CLI Patterns

The amalgkit workflow follows a sequential pipeline. Each subcommand typically depends on the output of the previous step.

### 1. Metadata Retrieval and Integration
Start by fetching metadata from the NCBI SRA or integrating your own private data.
- **NCBI Data**: `amalgkit metadata --queries "Genus species"`
- **Private Data**: `amalgkit integrate --metadata metadata.tsv --fastq_dir ./path/to/fastq`

### 2. Sample Selection
Before downloading large datasets, filter for high-quality, relevant samples.
- **Initialize Config**: `amalgkit config --metadata metadata.tsv` (This creates control files for filtering).
- **Execute Selection**: `amalgkit select --metadata metadata.tsv`

### 3. Data Processing
Once samples are selected, proceed to quantification.
- **Download**: `amalgkit getfastq --metadata selected_metadata.tsv`
- **Quantify**: `amalgkit quant --metadata selected_metadata.tsv`
- **Merge**: `amalgkit merge --metadata selected_metadata.tsv` (Combines individual quantification results into a single expression matrix).

### 4. Normalization and Curation
This is the critical step for cross-species comparisons.
- **Cross-Species TMM**: `amalgkit cstmm --ortholog_table orthologs.tsv`
  - *Tip*: This requires a table of single-copy genes shared across the species being analyzed.
- **Automated Curation**: `amalgkit curate --input_dir ./merge_output`
  - This removes outlier samples and reduces unwanted technical biases.

### 5. Analysis and Validation
- **Correlation Analysis**: `amalgkit csca --input_dir ./curate_output`
  - Generates plots to visualize if samples cluster by biological identity (e.g., organ) rather than species.
- **Integrity Check**: `amalgkit sanity --input_dir ./`
  - Always run this to ensure the integrity of input and output files across the pipeline.

## Expert Tips

- **Parallelization**: Many subcommands support parallel processing. Use the `--threads` or `--parallel` flags where available to speed up quantification and fastq dumping.
- **Metadata Curation**: The `amalgkit metadata` command is powerful but can return noisy results. Always manually inspect the output or use `amalgkit select` with strict criteria to ensure tissue/organ labels are consistent.
- **Single-Copy Orthologs**: The quality of `cstmm` normalization depends heavily on the ortholog table. Ensure your ortholog detection (e.g., via OrthoFinder) is robust before running normalization.
- **Disk Space**: `getfastq` can consume massive amounts of storage. Use the `--remove_fastq` flag in the `quant` step if you do not need to keep the raw reads after mapping.

## Reference documentation

- [amalgkit GitHub Repository](./references/github_com_kfuku52_amalgkit.md)
- [amalgkit Wiki and Subcommands](./references/github_com_kfuku52_amalgkit_wiki.md)
- [Bioconda Installation Guide](./references/anaconda_org_channels_bioconda_packages_amalgkit_overview.md)