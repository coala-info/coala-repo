---
name: bioconductor-progeny
description: This tool infers signaling pathway activities from bulk or single-cell gene expression data using consensus gene signatures derived from perturbation experiments. Use when user asks to estimate pathway activity scores, analyze transcriptomics data with PROGENy, or identify signaling pathway signatures in human or mouse samples.
homepage: https://bioconductor.org/packages/release/bioc/html/progeny.html
---

# bioconductor-progeny

name: bioconductor-progeny
description: Infer pathway activities from gene expression data using PROGENy (Pathway Responsive GENes). Use this skill when analyzing transcriptomics data (bulk or single-cell) to estimate the activity of 14 core signaling pathways (Androgen, EGFR, Estrogen, Hypoxia, JAK-STAT, MAPK, NFkB, p53, PI3K, TGFb, TNFa, Trail, VEGF, WNT) based on consensus gene signatures derived from perturbation experiments.

## Overview

PROGENy is a method that overcomes the limitations of traditional gene set enrichment by using "pathway responsive genes"—genes that consistently change expression in response to pathway perturbations. It provides a weight for each gene's contribution to a pathway, allowing for a more robust estimation of signaling activity than simple overlap-based methods.

## Core Workflows

### 1. Loading the Resource
Access the pre-computed models for Human or Mouse.

```r
library(progeny)

# Load the full human model (contains weights and p-values for all genes)
model <- progeny::model_human_full

# Load the mouse model
model_mouse <- progeny::model_mouse_full
```

### 2. Estimating Pathway Activities
The primary function `progeny()` calculates activity scores for a given gene expression matrix.

```r
# expression_matrix: rows are genes (Symbols), columns are samples
pathway_activities <- progeny(expr = expression_matrix, 
                              scale = TRUE, 
                              organism = "Human", 
                              top = 100)
```

**Key Parameters:**
- `scale`: If TRUE, scores are normalized across samples.
- `organism`: "Human" or "Mouse".
- `top`: Number of top significant genes per pathway to use (default is 100; recommended for optimal signal-to-noise ratio).

### 3. Working with Single-Cell Data
For Seurat objects, PROGENy can be integrated directly into the workflow.

```r
# Assuming 'seurat_obj' is a Seurat object
seurat_obj <- progeny(seurat_obj, scale=FALSE, organism="Human", top=100, assay="RNA")

# The results are stored in a new assay called "progeny"
# You can then visualize pathway activities using standard Seurat plotting
Seurat::FeaturePlot(seurat_obj, features = "MAPK")
```

### 4. Manual Model Filtering
To inspect or customize the gene weights used for activity inference:

```r
library(dplyr)

# Get the top 100 genes by significance for each pathway
model_100 <- progeny::model_human_full %>%
  group_by(pathway) %>%
  slice_min(order_by = p.value, n = 100)
```

## Interpretation Tips

- **Weights**: A positive weight means the gene is up-regulated when the pathway is active; a negative weight means it is down-regulated.
- **Activity Scores**: High scores indicate higher signaling activity relative to other samples in the dataset.
- **Integration**: For downstream statistical analysis (e.g., differential activity between conditions), it is recommended to use the `decoupleR` package, which provides a unified interface for PROGENy and other enrichment methods.

## Reference documentation

- [PROGENy pathway signatures](./references/progeny.Rmd)
- [PROGENy pathway signatures (Markdown)](./references/progeny.md)