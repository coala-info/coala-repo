---
name: celltypist
description: CellTypist is a tool designed for the semi-automatic classification of cell types in scRNA-seq datasets.
homepage: https://github.com/Teichlab/celltypist
---

# celltypist

## Overview

CellTypist is a tool designed for the semi-automatic classification of cell types in scRNA-seq datasets. It utilizes logistic regression classifiers optimized via stochastic gradient descent to assign labels to query cells. While it features a robust library of built-in models focused on immune cells, it also allows users to train and apply custom models. It supports both "best match" (single label) and "probability match" (multi-label or unassigned) classification modes to handle high-resolution cell typing and novel cell discovery.

## Installation and Setup

Install via conda or pip:
```bash
# Conda
conda install -c bioconda -c conda-forge celltypist

# Pip
pip install celltypist
```

## Model Management

Models are the foundation of the annotation process. Each model is approximately 1MB.

- **List available models**: `models.models_description()`
- **Download models**: `models.download_models(model = 'Immune_All_Low.pkl')` (or leave empty to download all).
- **Update models**: Use `force_update = True` in the download function.
- **Load a model**: `model = models.Model.load(model = 'Immune_All_Low.pkl')`
- **Inspect features**: Check `model.cell_types` and `model.features` to ensure your input data matches the model's expected genes.

## Annotation Workflow

CellTypist accepts count tables (.csv, .tsv, .txt, .mtx) or AnnData objects. Raw counts (UMIs or reads) are required.

### Basic Annotation
```python
import celltypist
# Annotate using a specific model
predictions = celltypist.annotate(input_file, model = 'Immune_All_Low.pkl')
```

### Handling Input Formats
- **Gene-by-cell**: If genes are rows and cells are columns, use `transpose_input = True`.
- **MTX files**: Specify `gene_file` and `cell_file` paths.
- **Missing Genes**: Include non-expressed genes in your input table; they serve as negative transcriptomic signatures for the classifier.

### Classification Modes
1. **Best Match (Default)**: Assigns the cell type with the highest decision score. Best for differentiating between distinct, known populations.
2. **Probability Match**: Use `mode = 'prob match'` with a `p_thres` (default 0.5).
   - Cells failing the threshold are labeled 'Unassigned'.
   - Cells exceeding the threshold for multiple types receive concatenated labels (e.g., 'TypeA|TypeB').

## Result Analysis

The `annotate` function returns an `AnnotationResult` object:
- **Labels**: `predictions.predicted_labels`
- **Scores**: `predictions.decision_matrix` (raw scores)
- **Probabilities**: `predictions.probability_matrix` (sigmoid-transformed scores)

## Expert Tips

- **GPU Acceleration**: For large datasets, ensure you have the latest version (1.7.1+) which supports GPU options in the command line and specific environments.
- **Model Path**: By default, models are stored in `~/.celltypist/`. You can override this by setting the `CELLTYPIST_FOLDER` environment variable.
- **Custom Training**: If built-in models do not cover your tissue, use the training module to create a `.pkl` model from a labeled AnnData object.

## Reference documentation
- [CellTypist Overview](./references/anaconda_org_channels_bioconda_packages_celltypist_overview.md)
- [CellTypist GitHub Repository](./references/github_com_Teichlab_celltypist.md)