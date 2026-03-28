---
name: tirank
description: TiRank integrates single-cell or spatial transcriptomics with bulk RNA-seq clinical cohorts to identify cell clusters or spatial regions associated with patient outcomes. Use when user asks to characterize tissue heterogeneity, map transcriptomic findings to clinical phenotypes, or prioritize biological niches for survival and treatment response validation.
homepage: https://github.com/LenisLin/TiRank
---


# tirank

## Overview
TiRank is a specialized bioinformatics framework designed to bridge the gap between high-resolution transcriptomics (single-cell or spatial) and large-scale clinical cohorts (bulk RNA-seq). It allows researchers to characterize tissue heterogeneity and map those findings onto clinical outcomes like patient survival or treatment response. By identifying specific cell clusters or spatial regions associated with a phenotype, TiRank helps prioritize the most relevant biological niches for further clinical validation.

## Installation and Setup
TiRank requires a CUDA-compatible GPU and Python 3.9.

1. **Environment Setup**:
   ```bash
   conda create -n tirank python=3.9
   conda activate tirank
   conda install -c bioconda -c conda-forge tirank leidenalg python-igraph
   ```

2. **Resource Requirements**:
   - **GPU**: CUDA-compatible (e.g., RTX 2080Ti or newer).
   - **Pretrained Model**: Spatial Transcriptomics analysis requires `ctranspath.pth` placed in `data/pretrainModel/`.
   - **Memory**: Minimum 16 GB RAM.

## Core Workflows

### 1. Single-Cell to Bulk Integration (Classification)
Used to identify cell clusters associated with specific binary phenotypes (e.g., responders vs. non-responders).
- **Input**: `.h5ad` single-cell data, bulk expression matrix, and clinical metadata.
- **Pattern**:
  ```python
  # Example logic used in Example/SC-Response-SKCM.py
  # 1. Load scRNA-seq data (GSE120575.h5ad)
  # 2. Load Bulk expression and metadata (Liu2019_exp.csv, Liu2019_meta.csv)
  # 3. Run TiRank classification mode
  ```

### 2. Spatial Transcriptomics to Bulk Integration (Survival)
Used to identify spatial regions associated with continuous clinical outcomes like Overall Survival (OS).
- **Input**: Spatial transcriptomics folder (e.g., Visium), bulk expression matrix, and clinical metadata with survival time/status.
- **Pattern**:
  ```python
  # Example logic used in Example/ST-Cox-CRC.py
  # 1. Load ST data (Spatial folder)
  # 2. Load Bulk survival data (GSE39582_clinical_os.csv)
  # 3. Run TiRank Cox mode
  ```

### 3. Snakemake Workflow
For reproducible and automated pipelines on new datasets:
```bash
cd workflow
snakemake --use-conda --conda-frontend conda -c <cores>
```

## Expert Tips
- **Data Alignment**: Ensure that the Sample IDs in your bulk expression matrix exactly match the IDs in your clinical metadata file.
- **Path Configuration**: When using the provided example scripts, always verify the `dataPath` and `savePath` variables at the beginning of the script to ensure they point to your local directory structure.
- **GPU Acceleration**: If running on a headless server, ensure `CUDA_VISIBLE_DEVICES` is correctly set, as TiRank relies heavily on GPU for the integration steps.
- **Output Inspection**: TiRank automatically generates UMAPs and spatial maps. Check the `results/` subfolder created under your `savePath` for these visualizations to verify the biological relevance of the identified niches.



## Subcommands

| Command | Description |
|---------|-------------|
| python | Run a program in Python |
| snakemake | Snakemake is a Python based language and execution environment for GNU Make-like workflows. |

## Reference documentation
- [TiRank Main Repository](./references/github_com_LenisLin_TiRank.md)
- [TiRank README and Usage](./references/github_com_LenisLin_TiRank_blob_main_README.md)