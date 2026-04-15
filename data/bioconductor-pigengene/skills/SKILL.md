---
name: bioconductor-pigengene
description: Pigengene analyzes gene expression data by grouping genes into modules and representing them as eigengenes for downstream modeling. Use when user asks to identify gene modules, compute eigengenes, infer Bayesian networks, or build decision tree classifiers for genomic data.
homepage: https://bioconductor.org/packages/release/bioc/html/Pigengene.html
---

# bioconductor-pigengene

name: bioconductor-pigengene
description: Analysis of gene expression data using Pigengenes (eigengenes). Use this skill to identify gene modules, compute eigengenes, infer Bayesian networks, and build decision tree classifiers for genomic applications.

## Overview
Pigengene is a Bioconductor package designed to reduce the dimensionality of gene expression data while maintaining biological relevance. It groups genes into modules (typically using WGCNA-based clustering) and represents each module by its "pigengene" (the first principal component or eigengene). These pigengenes are then used as robust features for downstream machine learning tasks, such as Bayesian Network inference or Decision Tree classification, to identify biomarkers and predict sample phenotypes.

## Core Workflow

1. **Data Preparation**: Ensure your expression matrix has samples as rows and genes as columns.
2. **Module Identification**: Group genes into co-expression modules.
3. **Pigengene Computation**: Calculate the first principal component for each module.
4. **Network Inference**: Build a Bayesian Network to understand relationships between modules and the target phenotype.
5. **Classification**: Use decision trees to identify the most predictive pigengenes.

## Key Functions

### one.step.pigengene
The primary wrapper function that executes the entire pipeline (clustering, eigengene computation, and network inference).
```r
library(Pigengene)
# data: matrix with genes in columns, samples in rows
# labels: factor of sample phenotypes
results <- one.step.pigengene(data = myData, 
                              labels = myLabels, 
                              saveDir = "pigengene_results",
                              seed = 123)
```

### compute.pigenegene
Calculates the eigengenes for predefined modules.
```r
# modules: a named character vector mapping genes to module colors/names
pg_list <- compute.pigenegene(data = myData, modules = myModules)
# Access the eigengenes matrix
eigengenes <- pg_list$pigengenes
```

### make.decision.tree
Constructs a decision tree to classify samples based on computed pigengenes.
```r
dt_res <- make.decision.tree(data = eigengenes, 
                             labels = myLabels, 
                             saveDir = "tree_output")
```

### draw.bn
Visualizes the inferred Bayesian Network.
```r
# bn.results is part of the output from one.step.pigengene
draw.bn(bn.results$learning$bn)
```

## Tips and Best Practices

* **Data Orientation**: Unlike many Bioconductor packages that expect genes in rows, Pigengene functions often expect genes in **columns** (N samples x M genes). Use `t()` to transpose if necessary.
* **Module Assignment**: If you already have module assignments from WGCNA, you can pass them directly to `compute.pigenegene` instead of running the full `one.step.pigengene`.
* **Sparsity**: Bayesian Network inference can be computationally expensive. Pigengene handles this by using the reduced dimensionality of eigengenes, but ensure you have a reasonable number of modules (usually 10-50) for optimal performance.
* **Categorical Variables**: When building the Bayesian Network, the package can handle both the continuous pigengene values and categorical clinical labels. Ensure your labels are formatted as factors.
* **Output**: `one.step.pigengene` generates several files in the `saveDir`, including plots of the modules, the Bayesian Network structure, and cross-validation results.

## Reference documentation
None