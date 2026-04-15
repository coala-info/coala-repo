---
name: nextclade_js
description: Nextclade performs viral genome alignment, mutation calling, clade assignment, and quality control checks. Use when user asks to analyze viral sequences, identify mutations, assign clades, or download pathogen-specific datasets.
homepage: https://github.com/nextstrain/nextclade
metadata:
  docker_image: "quay.io/biocontainers/nextclade:3.18.1--h9ee0642_0"
---

# nextclade_js

## Overview
Nextclade is a bioinformatic tool developed by the Nextstrain team for the rapid analysis of viral genomes. It performs sequence alignment against a reference, assigns sequences to specific clades or lineages, identifies mutations (nucleotide and amino acid), and conducts quality control checks to flag potential sequencing issues. While available as a web application, the `nextclade` CLI (often distributed via npm or bioconda as `nextclade_js`) is the standard for high-throughput, local processing of genomic data.

## Core Workflows

### 1. Dataset Management
Before running analysis, you must obtain the appropriate dataset for the pathogen being studied.

```bash
# List all available datasets
nextclade dataset list

# Download a specific dataset (e.g., SARS-CoV-2)
nextclade dataset get --name 'sars-cov-2' --output-dir 'data/sars-cov-2'
```

### 2. Running Analysis
The primary command for processing sequences is `run`. It requires a FASTA input and the dataset files downloaded in the previous step.

```bash
nextclade run \
  --input-dataset data/sars-cov-2 \
  --output-all output/ \
  sequences.fasta
```

### 3. Key Output Files
When using `--output-all`, Nextclade generates several critical files:
- `nextclade.csv/tsv`: Tabular summary of clades, mutations, and QC metrics.
- `nextclade.json`: Detailed results including phylogenetic placement data.
- `nextclade.aligned.fasta`: The sequences aligned to the reference.
- `nextclade.errors.csv`: Log of sequences that failed processing.

## Expert Tips and Best Practices

- **Pathogen Specificity**: Always ensure the dataset matches the input sequences. Using a SARS-CoV-2 dataset on Influenza sequences will result in alignment failure or nonsensical mutation calls.
- **Memory Management**: For very large FASTA files, use the `--jobs` flag to limit parallel processing if system memory is constrained.
- **QC Interpretation**: Pay close attention to the `qc.overallStatus` column in the output. Sequences marked as "bad" often contain high levels of missing data (Ns) or mixed sites that can skew phylogenetic placement.
- **Mutation Syntax**: Nextclade reports mutations relative to the reference sequence (e.g., `S:N501Y`). Ensure your downstream tools expect this standard notation.
- **Version Consistency**: When performing longitudinal studies, stick to a specific dataset version to ensure clade assignments remain stable across different runs.



## Subcommands

| Command | Description |
|---------|-------------|
| nextclade | Viral genome alignment, mutation calling, clade assignment, quality checks and phylogenetic placement. |
| nextclade dataset | List and download available Nextclade datasets (pathogens) |

## Reference documentation
- [Nextclade GitHub Repository](./references/github_com_nextstrain_nextclade.md)
- [Bioconda Nextclade Package Overview](./references/anaconda_org_channels_bioconda_packages_nextclade_js_overview.md)