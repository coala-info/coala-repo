---
name: msisensor-rna
description: MSIsensor-RNA quantifies Microsatellite Instability by analyzing the expression of mismatch repair genes in bulk or single-cell RNA-seq data. Use when user asks to identify informative genes for MSI detection, train machine learning models for MSI classification, or predict MSI status from transcriptomic expression values.
homepage: https://github.com/xjtu-omics/msisensor-rna
---


# msisensor-rna

## Overview
MSIsensor-RNA is a specialized tool within the MSIsensor family designed to quantify Microsatellite Instability (MSI) by analyzing the expression of genes associated with the mismatch repair (MMR) system. Unlike DNA-based methods that look for genomic mutations, this tool focuses on the transcriptomic causes of MSI. It is particularly useful for bulk RNA-seq and single-cell RNA-seq (scRNA-seq) workflows where DNA sequencing may not be available or where a more cost-effective MSI scoring method is required.

## Installation and Setup
The tool can be installed via Conda or Pip:

```bash
# Via Conda
conda install -c bioconda msisensor-rna

# Via Pip
pip install msisensor-rna
```

## Data Preparation
MSIsensor-RNA requires a specific CSV input format.
- **Format**: Comma-separated values (.csv).
- **Columns**: 
  1. `SampleID`: Unique identifier for the sample.
  2. `msi`: MSI status (e.g., `MSI-H` or `MSS`). This is required for training but can be placeholder data for detection.
  3. `Gene Columns`: Normalized expression values (e.g., `MLH1`, `MSH2`, etc.).
- **Normalization**: It is highly recommended to use normalized values, such as **z-score normalization of log2(FPKM+1)**.

## Core Workflows

### 1. Feature Selection (`genes`)
Identify the most informative genes for MSI detection from a training dataset.

```bash
msisensor-rna genes -i training_data.csv -o informative_genes.csv --threads 4 --thresh_auc 0.65
```
- **Key Tip**: Adjust `--thresh_auc` (default 0.65) and `--thresh_p` (default 0.01) to control the stringency of gene selection.

### 2. Model Training (`train`)
Build a custom machine learning model for a specific cancer type or sequencing platform.

```bash
msisensor-rna train -i training_data.csv -m my_model.model -t CRC -c RandomForest
```
- **Classifiers**: Supports `SVM`, `RandomForest` (default), `LogisticRegression`, `MLPClassifier`, `GaussianNB`, and `AdaBoostClassifier`.
- **Requirement**: Ensure at least 10 positive MSI samples are present (adjustable via `-p`).

### 3. MSI Detection (`detection`)
Run the MSI classification on new samples using a trained model.

```bash
msisensor-rna detection -i test_data.csv -m my_model.model -o output_prefix
```
- **Output**: Generates results indicating the MSI score and predicted status for each sample in the input file.

### 4. Model Inspection (`show`)
View metadata or update descriptions for an existing model file.

```bash
msisensor-rna show -m my_model.model --model_description "Model trained on TCGA-STAD log2 FPKM data"
```

## Best Practices
- **Consistency**: Always use the same normalization method for the detection input data as was used for the training data.
- **Cancer Specificity**: While Pan-Cancer models are possible, training cancer-type-specific models (e.g., CRC, STAD) often yields higher sensitivity and specificity.
- **Single-Cell Usage**: For scRNA-seq, ensure data is properly aggregated or normalized to account for sparsity before running detection.

## Reference documentation
- [MSIsensor-RNA GitHub Repository](./references/github_com_xjtu-omics_msisensor-rna.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_msisensor-rna_overview.md)