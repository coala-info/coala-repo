---
name: m6anet
description: m6anet identifies m6A modifications in Nanopore Direct RNA sequencing data using a Multiple Instance Learning framework. Use when user asks to preprocess eventalign data, run inference to predict modification probabilities, or identify methylated sites at the read and transcript level.
homepage: https://github.com/GoekeLab/m6anet
metadata:
  docker_image: "quay.io/biocontainers/m6anet:2.1.0--pyhdfd78af_0"
---

# m6anet

## Overview

m6Anet is a Python-based tool that utilizes a Multiple Instance Learning (MIL) framework to identify m6A modifications in Nanopore Direct RNA data. It transforms raw ionic current signals into modification probabilities, allowing researchers to pinpoint methylated sites at both the individual read level and the transcriptomic site level. Use this skill to navigate the transition from raw signal alignment (via nanopolish or f5c) to final modification calls and to select the appropriate pre-trained models for your specific biological context.

## Installation

Install m6anet via pip or conda:

```bash
pip install m6anet
# OR
conda install m6anet -c bioconda
```

## Core Workflow

### 1. Data Preprocessing (External)
Before using m6anet, you must generate an `eventalign.txt` file using `nanopolish eventalign`. This segments the raw signal to specific positions in the transcriptome.

```bash
nanopolish eventalign --reads reads.fastq --bam reads.sorted.bam --genome transcript.fa --scale-events --signal-index --summary summary.txt --threads 50 > eventalign.txt
```

### 2. m6anet Dataprep
Convert the `eventalign.txt` into a format compatible with m6anet. This step creates `data.json` and indexing files.

```bash
m6anet dataprep --eventalign /path/to/eventalign.txt \
                --out_dir /path/to/output \
                --n_processes 4
```

### 3. m6anet Inference
Run the prediction model on the prepared data.

```bash
m6anet inference --input_dir /path/to/dataprep_output \
                --out_dir /path/to/inference_output \
                --n_processes 4 \
                --num_iterations 1000
```

## Model Selection

Specify the `--pretrained_model` argument based on your sample type:

| Sample/Chemistry | Model Name |
| :--- | :--- |
| Human (HCT116) RNA002 | (Default - no flag needed) |
| Arabidopsis RNA002 | `arabidopsis_RNA002` |
| Human (HEK293T) RNA004 | `HEK293T_RNA004` |

**Example for RNA004:**
```bash
m6anet inference --input_dir ./data --out_dir ./results --pretrained_model HEK293T_RNA004
```

## Interpreting Results

m6anet produces two primary output files in the output directory:

1.  **data.indiv_proba.csv**: Read-level probabilities.
    *   `probability_modified`: Likelihood that a specific read at a specific position is modified.
2.  **data.site_proba.csv**: Site-level probabilities.
    *   `probability_modified`: The probability that the site is modified (Recommended threshold: **> 0.9**).
    *   `mod_ratio`: Estimated percentage of modified reads at that site.

## Expert Tips

*   **Replicate Pooling**: You can pool multiple replicates during inference by passing multiple input directories:
    `m6anet inference --input_dir rep1_dir rep2_dir --out_dir pooled_results`
*   **RNA004 Requirements**: If using the RNA004 model, ensure you use `f5c eventalign` with the specific RNA004 k-mer model instead of standard nanopolish.
*   **Performance**: The `--num_iterations` parameter (default 1000) controls the sampling of reads. Higher values increase stability but extend runtime.
*   **Thresholding**: While the default `read_proba_threshold` is model-specific, a site-level threshold of 0.9 is the standard recommendation for high-confidence m6A calls.



## Subcommands

| Command | Description |
|---------|-------------|
| m6anet | m6anet: error: argument command: invalid choice: 'additional' (choose from 'dataprep', 'inference', 'train', 'compute_norm_factors', 'convert') |
| m6anet | m6anet: error: argument command: invalid choice: 'valid' (choose from 'dataprep', 'inference', 'train', 'compute_norm_factors', 'convert') |

## Reference documentation
- [m6anet README](./references/github_com_GoekeLab_m6anet_blob_master_README.md)
- [m6anet Overview](./references/anaconda_org_channels_bioconda_packages_m6anet_overview.md)