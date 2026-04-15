---
name: bioconductor-metahdep
description: This package performs hierarchical meta-analysis for gene expression data using models that account for complex dependence structures. Use when user asks to perform gene expression meta-analysis, map probesets to gene identifiers, calculate effect sizes from AffyBatch objects, or apply fixed and random effects models with delta-splitting for hierarchical clustering.
homepage: https://bioconductor.org/packages/release/bioc/html/metahdep.html
---

# bioconductor-metahdep

## Overview

The `metahdep` package implements hierarchical meta-analysis models designed to handle complex dependence structures. It is particularly useful for gene expression meta-analysis where multiple probesets map to the same gene, or multiple tissues are compared within the same study. It supports Fixed Effects (FEMA), Random Effects (REMA), and Hierarchical Bayes (HBLM) models, with the ability to "split" the variance components to account for hierarchical clustering (delta-splitting).

## Core Workflows

### 1. Gene Expression Workflow
This workflow is used when starting with AffyBatch objects and mapping probesets to common gene identifiers.

**Step A: Map Probesets**
Create a mapping data frame to resolve many-to-many relationships.
```r
# Required columns: chip, old.name, new.name
newnames <- data.frame(
  chip = c(rep("hgu133a", length(ids1)), rep("hgu95a", length(ids2))),
  old.name = c(ids1, ids2),
  new.name = c(entrez1, entrez2)
)
```

**Step B: Calculate Effect Sizes (ES.obj)**
Use `getPLM.es()` to convert raw data into effect size objects.
```r
library(metahdep)
# trt1/trt2 are lists of indices for control/treatment arrays
es_study1 <- getPLM.es(abatch = MLL.A, 
                       trt1 = list(c(1:5), c(6:10)), 
                       trt2 = list(c(11:15), c(16:20)), 
                       covariates = data.frame(Tissue = c(0, 1)), 
                       dep.grp = 1)
```

**Step C: Format and Run Meta-Analysis**
```r
# Combine ES.obj into a list
prep_list <- metahdep.format(list(es_study1, es_study2), newnames)

# Run meta-analysis (e.g., Random Effects with delta-splitting)
results <- metahdep(prep_list, method = "REMA", delta.split = TRUE, center.X = TRUE)
```

### 2. General Meta-Analysis Workflow
Use this when you already have effect size estimates ($\theta$), a covariance matrix ($V$), and a design matrix ($X$).

```r
# Define dependence groups for delta-splitting (indices of related studies)
dep_groups <- list(c(2,3,4,5), c(10,11,12))

# Fixed Effects
fema_res <- metahdep.FEMA(theta, V, X, center.X = TRUE)

# Random Effects (with delta-splitting)
rema_res <- metahdep.REMA(theta, V, X, delta.split = TRUE, dep.groups = dep_groups)

# Hierarchical Bayes
hblm_res <- metahdep.HBLM(theta, V, X, two.sided = TRUE, delta.split = TRUE, dep.groups = dep_groups)
```

## Key Functions and Parameters

- `metahdep()`: High-level wrapper for gene expression lists.
- `metahdep.FEMA()`, `metahdep.REMA()`, `metahdep.HBLM()`: Core statistical engines.
- `delta.split = TRUE`: Accounts for hierarchical dependence (e.g., studies from the same lab).
- `center.X = TRUE`: Centers non-intercept covariates so the Intercept represents the population mean effect size.
- `two.sided = TRUE`: (HBLM only) Converts posterior probabilities into two-sided p-values.

## Interpreting Results

The output is typically a `data.frame` where:
- `Intercept.estimate`: The pooled effect size.
- `Intercept.pval`: Significance of the pooled effect.
- `tau2.hat`: Estimated between-study variance.
- `varsigma.hat`: (Delta-split models) Estimated variance component for hierarchical dependence.

## Reference documentation
- [metahdep: hierarchical dependence in meta-analysis](./references/metahdep.md)