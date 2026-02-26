---
name: bioconductor-adverscarial
description: This tool evaluates the robustness of scRNA-seq cell-type classifiers by generating and testing adversarial perturbations. Use when user asks to perform single-gene attacks, execute max-change modifications, or run cluster gradient descent to assess classifier vulnerability.
homepage: https://bioconductor.org/packages/release/bioc/html/adverSCarial.html
---


# bioconductor-adverscarial

name: bioconductor-adverscarial
description: Tools for generating and evaluating adversarial attacks on scRNA-seq classifiers. Use this skill to assess the robustness of single-cell RNA sequencing cell-type classifiers using single-gene, max-change, and Cluster Gradient Descent (CGD) attacks.

# bioconductor-adverscarial

## Overview
The `adverSCarial` package provides a framework to evaluate the vulnerability of scRNA-seq classifiers to adversarial perturbations. It supports three primary attack types:
1. **Single-gene attack**: Smallest modification (one gene) to change a cell's classification.
2. **Max-change attack**: Largest possible modification to the input without changing the classification (testing over-confidence).
3. **Cluster Gradient Descent (CGD)**: Gradient-based iterative modification to switch cluster classification.

## Core Workflow

### 1. Data Preparation
Load scRNA-seq data (typically as a matrix or SingleCellExperiment) and existing cell type annotations.

```r
library(adverSCarial)
library(LoomExperiment)

# Load example data
pbmcPath <- system.file("extdata", "pbmc_short.loom", package="adverSCarial")
lfile <- import(pbmcPath, type="SingleCellLoomExperiment")
matPbmc <- counts(lfile)
cellTypes <- rowData(lfile)$cell_type
```

### 2. Formatting Classifiers
To use a custom classifier (e.g., CHETAH, scType, or Random Forest), it must be wrapped in a function that returns a specific format:

```r
# Required format:
# c(prediction = "cell_type_label", odd = confidence_score)
# For CGD, also include typePredictions (matrix) and cellTypes (vector)

my_classifier <- function(expr, clusters, target) {
    # ... classification logic ...
    return(c(prediction = pred, odd = score))
}
```

### 3. Executing Attacks

#### Single-Gene Attack
Finds if modifying one gene (e.g., to its 99th percentile) can flip the classification.

```r
genesMinChange <- advSingleGene(
    matPbmc, 
    cellTypes, 
    targetCluster = "DC",
    classifier = MClassifier, 
    advMethod = "perc99",
    exclGenes = marker_list,
    returnFirstFound = TRUE
)
```

#### Max-Change Attack
Identifies how many genes can be "corrupted" before the classifier notices.

```r
genesMaxChange <- advMaxChange(
    matPbmc, 
    cellTypes, 
    "Memory CD4 T", 
    MClassifier,
    advMethod = "perc99"
)
```

#### Cluster Gradient Descent (CGD)
A more powerful attack that follows an approximated gradient.

```r
resCGD <- advCGD(
    as.data.frame(matPbmc), 
    cellTypes,
    "Memory CD4 T", 
    MClassifier, 
    alpha = 1, 
    epsilon = 1
)
```

### 4. Applying and Verifying Perturbations
Use `advModifications` to generate the "attacked" matrix and re-run the classifier to verify success.

```r
# Apply modifications found in attack
matAdver <- advModifications(matPbmc, names(genesMinChange@values), cellTypes, "DC")

# Verify
resClassif <- MClassifier(matAdver, cellTypes, "DC")
```

## Vulnerability Overview
Use `singleGeneOverview` and `maxChangeOverview` to quickly screen which cell types or classifiers are most susceptible across different modification types.

```r
min_change_summary <- singleGeneOverview(
    matPbmc, 
    cellTypes, 
    MClassifier,
    modifications = list(c("perc1"), c("perc99"))
)
```

## Reference documentation
- [adverSCarial: Generate and analyze vulnerability](./references/vign01_adverSCarial.md)
- [Vulnerability analysis overview](./references/vign02_overView_analysis.md)
- [Adapting classifiers for adverSCarial](./references/vign03_adapt_classifier.md)
- [Advanced Random Walk attacks](./references/vign04_advRandWalkMinChange.md)