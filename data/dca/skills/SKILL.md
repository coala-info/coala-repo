---
name: dca
description: DCA denoises and imputes scRNA-seq data by modeling the statistical properties of single-cell count matrices. Use when user asks to denoise single-cell counts, impute missing values, or generate a reduced-dimensional representation of scRNA-seq data.
homepage: https://github.com/theislab/dca
---


# dca

## Overview

The Deep Count Autoencoder (DCA) is a specialized tool for the denoising and imputation of scRNA-seq data. Unlike general-purpose autoencoders, DCA is designed to handle the specific statistical properties of single-cell counts—namely sparsity, overdispersion, and zero-inflation. It transforms raw, noisy count matrices into denoised versions by modeling the underlying data distribution, providing both reconstructed counts and a reduced-dimensional representation of the cells.

## CLI Usage and Patterns

### Basic Denoising
The primary command requires an input count matrix and a destination folder for results.
```bash
dca matrix.csv results/
```
*   **Input Format**: CSV or TSV file.
*   **Structure**: Genes must be in rows and cells in columns.
*   **Labels**: Row and column labels are mandatory.

### Hyperparameter Optimization
To automatically search for the best model configuration (e.g., layer sizes, dropout rates):
```bash
dca matrix.csv results/ --hyper
```

### Advanced Options
*   **Skip Count Validation**: If you are certain your input consists of raw integers and want to speed up the initial check:
    ```bash
    dca matrix.csv results/ --checkcounts False
    ```
*   **Help and Parameters**: To view all available tuning parameters (learning rate, batch size, etc.):
    ```bash
    dca -h
    ```

## Output Files

DCA generates several files in the specified output directory:

| File | Description |
| :--- | :--- |
| `mean.tsv` | The primary denoised output (ZINB mean parameter). |
| `mean_norm.tsv` | Library size-normalized denoised expressions. |
| `reduced.tsv` | 32-dimensional latent representation (bottleneck layer) for clustering or visualization. |
| `pi.tsv` | Estimated dropout probabilities for each gene/cell. |
| `dispersion.tsv` | Estimated dispersion parameters. |

## Best Practices

*   **Input Data**: Always provide raw, non-normalized integer counts. DCA's ZINB model is specifically built for the nature of raw count data; providing log-transformed or scaled data will lead to incorrect results.
*   **Normalization**: Use `mean_norm.tsv` for downstream analysis like differential expression or trajectory inference, as it accounts for differences in sequencing depth across cells.
*   **Dimensionality Reduction**: The `reduced.tsv` file is an excellent alternative to PCA for downstream clustering, as it captures non-linear relationships identified during the denoising process.
*   **Filtering**: While DCA handles noise well, it is still recommended to perform basic quality control (removing low-quality cells or completely empty genes) before running the tool to improve training efficiency.

## Reference documentation
- [DCA GitHub Repository](./references/github_com_theislab_dca.md)
- [Bioconda DCA Overview](./references/anaconda_org_channels_bioconda_packages_dca_overview.md)