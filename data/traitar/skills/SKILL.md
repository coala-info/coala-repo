---
name: traitar
description: Traitar predicts microbial metabolic and physiological traits from genomic content. Use when user asks to predict microbial traits, phenotype microorganisms from genomic data, annotate protein families, or inspect trait models.
homepage: http://github.com/aweimann/traitar
---


# traitar

## Overview

Traitar (the microbial trait analyzer) is a specialized tool for predicting the metabolic and physiological traits of microorganisms based on their genomic content. It automates a complex pipeline—including gene prediction via Prodigal, protein family annotation via HMMer/Pfam, and phenotype classification using two distinct models (phyletic pattern and phylogeny-aware). Use this skill to transform raw sequence data into structured phenotypic profiles, allowing for the characterization of microbial samples without the need for traditional laboratory assays.

## Installation

Install Traitar via Bioconda:

```bash
conda install bioconda::traitar
```

## Core CLI Workflows

### Standard Phenotyping (From Nucleotides)
Use this command when starting with raw nucleotide FASTA files. Traitar will predict open reading frames (ORFs) before annotating.

```bash
traitar phenotype <input_directory> <sample_file> from_nucleotides <output_directory>
```

### Phenotyping from Pre-predicted Genes
Use this command if you have already performed gene prediction and want to start directly with Pfam annotation.

```bash
traitar phenotype <input_directory> <sample_file> from_genes <output_directory>
```

### Parallel Execution
Traitar supports parallel processing to speed up HMMer searches. This requires GNU Parallel to be installed.

```bash
# Use 4 CPU cores
traitar phenotype <in_dir> <sample_file> from_nucleotides <out_dir> -c 4
```

### Inspecting Trait Models
To understand which Pfam families contribute to a specific trait prediction:

```bash
traitar show 'Glucose fermenter'
```
*Note: Use `--predictor` to switch between `phypat` and `phypat+PGL` classifiers.*

## Input Requirements

### Sample File Format
The `<sample_file>` must be a tab-separated file with a mandatory header.

| sample_file_name | sample_name | category |
| :--- | :--- | :--- |
| genome1.fasta | E_coli_K12 | Enterobacteriaceae |
| genome2.fasta | B_subtilis | Bacillaceae |

*   **sample_file_name**: The filename located in the `<input_directory>`.
*   **sample_name**: The label used in output tables and plots.
*   **category**: (Optional) Used for grouping and color-coding in generated heatmaps.

## Interpreting Results

Traitar produces several key outputs in the `<output_directory>`:

1.  **Heatmaps**: `heatmap_comb.png` provides a visual summary of all predicted traits across samples.
2.  **Prediction Tables**: `predictions_majority-vote_combined.txt` uses a numerical encoding for confidence:
    *   `0`: Negative prediction (trait absent).
    *   `1`: Predicted by the phyletic pattern classifier only.
    *   `2`: Predicted by the phylogeny-aware classifier only.
    *   `3`: Predicted by both algorithms (highest confidence).
3.  **Feature Tracks**: GFF files in `phypat/feat_gffs` allow you to visualize trait-relevant protein families in a genome browser.

## Expert Tips

*   **Resuming Runs**: If a process is interrupted, running the same command pointing to the existing output directory will prompt Traitar to resume from the last successful step (interactive mode only).
*   **Filename Limits**: Avoid filenames longer than 40 characters to prevent potential processing errors in certain environments.
*   **GFF Integration**: When using `from_genes`, you can provide an additional `gene_gff` column in your sample file and specify the source (e.g., `-g refseq`) to generate phenotype-specific Pfam tracks.

## Reference documentation

- [Traitar GitHub Repository](./references/github_com_aweimann_traitar.md)
- [Traitar Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_traitar_overview.md)