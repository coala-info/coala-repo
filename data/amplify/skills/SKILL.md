---
name: amplify
description: AMPlify is an attentive deep learning model designed to identify antimicrobial peptides (AMPs) with high precision.
homepage: https://github.com/bcgsc/AMPlify
---

# amplify

## Overview

AMPlify is an attentive deep learning model designed to identify antimicrobial peptides (AMPs) with high precision. It is specifically optimized for genomic and transcriptomic mining, allowing researchers to scan large sequence databases for novel peptides that may have antimicrobial properties. This skill provides the necessary command-line patterns to run predictions on FASTA files and train custom models using specific datasets.

## Installation

The tool is available via Bioconda. It is recommended to use a dedicated environment due to specific dependency requirements (Python 3.6, TensorFlow 1.12).

```bash
conda create -n amplify python=3.6
conda activate amplify
conda install -c bioconda amplify
```

## Prediction (AMPlify)

The `AMPlify` command is used to predict the probability that a given sequence is an antimicrobial peptide.

### Model Selection
*   **Balanced Model (`-m balanced`)**: Default. Best for curated candidate sets where sequences have already been filtered by length, charge, or homology.
*   **Imbalanced Model (`-m imbalanced`)**: Best for large, uncurated databases (e.g., whole transcriptomes) where the number of non-AMPs significantly outweighs potential AMPs.

### Common CLI Patterns
*   **Basic Prediction**:
    `AMPlify -s input_sequences.fa`
*   **High-Throughput Mining (TSV output)**:
    `AMPlify -m imbalanced -s transcriptome.fa -of tsv -od ./results`
*   **Interpretability (Attention Scores)**:
    `AMPlify -s candidates.fa -att on`

### Interpreting Results
*   **Probability Score**: Raw model output (0 to 1).
*   **AMPlify Score**: A log-scaled score calculated as `-10 * log10(1 - Probability)`.
*   **Classification**: By default, sequences with an AMPlify score **> 3.01** (Probability > 0.5) are classified as AMPs.

## Training (train_amplify)

Use `train_amplify` to build custom models if you have specific positive and negative training sets.

### Basic Training Command
```bash
train_amplify -amp_tr positive_samples.fa -non_amp_tr negative_samples.fa -out_dir ./my_models -model_name custom_amp_model
```

### Training Parameters
*   `-sample_ratio`: Set to `balanced` (default) or `imbalanced` depending on your training data distribution.
*   `-amp_te` / `-non_amp_te`: Optional paths to test sets to evaluate performance immediately after training.

## Expert Tips

*   **Sequence Constraints**: AMPlify only accepts the 20 standard amino acids.
*   **Stop Codons**: If a sequence ends with an asterisk (`*`), AMPlify will automatically ignore the last character and process the rest of the peptide.
*   **Invalid Sequences**: Any sequences containing non-standard amino acids (other than the terminal stop codon) will result in `NA` values in the output.
*   **Resource Management**: For very large FASTA files, ensure you have sufficient memory for the TensorFlow backend, as the attention mechanism can be memory-intensive for long sequences.

## Reference documentation

- [AMPlify GitHub Repository](./references/github_com_bcgsc_AMPlify.md)
- [Bioconda AMPlify Package Overview](./references/anaconda_org_channels_bioconda_packages_amplify_overview.md)