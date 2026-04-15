---
name: stellarscope
description: StellarScope analyzes single-cell RNA sequencing data to identify and quantify transposable elements at the locus level. Use when user asks to analyze transposable elements in single-cell RNA sequencing data.
homepage: https://github.com/nixonlab/stellarscope
metadata:
  docker_image: "quay.io/biocontainers/stellarscope:1.5--py312h0fa9677_1"
---

# stellarscope

yaml
name: stellarscope
description: |
  Tool for Single-cell Transposable Element Locus Level Analysis of scRNA Sequencing.
  Use when analyzing single-cell RNA sequencing data to identify and characterize transposable elements (TEs) at the locus level.
  This skill is suitable for researchers working with scRNA-seq datasets who need to understand TE activity and its impact on cell identity.
```
## Overview
StellarScope is a specialized bioinformatics tool designed for the in-depth analysis of single-cell RNA sequencing (scRNA-seq) data. Its primary function is to identify and quantify transposable elements (TEs) at the locus level within individual cells. This allows researchers to investigate the dynamics of TE activity and its potential role in cellular heterogeneity and identity. Use StellarScope when you need to perform locus-level analysis of TEs in your scRNA-seq experiments.

## Usage Instructions

StellarScope is typically installed via conda. The primary interaction with the tool is through its command-line interface (CLI).

### Installation

It is recommended to use the `mamba` package manager for installation, as it is a reimplementation of `conda` and can be faster.

1.  **Install mamba (recommended):**
    Follow instructions on the mamba documentation.

2.  **Install StellarScope using bioconda:**
    *   **To an existing environment:**
        ```bash
        mamba install bioconda::stellarscope
        ```
    *   **To create a new environment:**
        ```bash
        mamba create --name myenv stellarscope
        ```
        Replace `myenv` with your desired environment name.

### Core Functionality

StellarScope's main purpose is to analyze scRNA-seq data for transposable element (TE) locus-level analysis. While specific command structures are not detailed in the provided documentation, typical workflows for such tools involve:

1.  **Input Data:** Providing processed scRNA-seq count matrices or similar data formats.
2.  **Reference Genomes/Annotations:** Specifying reference genomes and TE annotations (e.g., GTF, BED files) to map TEs.
3.  **Analysis Parameters:** Configuring parameters related to TE identification, quantification, and filtering.
4.  **Output Generation:** Producing results such as TE expression matrices, locus activity summaries, and potentially visualizations.

### Expert Tips and Common Patterns

*   **Environment Management:** Always use dedicated conda/mamba environments for bioinformatics tools like StellarScope to avoid dependency conflicts.
*   **Documentation Review:** Refer to the official StellarScope GitHub repository for the most up-to-date CLI commands, detailed parameter explanations, and example workflows. The `README.md` and `docs/` directory are crucial resources.
*   **Data Preprocessing:** Ensure your scRNA-seq data is properly preprocessed (e.g., quality control, alignment, quantification) before inputting it into StellarScope. The tool likely expects specific input formats.
*   **TE Annotation Quality:** The accuracy of your TE analysis heavily relies on the quality and completeness of the transposable element annotation files used. Ensure you are using appropriate and well-curated annotations for your organism of interest.
*   **Computational Resources:** Analyzing large scRNA-seq datasets can be computationally intensive. Be prepared to allocate sufficient CPU, memory, and potentially GPU resources depending on the scale of your data and the specific analysis steps.

## Reference documentation
- [Stellarscope GitHub Repository](https://github.com/nixonlab/stellarscope.md)
- [Stellarscope Overview on Anaconda.org](https://anaconda.org/bioconda/stellarscope/overview)