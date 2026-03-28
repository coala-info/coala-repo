---
name: amplify
description: AMPlify discovers and classifies antimicrobial peptides from protein sequences using an attentive deep learning architecture. Use when user asks to predict antimicrobial activity, perform genome mining for peptides, or train custom models for peptide classification.
homepage: https://github.com/bcgsc/AMPlify
---


# amplify

## Overview

AMPlify is a specialized tool designed to discover and classify antimicrobial peptides (AMPs) using an attentive deep learning architecture. It is highly effective for bioinformatics workflows involving genome mining, transcriptomic analysis, or peptide drug discovery. The tool provides pre-trained models optimized for different data distributions (balanced vs. imbalanced) and allows for the extraction of attention scores to understand which parts of a sequence contribute most to its predicted activity.

## Installation and Environment

AMPlify requires a specific legacy environment. Always ensure the environment is active before execution.

```bash
conda create -n amplify python=3.6
conda activate amplify
conda install -c bioconda amplify
```

## Prediction Workflow

Use the `AMPlify` command to perform inference on peptide sequences.

### Model Selection Logic
*   **Balanced Model (Default)**: Use for curated candidate sets that have already been filtered by length, charge, or homology.
*   **Imbalanced Model**: Use for large, uncurated datasets (e.g., whole transcriptomes) where the number of non-AMPs significantly outweighs potential AMPs.

### Common Prediction Patterns

**Basic Prediction (TSV output)**:
```bash
AMPlify -s sequences.fa -of tsv -od ./results
```

**Large-scale Mining (Imbalanced Model)**:
```bash
AMPlify -m imbalanced -s transcriptomics_data.fa -od ./mining_results
```

**Interpretability (Attention Scores)**:
To see which amino acids the model is "focusing" on, enable attention scores.
```bash
AMPlify -s candidates.fa -att on -sub on
```

### Interpreting Results
*   **Probability Score**: Raw model output (0.0 to 1.0).
*   **AMPlify Score**: Log-scaled score calculated as `-10 * log10(1 - Probability)`.
*   **Classification Threshold**: By default, sequences with an **AMPlify score > 3.01** (Probability > 0.5) are classified as AMPs.

## Training Workflow

Use `train_amplify` to create custom models if the pre-trained weights are not suitable for your specific peptide domain.

**Basic Training Command**:
```bash
train_amplify -amp_tr positive_samples.fa \
              -non_amp_tr negative_samples.fa \
              -sample_ratio balanced \
              -out_dir ./my_models \
              -model_name custom_amp_model
```

## Expert Tips and Constraints

*   **Sequence Requirements**: AMPlify only accepts the 20 standard amino acids.
*   **Stop Codons**: If a sequence ends with an asterisk (`*`), AMPlify automatically ignores that last character, allowing the rest of the peptide to be processed.
*   **Invalid Sequences**: Any sequence containing non-standard characters (other than the trailing `*`) will result in `NA` values in the output.
*   **Performance Tuning**: When running on massive datasets, use the `-of tsv` format for easier downstream parsing with tools like `pandas` or `awk`.



## Subcommands

| Command | Description |
|---------|-------------|
| AMPlify.py | Predict whether a sequence is AMP or not. Input sequences should be in fasta format. Sequences should be shorter than 201 amino acids long, and should not contain amino acids other than the 20 standard ones. |
| train_amplify.py | AMPlify v2.0.0 training. Given training sets with two labels: AMP and non-AMP, train the AMP prediction model. |

## Reference documentation
- [AMPlify GitHub Repository](./references/github_com_BirolLab_AMPlify_blob_master_README.md)
- [AMPlify Conda Package Overview](./references/anaconda_org_channels_bioconda_packages_amplify_overview.md)