---
name: predictosaurus
description: Predictosaurus is a haplotype-based bioinformatics tool that constructs variant graphs to predict genomic variant effects and extract peptide sequences. Use when user asks to build variant graphs from VCF files, process genomic features to calculate haplotype scores, or extract peptide sequences for neoantigen discovery.
homepage: https://github.com/fxwiegand/predictosaurus
metadata:
  docker_image: "quay.io/biocontainers/predictosaurus:0.8.4--hbcba35e_0"
---

# predictosaurus

## Overview

Predictosaurus is a specialized bioinformatics command-line tool that moves beyond simple site-based variant annotation by utilizing a haplotype-based approach. It constructs variant graphs from VCF files, allowing for the prediction of genomic variant effects while accounting for the uncertainty inherent in sequencing data. By integrating reference genomes, feature annotations (GFF), and variant observations, it can quantify the impact on transcripts and extract specific peptide sequences, making it a powerful asset for proteogenomics and neoantigen discovery workflows.

## Core Workflow

The standard predictosaurus pipeline consists of three primary stages: building the graph, processing features to calculate scores, and exporting results for visualization.

### 1. Building the Variant Graph
The `build` command creates a persistent variant graph stored in a DuckDB database.

```bash
predictosaurus build \
  --calls path/to/calls.vcf \
  --observations sample1=path/to/obs1.vcf \
  --min-prob-present 0.8 \
  --min-vaf 0.05 \
  --output graphs.duckdb
```

*   **Expert Tip**: Use `--min-prob-present` to filter out low-confidence variants early. The default is 0.8, but you can lower it (e.g., 0.65) if you need to explore more speculative haplotypes.
*   **Requirement**: Ensure sample names in the `--observations` flag match the sample names present in the `--calls` VCF.

### 2. Processing Features and Scoring
The `process` command maps the variant graph onto genomic features to calculate haplotype scores.

```bash
predictosaurus process \
  --features annotations.gff \
  --reference genome.fasta \
  --graph graphs.duckdb \
  --haplotype-metric geometric-mean \
  --output scores.duckdb
```

*   **Haplotype Metrics**: Choose between `product`, `geometric-mean` (default), or `minimum` depending on how you want to aggregate variant probabilities across a haplotype.
*   **Performance**: Use the `--threads` or `-t` flag to utilize multi-core processing for large GFF files.

### 3. Extracting Peptides
For neoantigen workflows, use the `peptides` command to generate FASTA files of potential peptide sequences.

```bash
predictosaurus peptides \
  --features annotations.gff \
  --reference genome.fasta \
  --graph graphs.duckdb \
  --sample sample1 \
  --interval 8-11 \
  --events somatic_event \
  --min-event-prob 0.8 \
  --output peptides.fasta
```

*   **Intervals**: The `--interval` flag (default 8-11) defines the amino acid length of the generated peptides, which is critical for MHC binding predictions.
*   **Probability Filtering**: Use `--min-event-prob` to ensure the extracted peptides meet a specific confidence threshold based on the summed probabilities of the variants and frameshifts involved.

### 4. Exporting and Plotting
To convert the internal DuckDB format into a human-readable or downstream-compatible format:

```bash
predictosaurus plot --input scores.duckdb --output scores.tsv
```

## CLI Best Practices

*   **Verbosity**: Always include `-v` or `--verbose` during initial runs to monitor the logging information and ensure the graph is building as expected.
*   **Resource Management**: If running on a shared HPC node, explicitly set `--threads` to match your allocated resources; otherwise, it defaults to all available logical cores.
*   **Reverse Strand Handling**: Predictosaurus automatically handles features on the reverse strand, including calculating 0-based positions and reverse complements.



## Subcommands

| Command | Description |
|---------|-------------|
| predictosaurus build | Build a full variant graph out of VCF files and store it |
| predictosaurus peptides | Output all distinct peptides from the given features to a fastq file per given CDS in the feature file |
| predictosaurus plot | Create visualizations and output HTML, TSV, or Vega specs |
| predictosaurus process | Retrieve subgraphs for individual features from the given GFF file |

## Reference documentation
- [Predictosaurus GitHub README](./references/github_com_fxwiegand_predictosaurus_blob_main_README.md)
- [Predictosaurus Changelog](./references/github_com_fxwiegand_predictosaurus_blob_main_CHANGELOG.md)