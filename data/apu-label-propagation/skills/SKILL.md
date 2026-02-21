---
name: apu-label-propagation
description: The `apu-label-propagation` tool (part of the NIAPU framework) implements a specialized machine learning workflow for bioinformatics.
homepage: https://github.com/AndMastro/NIAPU
---

# apu-label-propagation

## Overview
The `apu-label-propagation` tool (part of the NIAPU framework) implements a specialized machine learning workflow for bioinformatics. It addresses the "Positive-Unlabelled" problem common in disease gene discovery, where researchers know some genes associated with a disease (positives) but cannot be certain which remaining genes are truly healthy (unlabelled). 

This skill guides the execution of the three-stage NIAPU pipeline:
1.  **NeDBIT Feature Computation**: Generating network-diffusion and biology-informed topological features from PPI networks.
2.  **Adaptive PU Labelling**: Propagating labels across the network to identify reliable negatives and rank candidates.
3.  **Classification**: Using the generated labels to train downstream machine learning models (MLP, RF, SVM).

## CLI Usage and Workflow

### 1. Pre-processing and Feature Calculation
The first stage converts raw Protein-Protein Interaction (PPI) data and seed gene lists into topological features.

**Step A: Pre-process PPI and Seed Data**
```bash
perl preprocess.pl <ppi_file> <seed_genes_scores> <out_links> <out_genes>
```
*   `<ppi_file>`: Space/tab-separated file with `gene1 gene2` links.
*   `<seed_genes_scores>`: File with `gene score` format.
*   `<out_links>`: Output file for ordinal PPI links.
*   `<out_genes>`: Output file for gene list (non-seeds are assigned score 0).

**Step B: Calculate NeDBIT Features**
After compiling `nedbit_features_calculator.c`:
```bash
./nedbit_features_calculator <out_links> <out_genes> <output_features_file>
```

### 2. Adaptive Label Propagation
This is the core component that identifies reliable negatives and ranks genes.

```bash
./apu_label_propagation <features_file> <header_presence> <output_ranking> <weak_link_threshold> <rn_threshold>
```
*   `<header_presence>`: `1` if the features file has a header, `0` otherwise.
*   `<output_ranking>`: Filename for the resulting gene scores and pseudo-labels.
*   `<weak_link_threshold>`: Float (e.g., `0.05`) indicating the quantile threshold for removing weak network links.
*   `<rn_threshold>`: Float (e.g., `0.2`) indicating the quantile threshold for Reliable Negative (RN) computation.

### 3. Machine Learning Classification
Once rankings and pseudo-labels are obtained, use them to train classifiers. The implementation typically looks for APU scores in a specific directory structure if using the provided `classification.py`.

```bash
python classification.py
```

## Expert Tips and Best Practices
*   **Input Formatting**: Ensure the PPI file contains unique links. The `preprocess.pl` script is sensitive to the `gene1 gene2` format; avoid using headers in the raw PPI or seed score files unless specifically handled.
*   **Threshold Tuning**: 
    *   The **Weak Link Threshold** (default `0.05`) controls network sparsity. Increasing this removes more noise but may lose biological signal.
    *   The **RN Threshold** (default `0.2`) determines how aggressively the tool labels unlabelled genes as "Reliable Negatives." A higher value increases the training set size for the classifier but may introduce false negatives.
*   **Efficiency**: The C implementation of the label propagation provides significant speedups over original R implementations. Always compile with optimization flags (e.g., `gcc -O3`) for large-scale PPI networks.
*   **Custom Features**: You can bypass the NeDBIT step and use your own feature matrix with `apu_label_propagation`, provided it follows the expected tabular format (rows as genes, columns as features).

## Reference documentation
- [NIAPU GitHub Repository](./references/github_com_AndMastro_NIAPU.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_apu-label-propagation_overview.md)