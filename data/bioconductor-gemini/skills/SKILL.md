---
name: bioconductor-gemini
description: The gemini package implements a variational Bayes approach to identify genetic interactions and calculate interaction scores from pairwise CRISPR knockout screens. Use when user asks to identify synergistic or buffering gene relationships, analyze dual-guide CRISPR screens, or calculate interaction significance values from guide counts.
homepage: https://bioconductor.org/packages/release/bioc/html/gemini.html
---


# bioconductor-gemini

## Overview
The `gemini` package implements a variational Bayes approach to identify genetic interactions in pairwise CRISPR knockout screens. It jointly analyzes all samples and reagents to account for sample, reagent, and biological variability. The workflow transforms raw guide counts into interaction scores and significance values (FDR), allowing for the systematic discovery of synergistic or buffering gene relationships.

## Core Workflow

### 1. Data Preparation
GEMINI requires three inputs: a counts matrix, sample/replicate annotations, and guide/gene annotations.

```r
library(gemini)
library(magrittr)

# Create the gemini input object
Input <- gemini_create_input(
  counts.matrix = counts,
  sample.replicate.annotation = sample.replicate.annotation,
  guide.annotation = guide.annotation,
  ETP.column = 'pDNA', # Early Time Point / Reference column
  gene.column.names = c("U6.gene", "H1.gene"),
  sample.column.name = "samplename"
)

# Calculate Log-Fold Change (LFC)
Input %<>% gemini_calculate_lfc(normalize = TRUE, CONSTANT = 32)
```

### 2. Model Initialization and Inference
Initialization requires defining a negative control gene (`nc_gene`). It is highly recommended that every gene in the library is paired with this negative control at least once.

```r
# Initialize the model
# pattern_split: separator in counts.matrix rownames
# pattern_join: separator for output gene pairs
Model <- gemini_initialize(
  Input = Input,
  nc_gene = "CD81",
  pattern_join = ';',
  pattern_split = ';',
  cores = 1
)

# Perform Coordinate-Ascent Variational Inference (CAVI)
Model %<>% gemini_inference(cores = 1, verbose = FALSE)
```

### 3. Scoring Interactions
To calculate significance, you must provide a set of non-interacting gene pairs (`nc_pairs`) to build the null distribution.

```r
# Identify non-interacting pairs (e.g., pairs involving negative controls)
nc_pairs <- grep("6T|HPRT", rownames(Model$s), value = TRUE)

# Score interactions
# pc_gene: positive control gene to filter individually lethal effects
Score <- gemini_score(
  Model = Model,
  pc_gene = "EEF2",
  nc_pairs = nc_pairs
)
```

## Interpreting Results

*   **Interaction Strength:** Found in `Score$strong`. Positive values typically indicate synthetic lethality (synergy), while negative values may indicate recovery (buffering).
*   **Significance:** Found in `Score$fdr_strong`. Use standard thresholds (e.g., < 0.05 or 0.1) to identify significant interactions.
*   **Convergence:** Use `gemini_plot_mae(Model)` to ensure the Mean Absolute Error (MAE) decreased and stabilized during inference.

## Visualization
Use `gemini_boxplot` to inspect specific gene pairs. This function visualizes the LFC distribution and the adjustments made by the GEMINI model.

```r
gemini_boxplot(
  Model = Model, 
  g = "BRCA2", 
  h = "PARP1", 
  nc_gene = "CD81", 
  sample = "A549",
  show_inference = TRUE, 
  identify_guides = TRUE
)
```

## Reference documentation
- [A guide to the GEMINI R package](./references/gemini-quickstart.md)
- [QuickStart Vignette Source](./references/gemini-quickstart.Rmd)