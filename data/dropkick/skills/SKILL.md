---
name: dropkick
description: dropkick is a machine learning tool that automates the filtering of single-cell RNA sequencing data to distinguish true cells from empty droplets and ambient RNA. Use when user asks to filter scRNA-seq data, identify ambient RNA, or perform quality control on count matrices.
homepage: https://github.com/KenLauLab/dropkick
metadata:
  docker_image: "quay.io/biocontainers/dropkick:1.2.8--py310h7eb0018_0"
---

# dropkick

## Overview

dropkick is a machine learning-based tool designed to automate the filtering process for single-cell RNA sequencing data. It addresses the challenge of distinguishing true cells from empty droplets and ambient RNA by calculating cell probability scores based on gene expression patterns. The tool integrates with the scanpy ecosystem and provides a robust alternative to manual, heuristic-based filtering (like fixed UMI or gene count thresholds). Use this skill to execute the dropkick pipeline via the command line or to understand the outputs generated during scRNA-seq preprocessing.

## Command Line Usage

The dropkick CLI provides two primary modules for processing and quality control.

### Automated Filtering
To run the full filtering pipeline on a count matrix:
```bash
dropkick run path/to/counts.h5ad
```
* **Input**: Supports `.h5ad`, `.csv`, and `.tsv` formats.
* **Output**: Generates a new `.h5ad` file containing:
    * `dropkick_score`: Probability scores for each cell.
    * `dropkick_label`: Binary classification (cell vs. empty).
    * Model parameters and coefficients.

### Quality Control (QC)
To generate a quick assessment of the dataset without running the full model:
```bash
dropkick qc path/to/counts.h5ad
```
* **Function**: Analyzes total UMI distribution and identifies ambiently expressed genes.
* **Output**: Saves a visualization as `*_qc.png` in the working directory.

## Best Practices and Expert Tips

* **Environment Setup**: Ensure a Fortran compiler (`gfortran` or `gcc`) is installed on the system before installing dropkick via pip, as it is required for compiling dependencies.
* **Format Preference**: Use `.h5ad` (AnnData) files whenever possible. This format preserves metadata and is the native structure for the underlying scanpy integration.
* **QC First**: Always run `dropkick qc` before the full `run` command. Inspect the resulting PNG to ensure the UMI distribution looks as expected and to identify high-abundance ambient genes that might skew results.
* **Interactive Analysis**: For complex datasets, use the dropkick Python API within a Jupyter notebook to fine-tune model parameters before committing to a full CLI run.
* **Downstream Integration**: Since dropkick stores its results in the `obs` and `uns` slots of the AnnData object, you can immediately filter your dataset in scanpy using:
  ```python
  adata = adata[adata.obs["dropkick_label"] == "yes"]
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| dropkick run | Run dropkick to identify ambient RNA in single-cell data. |
| dropkick_qc | Quality control for single-cell RNA-seq data. |

## Reference documentation
- [README.rst](./references/github_com_KenLauLab_dropkick_blob_master_README.rst.md)
- [dropkick_tutorial.ipynb](./references/github_com_KenLauLab_dropkick_blob_master_dropkick_tutorial.ipynb.md)