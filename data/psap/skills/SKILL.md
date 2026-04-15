---
name: psap
description: PSAP is a machine learning tool that predicts the likelihood of proteins undergoing liquid-liquid phase separation based on sequence-derived biochemical features. Use when user asks to predict phase separation scores, train custom classifiers for specific proteomes, or extract biochemical features from protein sequences.
homepage: https://github.com/vanheeringen-lab/psap
metadata:
  docker_image: "quay.io/biocontainers/psap:1.0.7--pyhdfd78af_0"
---

# psap

## Overview

PSAP (Protein Separation Analysis/Prediction) is a machine learning tool designed to identify proteins likely to undergo liquid-liquid phase separation. It utilizes a RandomForest classifier trained on biochemical features extracted from protein sequences. The tool provides a complete workflow for sequence annotation, model training, and class probability prediction (PSAP_score). While it includes a default model trained on the human reference proteome, it is flexible enough to support custom training sets for specialized research.

## CLI Usage and Best Practices

### 1. Predicting Phase Separation Scores
The most common use case is predicting the probability of phase separation for a set of sequences.

```bash
# Use the default human-trained model
psap predict -f sequences.fasta -o ./results

# Use a custom trained model
psap predict -f sequences.fasta -m custom_model.json -o ./results
```

*   **Expert Tip**: If no model is provided with `-m`, PSAP automatically loads the default classifier trained on the human proteome.
*   **Input**: Ensure your input is a standard peptide FASTA file.

### 2. Training Custom Classifiers
If working with non-human proteomes or specific protein families, training a new model is recommended.

```bash
psap train -f training_set.fasta -l known_pps_list.txt -o ./models
```

*   **Training Set**: The `-f` flag should point to a FASTA file containing your training sequences.
*   **Positive Labels**: The `-l` flag (optional but recommended) points to a text file containing IDs of known PPS proteins to guide the positive class labeling.
*   **Output**: The resulting model is exported as a `.json` file, making it highly portable.

### 3. Sequence Annotation
You can extract biochemical features without running a full prediction or training cycle. This is useful for exploratory data analysis of protein properties.

```bash
psap annotate -f sequences.fasta -o ./annotations
```

*   **Note**: Annotation is a prerequisite for both training and prediction; however, the `train` and `predict` commands run this step automatically. Use `annotate` only if you need the raw feature table.

## Workflow Patterns

| Task | Command | Key Arguments |
| :--- | :--- | :--- |
| **Screening** | `psap predict` | `-f` (Target sequences) |
| **Model Building** | `psap train` | `-f` (Training sequences), `-l` (Known positives) |
| **Feature Extraction** | `psap annotate` | `-f` (Sequences) |



## Subcommands

| Command | Description |
|---------|-------------|
| psap annotate | Annotate peptide fasta files with LLPS labels and store as a data frame |
| psap predict | Predict protein phase separation potential using the PSAP classifier. |
| psap train | Train a RandomForest classifier for PSAP (Phase Separation Associated Proteins) |

## Reference documentation
- [psap GitHub Repository](./references/github_com_vanheeringen-lab_psap_blob_master_README.rst.md)
- [psap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_psap_overview.md)