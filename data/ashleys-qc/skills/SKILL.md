---
name: ashleys-qc
description: ASHLEYS-QC is a machine learning framework that automates the identification of high-quality libraries in Strand-seq experiments. Use when user asks to generate genomic features from BAM files, predict library quality using pretrained models, train custom classifiers, or visualize prediction probability distributions.
homepage: https://github.com/friendsofstrandseq/ashleys-qc
---


# ashleys-qc

## Overview

ASHLEYS (Automated Selection of High quality Libraries for the Extensive analYsis of Strandseq data) is a machine learning framework designed to automate the identification of high-quality libraries in Strand-seq experiments. It replaces the labor-intensive process of manual library selection by analyzing read distributions across various genomic window sizes. The tool operates in three primary phases: feature generation from aligned BAM files, classification using a Support Vector Classifier (SVC), and visualization of results.

## Core Workflows and CLI Patterns

### 1. Feature Generation
Before classification, you must compute genomic features. This module requires aligned, duplicate-marked BAM files.

```bash
# Generate features using multiple window sizes (standard recommendation)
ashleys.py features \
    -j 23 \
    -f /path/to/bam_folder/ \
    -w 5000000 2000000 1000000 800000 600000 400000 200000 \
    -o feature_table.tsv
```
*   **-j**: Number of threads for parallel processing.
*   **-w**: Window sizes in base pairs. Using the standard set of seven windows (5Mb down to 200kb) is recommended for compatibility with pretrained models.

### 2. Quality Prediction
Use a pretrained or custom model to classify cells.

```bash
# Predict using the default pretrained model
ashleys.py predict \
    -p feature_table.tsv \
    -m models/svc_default.pkl \
    -o output_directory/
```
*   **Pretrained Model Warning**: If using the provided `svc_default.pkl`, you **must** use `scikit-learn v0.23.2`. Newer versions may fail to load the pickle file or produce inconsistent results.
*   **Output**: Generates `prediction.tsv` containing class probabilities for each cell.

### 3. Model Training
If the default model does not perform well on your specific sequencing setup, train a custom classifier.

```bash
ashleys.py train \
    -p feature_table.tsv \
    -a annotation.txt \
    -o custom_model.pkl
```
*   **-a**: A text file specifying ground-truth annotations (Class 1 for high-quality cells).

### 4. Visualization
Visualize the distribution of prediction probabilities to determine if your classification threshold is appropriate.

```bash
ashleys.py plot \
    -p output_directory/prediction.tsv \
    -o quality_distribution_plot.pdf
```

## Expert Tips and Best Practices

*   **Input Preparation**: ASHLEYS does not perform alignment. Ensure your BAM files are sorted, indexed, and have duplicates marked (e.g., via Picard or Sambamba) before running the `features` module.
*   **Environment Management**: Because of the strict `scikit-learn` version requirement for pretrained models, it is best to run ASHLEYS within its dedicated Conda environment:
    ```bash
    conda activate ashleys
    ```
*   **Window Size Consistency**: If you intend to use the pretrained models, do not deviate from the standard window sizes used during the original model training (5M, 2M, 1M, 800k, 600k, 400k, 200k).
*   **Interpreting Probabilities**: The prediction output provides a probability score. While 0.5 is the default threshold, you may want to inspect the `plot` output to see if a more stringent (e.g., 0.7) or relaxed threshold is better suited for your downstream analysis.

## Reference documentation
- [ASHLEYS-QC GitHub Repository](./references/github_com_friendsofstrandseq_ashleys-qc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ashleys-qc_overview.md)