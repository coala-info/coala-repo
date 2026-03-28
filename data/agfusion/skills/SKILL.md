---
name: agfusion
description: AGFusion annotates and visualizes gene fusion events to predict their functional impact on protein structure. Use when user asks to annotate specific gene fusion junctions, batch process results from fusion-calling algorithms, or generate domain maps for chimeric proteins.
homepage: https://github.com/murphycj/AGFusion
---


# agfusion

## Overview

AGFusion is a specialized bioinformatics tool designed to provide comprehensive annotation for gene fusion events. It bridges the gap between identifying a fusion junction and understanding its biological consequences. By integrating Ensembl data, it predicts whether a fusion is in-frame or out-of-frame and generates visual representations of the resulting chimeric protein compared to wild-type partners. This skill enables the automated processing of single fusion pairs or batch processing of results from common fusion-calling pipelines.

## Installation and Database Setup

Before annotation, the environment must have both the `pyensembl` and `agfusion` databases initialized for the specific genome build.

```bash
# 1. Install pyensembl genome (e.g., Human GRCh38)
pyensembl install --species homo_sapiens --release 95

# 2. Download AGFusion database
agfusion download -g hg38
```

Available genome flags: `hg38`, `hg19`, `mm10`. Use `agfusion download -a` to see all supported Ensembl releases.

## Common CLI Patterns

### Single Fusion Annotation
Annotate a specific fusion by providing the 5' and 3' gene partners and their respective genomic junction coordinates.

```bash
agfusion annotate \
  --gene5prime DLG1 \
  --gene3prime BRAF \
  --junction5prime 31684294 \
  --junction3prime 39648486 \
  -db agfusion.mus_musculus.87.db \
  -o DLG1-BRAF_output
```

### Batch Processing from Callers
AGFusion supports direct input from various fusion-finding algorithms (e.g., STAR-Fusion, FusionCatcher, Arriba).

```bash
agfusion batch \
  -f final-list_candidate-fusion-genes.txt \
  -a fusioncatcher \
  -db agfusion.homo_sapiens.95.db \
  -o batch_results
```

Supported algorithms include: `arriba`, `defuse`, `fusioncatcher`, `starfusion`, `jaffa`, `longgf`, `ericscript`, and `tophatfusion`.

## Expert Tips and Customization

### Handling Isoforms
*   **Canonical Only (Default):** AGFusion defaults to the canonical isoform to reduce noise.
*   **Non-canonical:** Use the `--noncanonical` flag to analyze all possible transcript combinations, which is critical if the fusion involves a specific tissue-expressed variant.

### Visualization Tweaks
*   **Wild-type Comparison:** Use `--WT` to generate plots for the original, non-fused genes alongside the fusion for structural comparison.
*   **Recoloring Domains:** Highlight specific domains of interest (e.g., Kinase domains) for publication-quality figures.
    ```bash
    --recolor "Pkinase_Tyr;red" --rename "Pkinase_Tyr;Kinase"
    ```

### Output Files
AGFusion produces a structured output directory:
*   `*.fasta`: Sequences for the fusion transcript.
*   `*.png/pdf`: High-resolution domain and exon maps.
*   `*.csv/tsv`: Coordinates for protein features and exons.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotate and visualize gene fusion events using the AGFusion database. |
| batch | AGFusion batch processing for fusion-finding algorithm outputs to visualize and analyze gene fusions. |
| build | Build the AGFusion database for a specific species and Ensembl release. |
| download | Download the AGFusion database for specific genomes, species, and releases. |

## Reference documentation

- [Annotate Gene Fusion (AGFusion) README](./references/github_com_murphycj_AGFusion_blob_master_README.md)