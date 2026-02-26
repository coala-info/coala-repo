---
name: banner
description: BANNER is a machine learning tool that classifies microbiome samples by interpreting HULK sketches using Random Forest models. Use when user asks to train a classifier on labeled sketches or predict labels for microbiome samples in real-time.
homepage: https://www.github.com/will-rowe/banner
---


# banner

## Overview
BANNER is a machine learning tool designed to interpret HULK (Histosketching Using Little K-mers) sketches. It bridges the gap between raw k-mer sketching and functional classification by training Random Forest models on labeled datasets. This allows for rapid, stream-based classification of microbiome samples as they are being processed by HULK.

## Installation
The tool can be installed via Bioconda or Pip:
```bash
conda install -c bioconda banner
# OR
pip install banner
```

## Core Workflows

### Training a Classifier
To train a model, you need a matrix of labeled HULK sketches (typically in CSV format).
```bash
banner train -m hulk-banner-matrix.csv -o banner.rfc
```
*   `-m`: Input matrix file containing labeled sketches.
*   `-o`: Output filename for the trained Random Forest Classifier (.rfc).

### Predicting Labels
Prediction is most efficient when piped directly from HULK's sketching output.
```bash
hulk sketch -f mystery-sample.fastq --stream -p 8 | banner predict -m banner.rfc
```
*   `--stream`: Essential for passing data directly to BANNER.
*   `-m`: The trained model file generated during the training step.

## Best Practices and Limitations
*   **Binary Classification**: Currently, BANNER is optimized for and primarily supports 2-label classification (e.g., Treated vs. Untreated, Case vs. Control).
*   **Streaming Data**: Use the `--stream` flag in HULK to perform real-time classification, which avoids the need for intermediate large file storage.
*   **Model Consistency**: Ensure that the k-mer size and parameters used during the creation of the training matrix match the parameters used when sketching the "mystery" samples for prediction.

## Reference documentation
- [BANNER GitHub Repository](./references/github_com_will-rowe_banner.md)
- [Bioconda Banner Overview](./references/anaconda_org_channels_bioconda_packages_banner_overview.md)