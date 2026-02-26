---
name: r-immucellaimouse
description: This tool estimates the abundance of 36 immune cell types and predicts immune checkpoint blockade response from mouse gene expression data. Use when user asks to estimate immune cell proportions, analyze mouse transcriptomic data for cell infiltration, or predict ICB response.
homepage: https://cran.r-project.org/web/packages/immucellaimouse/index.html
---


# r-immucellaimouse

name: r-immucellaimouse
description: Estimation of mouse immune cell abundance from gene expression data (RNA-Seq or microarray). Use this skill when analyzing mouse transcriptomic data to predict the proportions of 36 immune cell types, including detailed T-cell subsets, and to predict Immune Checkpoint Blockade (ICB) response.

## Overview

The `immucellaimouse` package (Immune Cell Abundance Identifier for mouse) implements a hierarchical strategy to estimate the abundance of 36 immune cell types. It simulates flow cytometry processes to predict cell proportions across two layers:
- **Layer 1 (General):** DC, B cell, Monocyte, Macrophage, NK, Neutrophil, CD4 T, CD8 T, NKT, Tgd.
- **Layer 2 (Subsets):** CD4 naive, CD8 naive, Tc, Tex, Tr1, nTreg, iTreg, Th1, Th2, Th17, Tfh, Tcm, Tem, MAIT.

## Installation

Install the package from GitHub using `devtools`:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github("lydiaMyr/ImmuCellAI-mouse@main")
```

*Note: If a "/bin/gtar: not found" error occurs during installation, run `Sys.setenv(TAR = "/bin/tar")` before installing.*

## Main Workflow

The primary function is `ImmuCellAI_mouse()`. It requires an expression matrix and specific metadata tags.

### Basic Usage

```R
library(ImmuCellAImouse)

# sample_expression: Matrix/data.frame with genes as rows and samples as columns
# datatype: "rnaseq" (FPKM/TPM) or "microarray" (log2-transformed)
# group_tag: 0 (no comparison) or 1 (perform group comparison)
# customer: 0 (standard reference) or 1 (user-provided reference)

result <- ImmuCellAI_mouse(
  sample_expression = exp_matrix,
  datatype = "rnaseq",
  group_tag = 0,
  customer = 0
)
```

### Input Requirements

1.  **Expression Matrix:** 
    - For RNA-Seq: Use FPKM or TPM values.
    - For Microarray: Use log2-transformed signals.
2.  **Group Comparison:** If `group_tag = 1`, the input matrix must include a row labeled "group" indicating the group assignment for each sample.
3.  **Custom Reference:** If `customer = 1`, you must provide a gene signature list and a reference expression matrix (cell types as columns, genes as rows).

### Understanding Output

The function returns a list containing three components:
- **Sample immune cell abundance:** A matrix of predicted proportions for 36 cell types per sample.
- **Group comparison result:** Statistical differences between groups (if `group_tag = 1`).
- **ICB response prediction:** Predicted response to Immune Checkpoint Blockade therapy.

## Tips for Success

- **Gene Symbols:** Ensure gene identifiers in your expression matrix match the symbols used in the package (typically official mouse gene symbols).
- **Data Normalization:** Do not use raw counts for RNA-Seq; convert to TPM or FPKM first to ensure compatibility with the internal signature models.
- **Hierarchical Logic:** Remember that the abundance of Layer 2 subsets is calculated relative to their parent populations in Layer 1.

## Reference documentation

- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)