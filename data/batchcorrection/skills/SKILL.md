---
name: batchcorrection
description: The batchcorrection tool automates the application and evaluation of various algorithms to remove technical noise from high-dimensional morphological profiling datasets. Use when user asks to address batch effects, integrate data across experimental runs, or evaluate biological signal preservation in image-based profiling data.
homepage: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection
---

# batchcorrection

## Overview

The batchcorrection skill provides a standardized framework for addressing batch effects in high-dimensional morphological profiling datasets. It automates the execution of various correction algorithms and generates quantitative metrics to evaluate how well biological signal is preserved versus how effectively technical noise is removed. This skill is particularly useful for researchers working with Cell Painting or other image-based profiling data who need to integrate data across different plates, batches, or experimental days.

## Installation and Environment Setup

The framework requires a specific Python/R environment. Use Mamba for reliable dependency resolution.

1.  **Create the environment**:
    ```bash
    mamba env create --file environment.yaml
    mamba activate batchcp
    ```

2.  **Install R dependencies**:
    The `kBET` package must be installed from GitHub:
    ```bash
    R -e "remotes::install_github('theislab/kBET')"
    ```

3.  **Manual Package Fixes**:
    If `scib` or `mnnpy` fail to install via Mamba, install them from source to ensure C++ components are compiled for your specific architecture:
    ```bash
    # For scib
    git clone https://github.com/theislab/scib.git
    cd scib && git checkout v1.1.4 && pip install -e .
    ```

## Core Workflow

### 1. Data Acquisition
Before running corrections, download the required profiles and metadata:
```bash
source download_data.sh
```

### 2. Executing Correction Scenarios
The tool uses Snakemake to orchestrate the correction and evaluation process. Scenarios are defined in configuration files.

*   **Run a specific scenario (e.g., Scenario 1)**:
    ```bash
    snakemake -c3 --configfile inputs/conf/scenario_1.json
    ```
    *Replace `-c3` with the number of CPU cores available.*

### 3. Supported Correction Methods
The pipeline can execute the following methods as defined in the `Snakefile`:
*   **Linear/Statistical**: `combat`, `sphering`
*   **Graph/Mutual Nearest Neighbors**: `scanorama`, `fastMNN`, `mnn`
*   **Iterative/Embedding**: `harmony`, `desc`, `scvi`
*   **R-based/Seurat**: `seurat_cca`, `seurat_rpca`

## Best Practices and Expert Tips

*   **Resource Management**: Batch correction on large single-cell datasets is memory-intensive. When running `scvi` or `desc`, ensure you have sufficient RAM or access to a GPU if the environment supports it.
*   **Scenario Selection**: 
    *   Use **Scenario 1** for standard batch-to-batch evaluation.
    *   Check the `inputs/conf/` directory for other predefined scenarios that match your experimental design.
*   **Output Inspection**: Results are stored in the `./outputs` folder.
    *   Check `results_table.pdf` for a summary of quantitative scores.
    *   Review `full_panel.pdf` for UMAP/embedding visualizations of the corrected data.
*   **Feature Selection**: The default workflow (`mad_int_featselect`) uses Median Absolute Deviation and intensity-based feature selection. Ensure your input data is properly normalized before running the correction rules.



## Subcommands

| Command | Description |
|---------|-------------|
| Rscript batch_correction_docker_wrapper.R | Wrapper script for batch correction, with options to use LOESS or other methods. |
| Rscript batch_correction_docker_wrapper.R | Wrapper script for batch correction, can delegate to different underlying scripts based on options. |

## Reference documentation

- [Evaluating batch correction methods for image-based cell profiling README](./references/github_com_carpenter-singh-lab_2023_Arevalo_NatComm_BatchCorrection_blob_main_README.md)
- [Snakemake Workflow Definition](./references/github_com_carpenter-singh-lab_2023_Arevalo_NatComm_BatchCorrection_blob_main_Snakefile.md)
- [Environment Configuration](./references/github_com_carpenter-singh-lab_2023_Arevalo_NatComm_BatchCorrection_blob_main_environment.yaml.md)