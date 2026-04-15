---
name: pymvpa
description: PyMVPA is a Python framework for performing multivariate pattern analysis and statistical learning on neuroimaging datasets. Use when user asks to perform searchlight analysis, execute hyperalignment, manage neuroimaging datasets, or set up multivariate pattern analysis workflows.
homepage: http://www.pymvpa.org/
metadata:
  docker_image: "quay.io/biocontainers/pymvpa:2.6.5--py36h355e19c_0"
---

# pymvpa

## Overview
PyMVPA (Multivariate Pattern Analysis in Python) is a specialized framework designed to facilitate statistical learning analyses of large datasets, with a primary focus on neuroimaging (fMRI, EEG, MEG). It provides a unified interface to various computing environments and libraries (like scikit-learn, SHOGUN, and MDP) to perform classification, regression, and feature selection. Use this skill to guide the setup of MVPA workflows, manage neuroimaging datasets, and execute searchlight or hyperalignment procedures.

## Functional Usage and Best Practices

### Installation and Environment
*   **Conda**: The preferred method for cross-platform installation is via bioconda: `conda install bioconda::pymvpa`.
*   **Debian/Ubuntu**: Use the official package: `sudo aptitude install python-mvpa2`.
*   **System Diagnostics**: To generate a comprehensive system summary for troubleshooting or bug reporting, use the built-in diagnostic tool:
    ```python
    import mvpa2
    mvpa2.wtf()
    ```

### Command Line Interface (CLI)
The primary entry point for command-line operations is the `pymvpa2` command.
*   **General Help**: Access the main help menu and list of available sub-commands: `pymvpa2 --help`.
*   **Tutorial Mode**: To launch an interactive tutorial session with pre-configured data paths:
    ```bash
    pymvpa2-tutorial --tutorial-data-path /path/to/data
    ```

### Core Workflow Concepts
When preparing data for PyMVPA, adhere to the following structural requirements:
*   **Datasets**: The fundamental container. It combines `samples` (the data matrix) with `attributes` (metadata).
*   **Targets**: Always define a `targets` attribute for supervised learning (labels for classification or values for regression).
*   **Chunks**: Crucial for cross-validation. Chunks define independent groups of samples (e.g., different fMRI runs). PyMVPA uses these to ensure that training and testing sets are truly independent, preventing temporal autocorrelation bias.
*   **Mappers**: Use Mappers for data transformations (e.g., Z-scoring, detrending, or flattening 4D NIfTI volumes into 2D matrices). Mappers are "reversible," allowing you to project results (like sensitivity maps) back into the original data space (e.g., back into a 3D brain volume).

### Expert Tips for Neuroimaging
*   **Searchlight Analysis**: Use the `Searchlight` measure to perform localized MVPA across the entire volume. This requires a `QueryEngine` (to define neighborhoods) and a `Measure` (usually a Cross-Validation of a classifier).
*   **Hyperalignment**: For across-subject decoding, use the `Hyperalignment` algorithm to map different subjects' neural responses into a common high-dimensional representational space.
*   **Memory Management**: Use "Conditional Attributes" (`.ca`) to store intermediate results. Note that "heavy" attributes are disabled by default to save memory; enable them explicitly if needed for analysis.
*   **NIfTI Integration**: Always ensure `nibabel` is installed to handle NIfTI I/O. PyMVPA provides a convenient wrapper for these datasets.

## Reference documentation
- [PyMVPA User Manual](./references/www_pymvpa_org_manual.html.md)
- [Tutorial Introduction to PyMVPA](./references/www_pymvpa_org_tutorial.html.md)
- [Glossary of Terms](./references/www_pymvpa_org_glossary.html.md)
- [Installation Instructions](./references/www_pymvpa_org_installation.html.md)