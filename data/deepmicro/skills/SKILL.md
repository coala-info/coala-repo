---
name: deepmicro
description: DeepMicro is a deep learning framework designed for microbiome-based disease prediction and dimensionality reduction of metagenomic data. Use when user asks to extract low-dimensional features from microbial abundance tables, perform representation learning using autoencoders, or build predictive models to classify disease states.
homepage: https://github.com/paulzierep/DeepMicro
---


# deepmicro

## Overview
DeepMicro is a specialized framework for microbiome-based disease prediction. It addresses the "curse of dimensionality" common in metagenomic data by using deep learning to extract robust, low-dimensional features. Use this skill when you need to transform raw microbial abundance tables into compressed representations or when you need to build predictive models to distinguish between healthy and diseased states based on microbiome profiles.

## Core CLI Patterns

### 1. Data Validation and Shape Check
Before running complex models, verify that your data loads correctly. DeepMicro expects CSV files without headers or indices.
```bash
python DM.py -r 1 --no_clf -cd your_data.csv
```
*   **Note**: Check the output for `X_train.shape` to ensure the sample and feature counts match your expectations.

### 2. Representation Learning (Dimensionality Reduction)
To reduce dimensions without running a classifier, use the `--no_clf` flag. This is useful for feature extraction.

*   **Shallow Autoencoder (20 dimensions)**:
    ```bash
    python DM.py -r 1 --no_clf -cd data.csv --ae -dm 20 --save_rep
    ```
*   **Deep Autoencoder (Multiple layers)**:
    ```bash
    python DM.py -r 1 --no_clf -cd data.csv --ae -dm 100,40,20 --save_rep
    ```
*   **Variational Autoencoder (VAE)**:
    ```bash
    python DM.py -r 1 --no_clf -cd data.csv --vae -dm 100,20 --save_rep
    ```

### 3. End-to-End Classification
To perform both representation learning and disease prediction, provide a label file (binary 0/1 values).

*   **Direct SVM (No representation learning)**:
    ```bash
    python DM.py -r 1 -cd data.csv -cl labels.csv -m svm
    ```
*   **AE + SVM Pipeline**:
    ```bash
    python DM.py -r 1 -cd data.csv -cl labels.csv --ae -dm 20 -m svm
    ```

### 4. Working with Precomputed Representations
If you have already generated a representation (e.g., via PCA or a previous AE run), you can load it directly to save time during classification.
```bash
python DM.py -r 1 -cd data.csv -cl labels.csv --load_rep results/your_rep.csv -m svm
```

## Expert Tips & Best Practices

*   **Architecture Preview**: Use the `--no_trn` flag with your `-dm` (dimensions) argument to inspect the model structure without starting the training process. This is helpful for debugging complex deep architectures.
*   **GPU Acceleration**: For large datasets or deep Convolutional Autoencoders (CAE), ensure `tensorflow-gpu` is installed. DeepMicro will automatically utilize the GPU if available.
*   **Reproducibility**: Use the `-r` argument to specify the number of repeats. DeepMicro changes seeds for random partitioning in each repeat, allowing you to assess the stability of your model's performance.
*   **Output Management**: Results are stored in the `/results` directory. The result text files append new experiments, so keep track of your filenames to avoid confusion between different runs.
*   **Data Formatting**: Ensure your CSV files are strictly numeric. Any non-numeric headers or sample IDs in the CSV will cause loading errors.

## Reference documentation
- [DeepMicro GitHub Repository](./references/github_com_paulzierep_DeepMicro.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_deepmicro_overview.md)