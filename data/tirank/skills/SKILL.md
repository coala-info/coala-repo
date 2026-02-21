---
name: tirank
description: TiRank is a computational framework that leverages deep learning and statistical modeling to bridge the gap between bulk transcriptomic datasets and single-cell or spatial resolutions.
homepage: https://github.com/LenisLin/TiRank
---

# tirank

## Overview
TiRank is a computational framework that leverages deep learning and statistical modeling to bridge the gap between bulk transcriptomic datasets and single-cell or spatial resolutions. By training on bulk data with associated clinical metadata, TiRank identifies gene-pair signatures that can be projected onto scRNA-seq or ST data. This allows researchers to rank cell populations or tissue spots based on their association with specific clinical outcomes like Cox survival risk, binary classification (e.g., responder vs. non-responder), or continuous regression variables.

## Installation and Environment
TiRank requires a CUDA-compatible GPU for its deep learning modules (PyTorch >= 2.1).

```bash
# Recommended installation via Bioconda
conda create -n tirank python=3.9
conda activate tirank
conda install -c bioconda -c conda-forge tirank leidenalg python-igraph
```

## Core Workflows

### 1. Standardized Snakemake Pipeline
For reproducible analysis on new datasets, use the built-in Snakemake workflow. This is the preferred method for automated processing.

```bash
cd workflow
# Run the workflow using conda for dependency management
snakemake --use-conda --conda-frontend conda -c <number_of_cores>
```

### 2. Standalone Python Scripts
For quick testing or custom modifications, TiRank provides example scripts for common use cases. You must edit the `dataPath` and `savePath` variables within these scripts before execution.

*   **scRNA-seq to Bulk (Classification):** Used for tasks like predicting immunotherapy response.
    ```bash
    python Example/SC-Response-SKCM.py
    ```
*   **Spatial Transcriptomics to Bulk (Survival):** Used for identifying spatial niches linked to prognosis.
    ```bash
    python Example/ST-Cox-CRC.py
    ```

## Data Requirements and Preparation
*   **Bulk Data:** Requires an expression matrix and clinical metadata aligned by sample IDs.
*   **Single-Cell/Spatial Data:** Supports `.h5ad` files or standard spatial transcriptomics folders (e.g., 10x Visium output).
*   **Pretrained Models:** Spatial Transcriptomics analysis requires the `ctranspath.pth` model.
    *   Place in: `data/pretrainModel/ctranspath.pth`
*   **Directory Structure:** TiRank expects a specific layout for example data:
    *   `data/ExampleData/<Dataset_Name>/`
    *   `data/pretrainModel/`

## Interpreting Results
The primary output is located in `<savePath>/3_Analysis/spot_predict_score.csv`.

*   **Rank_Label Interpretation:**
    *   **Cox Survival:** Positive scores (TiRank+) indicate worse survival; negative scores (TiRank-) indicate better survival.
    *   **Classification:** TiRank+ corresponds to Phenotype 1; TiRank- corresponds to Phenotype 0.
    *   **Regression:** TiRank+ indicates a higher phenotype score; TiRank- indicates a lower score.
*   **Visualizations:** The tool automatically generates UMAPs of prediction scores and distribution plots in the `3_Analysis/` directory.

## Expert Tips
*   **GPU Memory:** For large spatial datasets, ensure the system has at least 16GB of RAM and a high-memory GPU (e.g., RTX 3090/4090) to avoid OOM errors during the deep learning phase.
*   **Gene Pairs:** TiRank relies on gene-pair signatures to overcome batch effects between bulk and single-cell platforms. Ensure your input matrices have sufficient gene overlap.
*   **Dry Run:** Always perform a Snakemake dry run (`snakemake -n`) to verify your configuration and file paths before starting a GPU-intensive training session.

## Reference documentation
- [TiRank GitHub Repository](./references/github_com_LenisLin_TiRank.md)
- [TiRank Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tirank_overview.md)