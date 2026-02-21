---
name: switchtfi
description: SwitchTFI is a specialized computational framework implemented in Python for identifying the regulatory drivers of cell fate transitions.
homepage: https://github.com/bionetslab/SwitchTFI
---

# switchtfi

## Overview

SwitchTFI is a specialized computational framework implemented in Python for identifying the regulatory drivers of cell fate transitions. It integrates scRNA-seq datasets with gene regulatory networks (GRNs) to determine which transcription factors act as "switches" during differentiation. Use this skill when you need to perform TF ranking, weight fitting for regulatory interactions, or p-value calculations to validate the biological significance of specific regulators in lineages such as erythroid, beta, or alpha cells.

## Installation and Environment Setup

The package is primarily distributed via Bioconda. For a full environment including all dependencies, use the provided environment file if working from a cloned repository.

- **Standard Installation**:
  ```bash
  conda install -c conda-forge -c bioconda switchtfi
  ```

- **Development Setup**:
  ```bash
  git clone git@github.com:bionetslab/SwitchTFI.git
  cd SwitchTFI
  conda env create -f switchtfi.yml
  conda activate switchtfi
  ```

## Core Usage Patterns

### Running Example Workflows
The repository includes an `example.py` script to demonstrate the analysis on preprocessed datasets.

- **Execute on Erythroid data**:
  ```bash
  python example.py -d ery
  ```
- **Execute on Beta cell data**:
  ```bash
  python example.py -d beta
  ```
- **Execute on Alpha cell data**:
  ```bash
  python example.py -d alpha
  ```

### Python API Integration
For custom pipelines, interact with the `switchtfi` modules directly.

1. **Data Access**: Use `switchtfi.data` to load preprocessed scRNA-seq datasets and previously inferred GRNs.
2. **Preprocessing**: If using raw data, follow the preprocessing steps outlined in the `docs/example.ipynb` notebook, which includes data imputation (using `magic-impute`).
3. **TF Ranking**: Utilize the internal ranking functions to evaluate TF influence based on the switching method.
4. **Plotting**: The tool supports `graph-tool` for high-performance network visualization, with a `networkx` fallback if `graph-tool` is unavailable.

## Expert Tips and Best Practices

- **Data Imputation**: Differentiation analysis often suffers from dropout in scRNA-seq. Ensure `magic-impute` is correctly configured in your environment to improve the reliability of TF switching signals.
- **GRN Selection**: The accuracy of SwitchTFI is highly dependent on the quality of the input GRN. Use high-confidence inferred networks or the provided reference GRNs in `switchtfi.data`.
- **Visualization**: If network plots are not rendering correctly, ensure `igraph` is installed. SwitchTFI uses `igraph` as a primary dependency for graph manipulations.
- **Documentation Access**: Detailed parameter descriptions for functions are maintained within the Python docstrings. Use `help(switchtfi.function_name)` within a Python interpreter for immediate reference.

## Reference documentation
- [SwitchTFI Overview](./references/anaconda_org_channels_bioconda_packages_switchtfi_overview.md)
- [SwitchTFI GitHub Repository](./references/github_com_bionetslab_SwitchTFI.md)
- [SwitchTFI Documentation and Examples](./references/github_com_bionetslab_SwitchTFI_tree_main_docs.md)