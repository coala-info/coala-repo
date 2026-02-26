---
name: batchcorrection
description: The batchcorrection tool benchmarks and executes algorithms to remove technical artifacts from image-based cell profiling data. Use when user asks to remove batch effects from imaging data, execute multi-step Snakemake workflows for data integration, or compare the performance of different correction methods.
homepage: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection
---


# batchcorrection

## Overview

The batchcorrection skill provides a standardized framework for benchmarking and executing batch correction algorithms on image-based cell profiling data. It automates the transition from raw profiles to corrected datasets by managing complex dependencies (Python and R), executing multi-step Snakemake workflows, and generating comparative metrics. Use this skill when you need to remove technical artifacts from high-throughput imaging data or compare the performance of different integration methods across various experimental scenarios.

## Environment Setup

The pipeline requires a specific environment containing both Python and R dependencies.

1.  **Create Environment**:
    ```bash
    mamba env create --file environment.yaml
    mamba activate batchcp
    ```

2.  **Install R Dependencies**:
    The `kBET` package must be installed manually via R:
    ```bash
    R -e "remotes::install_github('theislab/kBET')"
    ```

3.  **Source Installations**:
    Certain packages like `scib` and `mnnpy` may require manual compilation or source installation if the environment-specific binaries fail:
    ```bash
    # Example for scib
    git clone https://github.com/theislab/scib.git
    cd scib
    git checkout v1.1.4
    pip install -e .
    ```

## Core Workflow

### 1. Data Acquisition
Before running any correction, download the necessary profiles and metadata:
```bash
source download_data.sh
```

### 2. Running Correction Scenarios
The tool uses Snakemake to orchestrate the correction and evaluation. Scenarios are defined in JSON configuration files.

*   **Standard Execution**:
    ```bash
    snakemake -c3 --configfile inputs/conf/scenario_1.json
    ```
    Replace `-c3` with the number of available CPU cores and point to the desired scenario file in `inputs/conf/`.

### 3. Output Analysis
Results are aggregated in the `./outputs` directory:
*   **Corrected Profiles**: The actual data after batch effect removal.
*   **Scores**: Quantitative evaluation metrics (e.g., kBET, consistency).
*   **Plots**: Embedding visualizations (UMAP/TSNE) to qualitatively assess integration.

## Expert Tips and Best Practices

*   **Memory Management**: Methods like Seurat can be memory-intensive. If running large scenarios, ensure the host machine has sufficient RAM or adjust the Snakemake resource constraints.
*   **Method Selection**:
    *   Use **BBKNN** for larger datasets where computational efficiency is a priority.
    *   Use **Seurat v4** or **fastMNN** for robust integration when R-based methods are preferred.
    *   Use **SCANVI** or **Gauss-VI** for deep learning-based integration (requires CUDA support in the environment).
*   **Configuration Tweaks**:
    *   **Sphering**: Ensure the `sphering` key is correctly defined in your config file to normalize feature variance before correction.
    *   **Consistency Metrics**: The pipeline includes specific rules for calculating consistency; ensure these are enabled in the Snakemake execution to validate that biological signal is preserved.
*   **Troubleshooting scib**: If `scib` fails due to C++ compilation issues, always fallback to the manual `pip install -e .` method from a local clone of the repository.

## Reference documentation
- [Evaluating batch correction methods for image-based cell profiling](./references/github_com_carpenter-singh-lab_2023_Arevalo_NatComm_BatchCorrection.md)