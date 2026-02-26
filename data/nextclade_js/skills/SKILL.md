---
name: nextclade_js
description: Nextclade identifies genetic variations, assigns clades, and performs quality control on viral sequences. Use when user asks to align sequences to a reference, identify mutations, assign lineages, or perform quality checks on viral genomes.
homepage: https://github.com/nextstrain/nextclade
---


# nextclade_js

## Overview
Nextclade is a bioinformatics tool designed to identify genetic variations in viral genomes. It aligns sequences to a reference, identifies mutations (substitutions, insertions, and deletions), assigns sequences to known clades (lineages), and performs quality checks to identify potential sequencing issues. This skill focuses on the command-line interface (CLI) workflow, which typically involves fetching a pathogen-specific dataset and then running the analysis on a set of FASTA sequences.

## Installation
The tool can be installed via Bioconda:
```bash
conda install bioconda::nextclade_js
```

## Core Workflow

### 1. Dataset Management
Before running an analysis, you must obtain the appropriate reference dataset (e.g., for SARS-CoV-2).

*   **List available datasets:**
    ```bash
    nextclade dataset list
    ```
*   **Download a specific dataset:**
    ```bash
    nextclade dataset get --name 'sars-cov-2' --output-dir 'data/sars-cov-2'
    ```

### 2. Running Analysis
Once the dataset is downloaded, you can process your sequences.

*   **Basic analysis command:**
    ```bash
    nextclade run \
      --input-fasta sequences.fasta \
      --dataset data/sars-cov-2 \
      --output-all output/
    ```

### 3. Output Selection
Nextclade generates several files by default when using `--output-all`. You can also specify individual outputs:
*   `--output-csv`: Summary of clades and mutations in CSV format.
*   `--output-tsv`: Summary in TSV format.
*   `--output-json`: Detailed analysis results in JSON.
*   `--output-tree`: Phylogenetic tree (Auspice JSON format) with your sequences placed on it.
*   `--output-fasta`: Aligned sequences.

## Best Practices and Tips
*   **Quality Control:** Always review the `qc.status` column in the output CSV/TSV. Sequences marked as "bad" or "mediocre" may have high levels of missing data (N's), private mutations, or mixed sites that could skew results.
*   **Version Consistency:** Ensure the version of the Nextclade CLI matches the requirements of the dataset you are using. Use `nextclade --version` to check.
*   **Memory Management:** For very large FASTA files, Nextclade is efficient, but ensure you have sufficient disk space for the `--output-all` files, especially the aligned FASTA and the phylogenetic tree.
*   **Proxy Settings:** If downloading datasets behind a corporate proxy, ensure your environment variables (`HTTP_PROXY`, `HTTPS_PROXY`) are correctly configured to avoid connection errors.

## Reference documentation
- [bioconda | nextclade_js Overview](./references/anaconda_org_channels_bioconda_packages_nextclade_js_overview.md)
- [Nextclade GitHub Repository](./references/github_com_nextstrain_nextclade.md)
- [Nextclade Discussions](./references/github_com_nextstrain_nextclade_discussions.md)