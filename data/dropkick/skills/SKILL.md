---
name: dropkick
description: dropkick is a data-driven tool that automates the filtering of cells from empty droplets in scRNA-seq data using a logistic regression model. Use when user asks to filter scRNA-seq data, identify true cells from ambient RNA, or perform automated quality control on raw count matrices.
homepage: https://github.com/KenLauLab/dropkick
---


# dropkick

## Overview

dropkick is a data-driven tool designed to automate the cell filtering process in scRNA-seq workflows. Unlike traditional methods that rely on hard manual thresholds for UMI counts or mitochondrial gene percentages, dropkick uses a logistic regression model trained on the specific dataset to identify "true" cells. It is particularly effective for datasets with high ambient RNA or complex droplet distributions where manual cutoffs are difficult to define. It integrates seamlessly with the Scanpy ecosystem but can also be used as a standalone command-line tool.

## Installation

Install dropkick via bioconda or pip. Note that a Fortran compiler (gcc/gfortran) is required for installation.

```bash
# Via Conda
conda install bioconda::dropkick

# Via Pip
pip install dropkick
```

## Command Line Usage

The dropkick CLI provides two primary modules: `qc` for initial data inspection and `run` for the automated filtering pipeline.

### 1. Quality Control (QC)
Before running the full filtering model, use the `qc` module to generate a summary of the total UMI distribution and identify ambient genes.

```bash
dropkick qc path/to/counts.h5ad
```
*   **Output**: Saves a `*_qc.png` file containing the UMI distribution plot and a list of top ambient genes.
*   **Input Formats**: Supports `.h5ad`, `.csv`, and `.tsv`.

### 2. Automated Filtering
The `run` command executes the full dropkick pipeline, including automated thresholding, model training, and cell scoring.

```bash
dropkick run path/to/counts.h5ad
```
*   **Output**: Generates a new `.h5ad` file containing:
    *   `dropkick_score`: Probability scores for each barcode.
    *   `dropkick_label`: Binary classification (cell vs. empty).
    *   Model coefficients and parameters stored in the object's metadata.

## Best Practices and Tips

-   **Input Data**: Always provide **raw, unfiltered count matrices**. dropkick needs to see the full distribution of droplets (including empty ones) to accurately train its model.
-   **File Formats**: While flat files (.csv, .tsv) are supported, using `.h5ad` (AnnData) is preferred as it preserves metadata and allows for easier downstream analysis with Scanpy.
-   **Ambient RNA**: Use the `qc` output to verify if expected marker genes are appearing as "ambient." If highly expressed biological markers are flagged as ambient, it may indicate high levels of cell lysis or background noise in your sample.
-   **Interactive Analysis**: For more control, dropkick can be imported as a Python module within a Jupyter notebook alongside `scanpy`. This allows for manual adjustment of thresholds if the automated heuristics (based on Otsu's method) require tuning.

## Reference documentation
- [dropkick - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dropkick_overview.md)
- [KenLauLab/dropkick: Automated cell filtering for single-cell RNA sequencing data](./references/github_com_KenLauLab_dropkick.md)