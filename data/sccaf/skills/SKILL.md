---
name: sccaf
description: SCCAF (Single-Cell Clustering Assessment Framework) is a machine learning-based method used to validate and refine cell-type clusters in scRNA-seq datasets.
homepage: https://github.com/SCCAF/sccaf
---

# sccaf

## Overview
SCCAF (Single-Cell Clustering Assessment Framework) is a machine learning-based method used to validate and refine cell-type clusters in scRNA-seq datasets. It operates by iteratively applying a classifier to gene expression profiles to determine if clusters are truly distinct. If a classifier cannot accurately discriminate between two clusters, SCCAF suggests they represent the same cell state and should be merged. This tool is particularly effective for transforming a high-resolution "over-clustering" into a biologically meaningful set of cell types while providing statistical rigor through accuracy metrics and ROC (Receiver Operating Characteristic) analysis.

## Installation and Setup
SCCAF is primarily distributed via Bioconda and PyPI. It requires a Python 3 environment.

```bash
# Installation via Conda (Recommended)
conda install -c bioconda sccaf

# Installation via Pip
pip install sccaf
```

## Common CLI Patterns

### 1. Clustering Assessment
To evaluate the quality of an existing clustering (e.g., Louvain clusters) within an AnnData (`.h5ad`) file:

```bash
sccaf -i input_data.h5ad --slot louvain --assessment
```
*Note: This evaluates how well a machine learning model can predict the assigned cluster labels.*

### 2. Clustering Optimization
To automatically merge clusters that are not significantly different until a specific accuracy threshold is met:

```bash
sccaf -i input_data.h5ad --slot L2_Round0 --optimise --min_acc 0.90 --prefix L2
```
*   `--slot`: The starting clustering label in the AnnData object.
*   `--min_acc`: The target accuracy (e.g., 0.90). The tool will merge clusters until the classifier reaches this accuracy.
*   `--prefix`: The prefix for the new optimized cluster labels (e.g., `L2_Round1`, `L2_Round2`).

### 3. Regressing Out Batch Effects
Before running assessment or optimization, batch effects must be handled. SCCAF provides a CLI utility for this:

```bash
sccaf-regress-out -i input_data.h5ad -v "batch,n_counts"
```

### 4. Adjusting Sampling Iterations
For large datasets or when higher precision is needed in the assessment phase, adjust the number of iterations used for sampling:

```bash
sccaf -i input_data.h5ad --slot louvain --assessment --iterations 200
```

## Expert Tips and Best Practices

### Pre-processing Requirements
*   **Batch Correction**: SCCAF is sensitive to batch effects. Always ensure batch effects have been regressed or corrected before running the assessment.
*   **Doublet Removal**: Exclude doublets prior to analysis, as they can create "hybrid" signatures that confuse the classifier.

### Optimization Strategy
*   **Start with Over-clustering**: The recommended workflow is to start with a high-resolution clustering (e.g., Scanpy Louvain resolution 1.5 or 2.0) that separates all visible "cell islands" in a t-SNE or UMAP plot. SCCAF will then merge the redundant ones.
*   **Feature Space**: Use the `pca` space for optimization to significantly increase execution speed without substantial loss in discrimination power.

### Interpreting Results
*   **Accuracy**: Higher accuracy indicates better discrimination between clusters. If accuracy is low, it suggests the clusters are too similar or the data is too noisy.
*   **ROC Curves**: Use the ROC curves to identify specific "problematic" clusters. Clusters with low Area Under the Curve (AUC) are those most frequently confused with others.

## Reference documentation
- [GitHub Repository: SCCAF/sccaf](./references/github_com_SCCAF_sccaf.md)
- [Bioconda: sccaf package overview](./references/anaconda_org_channels_bioconda_packages_sccaf_overview.md)