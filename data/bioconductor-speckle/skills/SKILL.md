---
name: bioconductor-speckle
description: The speckle package provides statistical methods for analyzing differences in cell type proportions in single-cell RNA-seq data using linear modeling and empirical Bayes shrinkage. Use when user asks to test for compositional changes, analyze cell type proportions across experimental conditions, or visualize mean-variance relationships in single-cell data.
homepage: https://bioconductor.org/packages/release/bioc/html/speckle.html
---

# bioconductor-speckle

## Overview

The `speckle` package provides a suite of statistical methods for analyzing differences in cell type proportions in single-cell RNA-seq data. Its core method, `propeller`, uses linear modeling and empirical Bayes shrinkage (via `limma`) to test for compositional changes while accounting for biological and technical variability. It is designed for experiments with multiple biological replicates per group.

## Core Workflow

### 1. Data Preparation
`speckle` works with `SingleCellExperiment` or `Seurat` objects. It requires three pieces of information for every cell:
- **Cluster**: The cell type or cluster assignment.
- **Sample**: The biological replicate/sample ID.
- **Group**: The experimental condition (e.g., Control vs. Treatment).

### 2. Running Propeller
The `propeller` function is the primary interface. It automatically extracts metadata from supported objects if columns are named "cluster", "sample", and "group".

```r
library(speckle)

# Basic usage with a SingleCellExperiment or Seurat object
# Default uses logit transformation
results <- propeller(sce_object)

# Using arcsin square root transformation
results_asin <- propeller(sce_object, transform = "asin")

# Manual specification if metadata names differ
results_manual <- propeller(clusters = sce_object$cell_type, 
                            sample = sce_object$donor, 
                            group = sce_object$condition)
```

### 3. Visualization
`speckle` provides functions to visualize proportions and mean-variance relationships.

```r
# Plot barplots of cell type proportions across samples
plotCellTypeProps(sce_object)

# Get transformed proportions for custom plotting
props <- getTransformedProps(sce_object$cluster, sce_object$sample)
barplot(props$Proportions, col = rainbow(nrow(props$Proportions)), legend = TRUE)

# Check mean-variance relationship
plotCellTypeMeanVar(props$Counts)
```

## Advanced Experimental Designs

For designs involving covariates, continuous variables, or random effects, use the modular functions `getTransformedProps`, `propeller.anova`, and `propeller.ttest`.

### Linear Models with Covariates
```r
# 1. Extract proportions
props <- getTransformedProps(clusters, sample)

# 2. Define design matrix (No intercept, group first)
design <- model.matrix(~ 0 + group + covariate)

# 3. Run ANOVA (for >2 groups) or t-test
# Test first 3 columns of design
res_anova <- propeller.anova(prop.list = props, design = design, coef = c(1,2,3))

# Test specific contrast
library(limma)
contr <- makeContrasts(groupA - groupB, levels = design)
res_ttest <- propeller.ttest(props, design, contrasts = contr)
```

### Random Effects (Repeated Measures)
Use `limma::duplicateCorrelation` to account for random effects like multiple samples from the same individual.

```r
design <- model.matrix(~ group)
dupcor <- duplicateCorrelation(props$TransformedProps, design = design, block = individual_id)

fit <- lmFit(props$TransformedProps, design = design, block = individual_id, correlation = dupcor$consensus)
fit <- eBayes(fit)
topTable(fit)
```

## Tips for Success
- **Replication**: `propeller` requires biological replicates (minimum n=2 in one group) to estimate variance.
- **Zero Proportions**: The method handles 0 and 1 values gracefully via transformations.
- **Clustering**: Ensure clusters are biologically meaningful. If clusters are too refined (unique to specific samples), consider broader cell type categories for more robust statistical power.
- **Integration**: Use integration methods (Harmony, Seurat) before clustering to ensure cell types are represented across samples.

## Reference documentation

- [speckle: statistical methods for analysing single cell RNA-seq data](./references/speckle.md)