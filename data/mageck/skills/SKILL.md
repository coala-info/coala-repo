---
name: mageck
description: MAGeCK is a computational pipeline for analyzing genome-scale CRISPR-Cas9 knockout screens to identify significantly enriched or depleted genes. Use when user asks to generate read counts from FASTQ files, perform differential enrichment analysis between treatment and control samples, or conduct pathway analysis on screen results.
homepage: http://mageck.sourceforge.net
metadata:
  docker_image: "quay.io/biocontainers/mageck:0.5.9.5--py310h184ae93_8"
---

# mageck

## Overview
MAGeCK is a computational pipeline designed for the robust analysis of genome-scale CRISPR-Cas9 knockout screens. It enables researchers to process raw sequencing data (FASTQ) or count tables to determine which genes are significantly enriched or depleted under specific experimental conditions. By employing a hierarchical model that accounts for sgRNA-level variance and ranking, it provides high sensitivity and low false discovery rates for identifying biological hits.

## Core Workflows

### 1. Generating Read Counts
Use the `count` command to process FASTQ files and map them to a library of sgRNAs.

```bash
mageck count -l library.txt -n output_prefix \
  --sample-label L1,E1 \
  --fastq line1.fastq.gz line2.fastq.gz
```
- `-l`: A tab-separated file containing sgRNA ID, sequence, and gene name.
- `--sample-label`: Comma-separated labels for the samples.
- Output: `.count.txt` (raw counts) and `.countsummary.txt` (QC metrics).

### 2. Testing for Gene Enrichment/Depletion
Use the `test` command to compare treatment vs. control samples using the Robust Rank Aggregation (RRA) algorithm.

```bash
mageck test -k counts.txt -t Treatment -c Control -n experiment_name
```
- `-k`: The count table generated in the previous step.
- `-t` / `-c`: Labels for treatment and control samples (must match count table headers).
- Output: `.gene_summary.txt` (gene-level scores/p-values) and `.sgrna_summary.txt` (sgRNA-level performance).

### 3. Pathway Analysis
Identify enriched biological pathways from the gene-level results.

```bash
mageck pathway --gene-ranking experiment_name.gene_summary.txt \
  --gmt pathways.gmt -n pathway_output
```

## Expert Tips & Best Practices
- **Library Quality**: Always check the `countsummary.txt` file. High "Gini Index" values or a high percentage of "ZeroCounts" indicate poor library representation or sequencing depth issues.
- **Normalization**: MAGeCK defaults to "median" normalization. If your screen has a high percentage of positive hits (e.g., a survival screen), consider using `--norm-method control` with a list of non-targeting control sgRNAs.
- **Paired Samples**: If your experimental design includes paired replicates, ensure they are handled correctly in the sample labeling to improve statistical power.
- **Visualizations**: Use the generated PDF reports to inspect read count distributions and PCA plots to ensure replicates cluster together.



## Subcommands

| Command | Description |
|---------|-------------|
| mageck mle | Maximum Likelihood Estimation (MLE) module for MAGeCK. |
| mageck pathway | Pathway enrichment analysis. |
| mageck test | Perform differential analysis of CRISPR screens. |
| mageck_count | Count reads for MAGeCK analysis. |
| mageck_plot | Plotting function for MAGeCK |

## Reference documentation
- [MAGeCK Overview](./references/sourceforge_net_projects_mageck.md)
- [MAGeCK Files and Examples](./references/sourceforge_net_projects_mageck_files.md)
- [MAGeCK Support and Wiki](./references/sourceforge_net_projects_mageck_support.md)