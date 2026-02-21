---
name: m6anet
description: m6anet is a specialized tool designed to identify m6A RNA modifications by analyzing the raw ionic current signal from Nanopore direct RNA sequencing.
homepage: https://github.com/GoekeLab/m6anet
---

# m6anet

## Overview

m6anet is a specialized tool designed to identify m6A RNA modifications by analyzing the raw ionic current signal from Nanopore direct RNA sequencing. It leverages a Multiple Instance Learning (MIL) framework to handle the stochastic nature of Nanopore signals. Use this skill to guide the transition from raw basecalled reads to site-specific modification probabilities, including data segmentation, feature extraction, and model inference for various species and chemistry versions (RNA002/RNA004).

## Installation

Install via pip (recommended) or conda:

```bash
pip install m6anet
# OR
conda install -c bioconda m6anet
```

## Workflow and CLI Patterns

### 1. Prerequisites (External)
Before using m6anet, you must generate an `eventalign.txt` file using `nanopolish` (for RNA002) or `f5c` (for RNA004). This segments the raw signal to specific transcriptomic positions.

```bash
nanopolish eventalign --reads reads.fastq --bam reads.sorted.bam --genome transcript.fa --scale-events --signal-index --summary summary.txt --threads 50 > eventalign.txt
```

### 2. Data Preparation
Preprocess the `eventalign.txt` file to extract features for the model.

```bash
m6anet dataprep --eventalign /path/to/eventalign.txt \
                --out_dir /path/to/output \
                --n_processes 4
```
*   **Outputs**: `data.json` (features), `data.info` (indexing), and `eventalign.index`.

### 3. Inference
Run the prediction model on the prepared data.

```bash
m6anet inference --input_dir /path/to/output \
                --out_dir /path/to/output \
                --n_processes 4 \
                --num_iterations 1000
```

**Model Selection**:
*   **Human (Default)**: Trained on HCT116.
*   **Arabidopsis**: Use `--pretrained_model arabidopsis_RNA002`.
*   **RNA004 Chemistry**: Use `--pretrained_model HEK293T_RNA004`.

### 4. Handling Replicates
m6anet supports pooling multiple replicates during the inference stage for more robust site-level predictions.

```bash
m6anet inference --input_dir data_folder_1 data_folder_2 --out_dir pooled_output
```

## Interpreting Results

The tool produces two primary CSV files:

1.  **data.site_proba.csv**: Site-level modification probabilities.
    *   `probability_modified`: The probability that the site is modified. **Recommended threshold: 0.9**.
    *   `mod_ratio`: Estimated percentage of modified reads at that site.
2.  **data.indiv_proba.csv**: Read-level (individual molecule) probabilities.
    *   `probability_modified`: Probability for a specific read.

## Expert Tips and Best Practices

*   **RNA004 Specifics**: When working with RNA004 data, you must use `f5c eventalign` with the `--kmer-model` parameter pointing to the `rna004.nucleotide.5mer.model` before running `m6anet dataprep`.
*   **Memory Management**: For large datasets, the `dataprep` step can be resource-intensive. Increase `--n_processes` only if sufficient RAM is available.
*   **Thresholding**: The `mod_ratio` is calculated based on a model-specific `read_proba_threshold`. For the default human model, this is ~0.033; for Arabidopsis, it is ~0.0033.
*   **DRACH Motif**: m6anet is optimized for the DRACH motif (D=A/G/U, R=A/G, H=A/C/U). Predictions at non-DRACH sites should be treated with caution.

## Reference documentation
- [m6anet GitHub Repository](./references/github_com_GoekeLab_m6anet.md)
- [m6anet Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_m6anet_overview.md)