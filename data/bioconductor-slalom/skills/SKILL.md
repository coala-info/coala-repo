---
name: bioconductor-slalom
description: This tool uses factorial latent variable modeling to identify biological pathways and hidden drivers of variation in single-cell RNA-seq data. Use when user asks to identify active gene sets, discover unannotated factors of cell-to-cell variability, or decompose expression variation into known and unknown components.
homepage: https://bioconductor.org/packages/release/bioc/html/slalom.html
---


# bioconductor-slalom

name: bioconductor-slalom
description: Factorial single-cell latent variable modeling to identify hidden and biological drivers of variation in single-cell RNA-seq data. Use this skill when analyzing single-cell gene expression data to identify active pathways (gene sets) and discover unannotated (hidden) factors that explain cell-to-cell variability.

## Overview
The `slalom` package implements a Bayesian latent variable model that decomposes single-cell expression variation into known biological factors (provided via gene sets) and unknown hidden factors. It is particularly useful for identifying which pathways are active in a population of cells and for regressing out unwanted technical noise or biological "nuisance" variables like cell cycle.

## Typical Workflow

### 1. Data Preparation
`slalom` requires two primary inputs:
*   **Expression Data**: A `SingleCellExperiment` object containing log-transformed expression values (typically in the `logcounts` assay).
*   **Gene Sets**: A `GeneSetCollection` object (from the `GSEABase` package), often loaded from a `.gmt` file.

```r
library(slalom)
library(SingleCellExperiment)
library(GSEABase)

# Load expression data
# sce <- readRDS("your_data.rds") 

# Load gene sets from a GMT file
gmtfile <- "path/to/genesets.gmt"
genesets <- getGmt(gmtfile)
```

### 2. Model Construction
Create the model object using `newSlalomModel`. You must specify the number of hidden factors to discover.

```r
# n_hidden: 2-5 is generally recommended
# min_genes: minimum genes required to retain a gene set
model <- newSlalomModel(sce, genesets, n_hidden = 5, min_genes = 10)
```

### 3. Initialization and Training
The model uses Variational Bayes and requires initialization before training.

```r
# Initialize
model <- initSlalom(model)

# Train the model
# nIterations: 1000+ usually required for convergence
model <- trainSlalom(model, nIterations = 2000, shuffle = TRUE, pretrain = TRUE)
```

### 4. Interpreting Results
Identify the most relevant factors (both annotated pathways and hidden factors).

```r
# View top terms by relevance
results <- topTerms(model)

# Plotting
plotRelevance(model)      # Rank factors by importance
plotTerms(model)          # Global view of all terms
plotLoadings(model, "TERM_NAME") # Gene-level weights for a specific factor
```

### 5. Downstream Integration
Add the discovered factors back to the `SingleCellExperiment` object for use with other tools like `scater`.

```r
sce <- addResultsToSingleCellExperiment(sce, model)

# Access factor states in reducedDim
# reducedDim(sce, "slalom")
```

## Tips and Best Practices
*   **Data Scaling**: Ensure data is log-normalized. `slalom` works best on highly variable genes to reduce computational load.
*   **Gene Set Names**: Truncate or clean gene set names (e.g., removing "REACTOME_") before model creation to improve plot readability.
*   **Convergence**: If the model does not converge, increase `nIterations`. Using `shuffle = TRUE` and `pretrain = TRUE` in `trainSlalom` helps achieve better convergence.
*   **Hidden Factors**: Use hidden factors to capture batch effects or technical noise, which can then be regressed out using `scater::regressOut`.

## Reference documentation
- [Introduction to slalom](./references/vignette.md)