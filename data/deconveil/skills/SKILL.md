---
name: deconveil
description: DeConveil performs copy-number-aware differential expression analysis by adjusting gene expression for gene dosage effects. Use when user asks to perform differential expression testing in cancer research, adjust for gene dosage, or categorize genes into dosage-sensitive, dosage-insensitive, and dosage-compensated groups.
homepage: https://github.com/caravagnalab/DeConveil
metadata:
  docker_image: "quay.io/biocontainers/deconveil:0.2.0--pyhdfd78af_0"
---

# deconveil

## Overview
DeConveil is a specialized extension of the PyDESeq2/DESeq2 framework designed for "CN-aware" differential expression testing. In cancer research, gene expression is often confounded by large-scale genomic alterations; DeConveil addresses this by adjusting for gene dosage. It categorizes genes into three distinct groups: Dosage-Sensitive (DSG), Dosage-Insensitive (DIG), and Dosage-Compensated (DCG). This allows for a more nuanced understanding of which expression changes are truly regulatory rather than simply a byproduct of increased or decreased gene copies.

## Installation and Environment Setup
DeConveil requires both Python and R environments to function correctly, specifically for stage-wise multiple testing.

*   **Core Installation**: `pip install deconveil` or `conda install -c bioconda deconveil`.
*   **R Dependency**: You must have R installed with the `stageR` package from Bioconductor:
    ```R
    if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
    BiocManager::install("stageR")
    ```
*   **Optional Bayesian Inference**: For the Stan-based Negative Binomial regression model, install with the stan extra:
    ```bash
    pip install "deconveil[stan]"
    python -m cmdstanpy.install_cmdstan
    ```

## Data Preparation
DeConveil expects three primary inputs structured as matrices:
1.  **mRNA Read Counts**: An $N \times G$ matrix (Samples $\times$ Genes) containing matched read counts for normal and tumor samples.
2.  **Absolute Copy Number (CN) Values**: An $N \times G$ matrix of absolute CN values. 
    *   **Expert Tip**: For normal diploid samples where CN data might be missing, manually assign a value of `2`.
3.  **Design Matrix**: An $N \times F$ matrix (Samples $\times$ Features/Covariates) defining the experimental groups and other variables.

## Core Workflow Patterns
The standard analysis requires running both a "CN-naive" and a "CN-aware" model to perform gene separation.

1.  **CN-Naive Analysis**: Run standard PyDESeq2 to establish a baseline of differential expression without considering copy number.
2.  **CN-Aware Analysis**: Run the DeConveil framework, which incorporates the CN matrix into the generalized linear model.
3.  **Gene Classification**: Use the `define_gene_groups()` function on the resulting data frames (`res_CNnaive.csv` and `res_CNaware.csv`) to categorize genes.

## Inference Methods
*   **Default Framework**: Best for standard DGE workflows where you want to compare tumor vs. normal while accounting for aneuploidy.
*   **NB Regression (Stan-based)**: Use this for tumor-only samples when you require Bayesian inference and explicit uncertainty quantification of dosage sensitivity. This is particularly useful for focused studies on dosage compensation mechanisms within a specific cohort.

## Best Practices
*   **Matched Samples**: Ensure that the row indices of your count matrix and CN matrix match exactly.
*   **Stage-wise Testing**: Always ensure `stageR` is available in your R path, as DeConveil uses `rpy2` to call this package for FDR control across the two testing stages (naive vs. aware).
*   **Multifactor Designs**: DeConveil supports complex design matrices; ensure your reference levels are set correctly in the design matrix before fitting the models.

## Reference documentation
- [github_com_caravagnalab_DeConveil.md](./references/github_com_caravagnalab_DeConveil.md)
- [anaconda_org_channels_bioconda_packages_deconveil_overview.md](./references/anaconda_org_channels_bioconda_packages_deconveil_overview.md)