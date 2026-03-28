---
name: msisensor-rna
description: MSIsensor-RNA detects microsatellite instability status by analyzing gene expression levels from bulk or single-cell transcriptomic data. Use when user asks to identify informative genes for MSI detection, train custom MSI models, or perform MSI scoring on RNA-seq samples.
homepage: https://github.com/xjtu-omics/msisensor-rna
---

# msisensor-rna

## Overview

MSIsensor-RNA is a computational tool designed to detect Microsatellite Instability (MSI) using transcriptomic data. Unlike traditional DNA-based methods that look for genomic mutations, this tool quantifies MSI by analyzing the expression levels of genes associated with the mismatch repair (MMR) system. It is highly effective for both bulk RNA-seq and single-cell RNA-seq (scRNA-seq) workflows, offering a cost-effective alternative for MSI biomarker discovery in immunotherapy research.

## Installation and Setup

The tool can be installed via pip or run through Docker for environment consistency.

```bash
# Install from source
git clone https://github.com/xjtu-omics/msisensor-rna.git
cd msisensor-rna
pip3 install .

# Using Docker
docker pull pengjia1110/msisensor-rna:latest
```

## Command Line Interface

The tool follows a standard sub-command structure: `msisensor-rna <command> [options]`.

### 1. Gene Selection (`genes`)
Identify the most informative genes for MSI detection from your expression matrix.

```bash
msisensor-rna genes -i input_expression.csv -o informative_genes.txt
```
*   **Input**: A CSV/TSV file where rows are genes and columns are samples (or vice versa, depending on orientation).
*   **Tip**: Ensure your gene identifiers (symbols or Ensembl IDs) match the requirements of the downstream model.

### 2. Model Training (`train`)
Train a custom MSI detection model if the default models are not suitable for your specific cancer type or sequencing platform.

```bash
msisensor-rna train -i training_data.csv -m metadata.csv -o custom_model.pkl
```
*   **Metadata**: Should contain the ground truth MSI status (e.g., MSI-H vs MSS) for the training samples.

### 3. MSI Detection (`msi` or `detection`)
Perform the actual MSI scoring on query samples.

```bash
msisensor-rna msi -i query_expression.csv -m model/default_model.pkl -o results.csv
```

## Best Practices and Expert Tips

*   **Data Normalization**: While MSIsensor-RNA handles various expression formats, ensure your data is consistently normalized (e.g., TPM, FPKM, or Log-transformed counts) across training and detection phases. Recent updates include internal normalization modules to improve robustness.
*   **Single-Cell Analysis**: When using scRNA-seq data, it is often beneficial to aggregate cells or use pseudo-bulk profiles if the per-cell signal is too sparse, though the tool is optimized to handle the distribution of single-cell expression.
*   **Model Selection**: Use the provided pre-trained models in the `model/` directory for standard pan-cancer analysis. Only retrain if working with a highly unique tissue type or non-human data.
*   **Input Format**: The tool typically expects CSV/TSV formats. Ensure that the gene names in your input file match the feature names the model was trained on (usually HGNC Gene Symbols).



## Subcommands

| Command | Description |
|---------|-------------|
| msisensor-rna detection | Microsatellite instability detection. |
| msisensor-rna genes | Select informative genes for microsatellite instability detection. |
| msisensor-rna show | Show the information of the model and add more details. |
| msisensor-rna train | Train custom model for microsatellite instability detection. |

## Reference documentation
- [MSIsensor-RNA GitHub Repository](./references/github_com_xjtu-omics_msisensor-rna_blob_main_README.md)
- [Dockerfile and Environment Setup](./references/github_com_xjtu-omics_msisensor-rna_blob_main_Dockerfile.md)
- [Project Metadata and Dependencies](./references/github_com_xjtu-omics_msisensor-rna_blob_main_setup.py.md)