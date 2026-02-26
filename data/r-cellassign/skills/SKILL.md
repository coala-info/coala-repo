---
name: r-cellassign
description: r-cellassign performs automated, probabilistic cell type assignment for single-cell RNA-seq data using a marker gene matrix and a hierarchical Bayesian model. Use when user asks to classify cells into types based on marker genes, assign cell types in scRNA-seq data, or account for batch effects during cell type identification.
homepage: https://cran.r-project.org/web/packages/cellassign/index.html
---


# r-cellassign

name: r-cellassign
description: Automated, probabilistic assignment of cell types in single-cell RNA-seq (scRNA-seq) data using known marker genes. Use this skill when you need to classify cells into types based on a marker gene matrix while accounting for batch effects and patient-specific variation.

## Overview

`cellassign` is an R package that uses a hierarchical Bayesian model to assign cells to known cell types. Unlike unsupervised clustering, it leverages *a priori* knowledge of marker genes to provide probabilistic assignments, reducing subjective bias. It is particularly effective for profiling the tumor microenvironment and handling large-scale scRNA-seq datasets with batch effects.

## Installation

`cellassign` requires Google's TensorFlow (version 2.x) and TensorFlow Probability.

```R
# Install dependencies
install.packages("tensorflow")
tensorflow::install_tensorflow(extra_packages='tensorflow-probability', version = "2.1.0")

# Install cellassign
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("Irrationone/cellassign")
```

## Core Workflow

### 1. Prepare Input Data
The model requires four primary inputs:
- **Expression Data**: A cell-by-gene matrix of raw counts or a `SingleCellExperiment` object.
- **Marker Matrix**: A binary (0/1) gene-by-celltype matrix where 1 indicates the gene is a marker for that cell type.
- **Size Factors**: A numeric vector of cell-specific normalization factors.
- **Design Matrix (Optional)**: A matrix `X` to account for batch effects or covariates.

### 2. Run CellAssign
Use the `cellassign()` function to perform the classification.

```R
library(cellassign)

# Example using a count matrix
cas <- cellassign(exprs_obj = counts_matrix,
                  marker_gene_info = marker_matrix,
                  s = size_factors,
                  X = design_matrix,
                  learning_rate = 1e-2,
                  shrinkage = TRUE)
```

### 3. Access Results
The output object contains several useful slots:
- `cell_type`: The MAP (maximum a posteriori) cell type assignment for each cell.
- `mle_params`: Probability distributions across all cell types for each cell.

```R
# Get assigned cell types
assignments <- cas$cell_type

# Get probability matrix (cells x cell types)
probs <- cas$mle_params$gamma
```

## Tips for Success

- **Marker Selection**: Markers should be specific. If a gene is expressed in all cell types, it provides no discriminatory power.
- **Size Factors**: Calculate these using standard methods like `scran::computeSumFactors` or library size normalization before running `cellassign`.
- **Design Matrix**: Always include a design matrix if your data contains multiple patients or technical batches to prevent these factors from confounding cell type assignment.
- **Unassigned Cells**: `cellassign` can include an "other" or "unknown" category if the marker matrix is constructed to allow for it, or you can threshold the resulting probabilities.

## Reference documentation

- [CODE_OF_CONDUCT.md](./references/CODE_OF_CONDUCT.md)
- [LICENSE.md](./references/LICENSE.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)