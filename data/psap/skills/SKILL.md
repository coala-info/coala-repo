---
name: psap
description: PSAP uses a RandomForest machine learning approach to predict the likelihood of protein liquid-liquid phase separation based on amino acid sequences. Use when user asks to predict phase separation scores, train custom protein classifiers, or annotate sequences with biochemical features.
homepage: https://github.com/vanheeringen-lab/psap
---


# psap

## Overview
PSAP (Protein Phase Separation classifier) is a bioinformatics tool that implements a RandomForest machine learning approach to estimate the likelihood of a protein undergoing liquid-liquid phase separation. It works by converting amino acid sequences into a set of biochemical features which are then evaluated against a trained model. While it comes with a default model trained on the human proteome, it provides the flexibility to train new models on custom datasets or simply annotate sequences with the underlying biochemical properties used for classification.

## Installation
The tool can be installed via pip or conda:
```bash
pip install psap
# OR
conda install bioconda::psap
```

## Command Line Usage

### 1. Predicting Phase Separation Scores
This is the primary use case for evaluating new protein sequences.
```bash
psap predict -f /path/to/sequences.fasta -o /path/to/output/
```
*   **Default Model**: If no model is specified with `-m`, psap uses the default human-trained model.
*   **Custom Model**: Use `-m /path/to/model.json` to use a classifier you have trained yourself.
*   **Output**: Generates a file containing the PSAP_score (class probability) for each sequence.

### 2. Training a Custom Classifier
Use this if you are working with a non-human proteome or have a specific set of known phase-separating proteins for training.
```bash
psap train -f /path/to/training_set.fasta -l /path/to/labels.txt -o /path/to/model_dir/
```
*   **Labels**: The `-l` flag points to a text file containing known PPS proteins for positive class labeling.
*   **Export**: The trained RandomForest classifier is exported in JSON format for use in the `predict` command.

### 3. Annotating Sequences
If you only need the biochemical feature vectors without the final probability score, use the annotate command.
```bash
psap annotate -f /path/to/sequences.fasta -o /path/to/output/
```
*   Note: This step is automatically performed during `train` and `predict` workflows, so it is only necessary for manual feature analysis.

## Best Practices and Tips
*   **Input Format**: Ensure your protein sequences are in standard FASTA format.
*   **Default Model Context**: Remember that the default model was trained on the human reference proteome. When applying it to highly divergent species, consider training a species-specific model using `psap train`.
*   **Feature Extraction**: PSAP calculates features based on amino acid composition and biochemical properties; ensure your sequences do not contain non-standard amino acid codes that might interfere with feature calculation.
*   **Resource Location**: Default models and test sets are typically located within the package data directory (e.g., `psap/data/`).

## Reference documentation
- [PSAP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_psap_overview.md)
- [PSAP GitHub Repository](./references/github_com_vanheeringen-lab_psap.md)