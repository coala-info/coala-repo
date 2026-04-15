---
name: gdmicro
description: GDmicro is a machine learning framework that classifies host disease status and identifies microbial biomarkers using graph convolutional networks and domain adaptation. Use when user asks to classify disease status from microbial abundance data, perform cross-study analysis, or identify top species contributing to a disease state.
homepage: https://github.com/liaoherui/GDmicro
metadata:
  docker_image: "quay.io/biocontainers/gdmicro:1.0.10--pyhdfd78af_0"
---

# gdmicro

## Overview

GDmicro is a machine learning framework designed to classify host disease status based on microbial compositional abundance data. It is particularly effective for cross-study analysis because it utilizes Deep Adaptation Networks to minimize domain discrepancies between training and test datasets. By constructing an inter-host similarity graph and applying GCNs, it provides robust binary classification (Healthy vs. Disease) and helps researchers identify species that contribute most significantly to disease states.

## Input Data Preparation

To use GDmicro, you must provide a microbial species abundance matrix in CSV format. The tool expects a specific column structure:

1.  **subject_id**: Unique identifier for the sample.
2.  **class**: Must be labeled as either `train` or `test`.
3.  **disease**: The label for the sample. Use `healthy` for controls and the specific disease name (e.g., `CRC`, `IBD`) for cases.
4.  **study**: The study name or country of origin.
5.  **Species Columns**: All remaining columns should contain the abundance values for individual species.

*Note: If "disease" or "study" information is missing for specific samples, replace the values with "Unknown".*

## Common CLI Patterns

If installed via Bioconda, use the `gdmicro` command. If running from source, use `python GDmicro.py`.

### Disease Classification
To classify the disease status of test samples based on a trained model:
```bash
gdmicro -i input_data.csv -d <disease_name> -o output_directory
```
Replace `<disease_name>` with the exact string used in your "disease" column (e.g., `-d CRC`).

### K-Fold Cross-Validation
To evaluate model performance on your training data:
```bash
gdmicro -i input_data.csv -d <disease_name> -t 1 -o output_directory
```

### Biomarker Identification
To calculate node importance and identify potential biomarkers (top contributing species):
```bash
gdmicro -i input_data.csv -d <disease_name> -e 1 -n 20 -o output_directory
```
*   `-e 1`: Enables node importance calculation (increases runtime).
*   `-n 20`: Specifies the number of top biomarkers to output.

## Parameter Tuning and Best Practices

*   **Graph Connectivity**: Use `-k <int>` (default: 5) to adjust the number of neighbors in the k-NN graph. This affects how sample relationships are modeled in the GCN.
*   **Batch Size**: For large datasets, adjust `-b <int>` (default: 64) to optimize memory usage and training stability.
*   **Reproducibility**: When performing Leave-One-Study-Out (LOSO) experiments or comparative benchmarks, set a random seed using `-s 10` to ensure consistent results.
*   **Feature Selection**: Use `-f <int>` to limit the analysis to the top X features if the species matrix is excessively sparse or high-dimensional.

## Reference documentation
- [GDmicro - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_gdmicro_overview.md)
- [GitHub - liaoherui/GDmicro](./references/github_com_liaoherui_GDmicro.md)